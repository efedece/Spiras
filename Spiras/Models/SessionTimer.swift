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
    @Published var cyclesLeft: Int
    @Published var sessionSecondsLeft: Double
    @Published var cycleStepSecondsLeft: Double
    
    // Animation variables
    var cycleStep: CycleStep
    var cycleStepSeconds: Double = 0.0
    var cycleStepColor : Color = Color(.white)
    
    var soundGenerator: AVPlayer { AVPlayer.sharedDingPlayer }
    let vibrationGenerator = UINotificationFeedbackGenerator()
    @State private var vibrationGeneratorAdvanced: CHHapticEngine?

    init() {
        breatheIn = 0
        holdIn = 0
        breatheOut = 0
        holdOut = 0
        cycleLength = breatheIn + holdIn + breatheOut + holdOut
        numberOfCycles = 0
        sessionLength = cycleLength * numberOfCycles

        vibrationOn = false
        soundOn = false

        cyclesLeft = numberOfCycles
        sessionSecondsLeft = Double(sessionLength)

        cycleStep = .breatheIn
        cycleStepSeconds = Double(breatheIn)
        cycleStepSecondsLeft = Double(breatheIn)
        cycleStepColor = Constants.breatheInColor
        
        timerState = .notSet
    }
    
    // MARK: - Intents
    func setTimer(breatheIn: Int, holdIn: Int, breatheOut: Int, holdOut: Int, numberOfCycles: Int, vibrationOn: Bool, soundOn: Bool) {
        self.breatheIn = breatheIn
        self.holdIn = holdIn
        self.breatheOut = breatheOut
        self.holdOut = holdOut
        cycleLength = breatheIn + holdIn + breatheOut + holdOut
        self.numberOfCycles = numberOfCycles
        sessionLength = cycleLength * numberOfCycles
        
        self.vibrationOn = vibrationOn
        self.soundOn = soundOn
        
        cyclesLeft = numberOfCycles
        sessionSecondsLeft = Double(sessionLength)
        
        cycleStep = .breatheIn
        cycleStepSeconds = Double(breatheIn)
        cycleStepSecondsLeft = Double(breatheIn)
        cycleStepColor = Constants.breatheInColor

        timerState = .set
}
    
    func run() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {
            [self] timer in
            RunLoop.current.add(timer, forMode: .common)
            timer.tolerance = 0.01
            if sessionSecondsLeft.rounded(.up) == 0.00 {
                timerState = .finished
                reset()
            }
            sessionSecondsLeft -= 0.01
            cycleStepSecondsLeft -= 0.01
            
            if cycleStepSecondsLeft.rounded(.up) == 0.0 {
                
                if soundOn == true {
                    soundGenerator.seek(to: .zero)
                    soundGenerator.play()
                }
                
                if vibrationOn == true {
                    vibrationGenerator.notificationOccurred(.success)
                    vibrate()
                }
                
                switch cycleStep {
                case .breatheIn:
                    if holdIn != 0 {
                        cycleStep = .holdIn
                        cycleStepSeconds = Double(holdIn)
                        cycleStepColor = Constants.holdInColor
                    } else {
                        cycleStep = .breatheOut
                        cycleStepSeconds = Double(breatheOut)
                        cycleStepColor = Constants.breatheOutColor
                    }
                case .holdIn:
                    cycleStep = .breatheOut
                    cycleStepSeconds = Double(breatheOut)
                    cycleStepColor = Constants.breatheOutColor
                case .breatheOut:
                    if holdOut != 0 {
                        cycleStep = .holdOut
                        cycleStepSeconds = Double(holdOut)
                        cycleStepColor = Constants.holdOutColor
                    } else {
                        cycleStep = .breatheIn
                        cycleStepSeconds = Double(breatheIn)
                        cycleStepColor = Constants.breatheInColor
                        cyclesLeft -= 1
                    }
                case .holdOut:
                    cycleStep = .breatheIn
                    cycleStepSeconds = Double(breatheIn)
                    cycleStepColor = Constants.breatheInColor
                    cyclesLeft -= 1
                }
                cycleStepSecondsLeft = cycleStepSeconds
            }
        })
    }

    func pause() {
        timer?.invalidate()
    }
    
    func reset() {

        cyclesLeft = Int(numberOfCycles)
        sessionSecondsLeft = Double(sessionLength)
        
        cycleStep = .breatheIn
        cycleStepSeconds  = Double(breatheIn)
        cycleStepSecondsLeft = Double(breatheIn)
        cycleStepColor = Constants.breatheInColor
        
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
    case set
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
