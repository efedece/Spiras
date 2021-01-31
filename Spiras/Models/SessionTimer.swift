//
//  SessionTimer.swift
//  Spiras
//
//  Created by Fernando Jose Del Campo Guerola on 12/25/20.
//

import Foundation
import SwiftUI
import CoreHaptics
import Combine
import UserNotifications
import AVFoundation


class SessionTimer: ObservableObject {
        
    // Breathe cycle settings variables
    private var breatheIn: Int
    private var holdIn: Int
    private var breatheOut: Int
    private var holdOut: Int
    private var cycleLength: Int
    private var numberOfCycles: Int
    private var sessionLength: Int
    private var vibrationOn: Bool
    private var soundOn: Bool

    // Timer variables
    @Published var timer: Timer?
    @Published var timerState: TimerMode
    @Published var secondsLeftSession: Double
    @Published var secondsLeftStep: Double
    @Published var cyclesLeft: Int
    
    // Animation variables
    var secondsStep: Double = 0
    var cycleBarTo : CGFloat = 0
    var cycleBarFrom: Bool = true
    var cycleColor : Color = Color(.white)
    var cycleStep: CycleStep = .breatheIn
    
    var soundGenerator: AVPlayer { AVPlayer.sharedDingPlayer }
    let vibrationGenerator = UINotificationFeedbackGenerator()
    @State private var vibrationGeneratorAdvanced: CHHapticEngine?

    init() {
        breatheIn = 0
        holdIn = 0
        breatheOut = 0
        holdOut = 0
        numberOfCycles = 0
        cycleLength = breatheIn + holdIn + breatheOut + holdOut
        sessionLength = cycleLength * numberOfCycles
        secondsLeftSession = Double(sessionLength)
        cyclesLeft = numberOfCycles
        secondsStep = Double(breatheIn)
        secondsLeftStep = Double(breatheIn)
        vibrationOn = false
        soundOn = false
        cycleBarTo = 0
        cycleBarFrom = true
        cycleColor = Constants.breatheInColor
        timerState = .notSet
    }
    
    // MARK: - Intents
    func setTimer(breatheIn: Int, holdIn: Int, breatheOut: Int, holdOut: Int, numberOfCycles: Int, vibrationOn: Bool, soundOn: Bool) {
        self.breatheIn = breatheIn
        self.holdIn = holdIn
        self.breatheOut = breatheOut
        self.holdOut = holdOut
        self.numberOfCycles = numberOfCycles
        cycleLength = breatheIn + holdIn + breatheOut + holdOut
        sessionLength = cycleLength * numberOfCycles
        secondsLeftSession = Double(sessionLength)
        cyclesLeft = numberOfCycles
        secondsStep = Double(breatheIn)
        secondsLeftStep = Double(breatheIn)
        self.vibrationOn = vibrationOn
        self.soundOn = soundOn
        cycleBarTo = 0
        cycleBarFrom = true
        cycleColor = Constants.breatheInColor
    }
    
    func run() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {
            [self] timer in
            RunLoop.current.add(timer, forMode: .common)
            timer.tolerance = 0.01
            if secondsLeftSession.rounded(.up) == 0.00 {
                timerState = .finished
                withAnimation(.default){ cycleBarTo = 0 }
                timer.invalidate()
//                self.reset()
            }
            secondsLeftSession -= 0.01
            secondsLeftStep -= 0.01
            
            withAnimation(.default){
                cycleBarTo = cycleBarFrom ? (1 - CGFloat(secondsLeftStep) / CGFloat(secondsStep)) : (CGFloat(secondsLeftStep) / CGFloat(secondsStep)) }
            if secondsLeftStep.rounded(.up) == 0.0 {
                
                if soundOn == true {
                    soundGenerator.seek(to: .zero)
                    soundGenerator.play()
                }
                
                if vibrationOn == true {
                    vibrationGenerator.notificationOccurred(.success)
                    vibrate()
                }
                
                cycleBarFrom.toggle()
                switch cycleStep {
                case .breatheIn:
                    if holdIn != 0 {
                        secondsStep = Double(holdIn)
                        secondsLeftStep = Double(holdIn)
                        cycleStep = .holdIn
                        cycleColor = Constants.holdInColor
                    } else {
                        secondsStep = Double(breatheOut)
                        secondsLeftStep = Double(breatheOut)
                        cycleStep = .breatheOut
                        cycleColor = Constants.breatheOutColor
                    }
                case .holdIn:
                    secondsStep = Double(breatheOut)
                    secondsLeftStep = Double(breatheOut)
                    cycleStep = .breatheOut
                    cycleColor = Constants.breatheOutColor
                case .breatheOut:
                    if holdOut != 0 {
                        secondsStep = Double(holdOut)
                        secondsLeftStep = Double(holdOut)
                        cycleStep = .holdOut
                        cycleColor = Constants.holdOutColor
                    } else {
                        cyclesLeft -= 1
                        secondsStep = Double(breatheIn)
                        secondsLeftStep = Double(breatheIn)
                        cycleStep = .breatheIn
                        cycleColor = Constants.breatheInColor
                    }
                case .holdOut:
                    cyclesLeft -= 1
                    secondsStep = Double(breatheIn)
                    secondsLeftStep = Double(breatheIn)
                    cycleStep = .breatheIn
                    cycleColor = Constants.breatheInColor
                }
            }
        })
    }

    func pause() {
        timer?.invalidate()
    }
    
    func reset() {
        timerState = .paused // FIXME: Correguir estado
        secondsLeftSession = Double(sessionLength)
        cyclesLeft = Int(numberOfCycles)
        secondsLeftStep = Double(breatheIn)
        secondsStep  = Double(breatheIn)
        cycleStep = .breatheIn
        cycleColor = Constants.breatheInColor
        cycleBarFrom = true
        withAnimation(.default){ cycleBarTo = 0 }
        timer?.invalidate()
    }
    
    func vibrate() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        var events = [CHHapticEvent]()

        // create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try vibrationGeneratorAdvanced?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}


// MARK: - Timer
enum TimerMode {
    case notSet
    case paused
    case running
    case finished
}

enum CycleStep : CustomStringConvertible {
    case breatheIn
    case holdIn
    case breatheOut
    case holdOut
      
    var description : String {
        switch self {
        case .breatheIn: return "Breathe In"
        case .holdIn: return "Hold In"
        case .breatheOut: return "Breathe Out"
        case .holdOut: return "Hold Out"
        }
    }
}
