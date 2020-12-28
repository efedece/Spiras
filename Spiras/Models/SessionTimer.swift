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


//class SessionTimer: ObservableObject {
//    
////    private var autosaveCancellable: AnyCancellable?
//    
//    // Breathe cycle settings variables
//    @Published var settingsVars: SingleRoutine { didSet {
//        cycleLength = settingsVars.breatheIn + settingsVars.holdIn + settingsVars.breatheOut + settingsVars.holdOut
//        sessionLength = Int(settingsVars.numberOfCycles) * cycleLength
////        autosaveCancellable = $settingsVars.sink { exerciseList in self.save(exerciseList) }
//    } }
//    var cycleLength: Int = 0
//    var sessionLength: Int = 0
//
//    // Timer variables
//    @Published var timer = Timer()
//    @Published var timerMode: TimerMode = .notRunning
//    @Published var secondsLeftSession: Double = 0
//    @Published var secondsLeftStep: Double = 0
//    @Published var cyclesLeft: Int = 0
//    
//    // Animation variables
//    var secondsStep: Double = 0
//    var cycleBarTo : CGFloat = 0
//    var cycleBarFrom: Bool = true
//    var cycleColor : Color = Color(.white)
//    var cycleStep: CycleStep = .breatheIn
//    
//    var soundGenerator: AVPlayer { AVPlayer.sharedDingPlayer }
//    let vibrationGenerator = UINotificationFeedbackGenerator()
//    @State private var vibrationGeneratorAdvanced: CHHapticEngine?
//
//    @Published var exerciseFinished = false
//    
//    
//    init(id: UUID? = nil) {
//        self.id = id ?? UUID()
//        let defaultsKey = "SpirasExercise.\(self.id.uuidString)"
//        settingsVars = ExerciseCycleModel(json: UserDefaults.standard.data(forKey: defaultsKey)) ?? ExerciseCycleModel()
//        autosaveCancellable = $settingsVars.sink { exerciseSettingVars in
//            UserDefaults.standard.set(exerciseSettingVars.json, forKey: defaultsKey)
//        }
//    }
//
//    init(url: URL) {
//        self.id = UUID()
//        self.url = url
//        self.settingsVars = ExerciseCycleModel(json: try? Data(contentsOf: url)) ?? ExerciseCycleModel()
//        autosaveCancellable = $settingsVars.sink { exerciseSettingVars in self.save(exerciseSettingVars) }
//
//        self.cycleLength = settingsVars.breatheIn + settingsVars.holdIn + settingsVars.breatheOut + settingsVars.holdOut
//        self.sessionLength = Int(settingsVars.numberOfCycles) * cycleLength
//    }
//    
//    // MARK: - Intents
////    private func save(_ exerciseCycleVars: SingleRoutine) {
////        if url != nil {
////            try? exerciseCycleVars.json?.write(to: url!)
////        }
////    }
//        
//    func setTimerLength(numberOfCycles: Double, breatheIn: Int, holdIn: Int, breatheOut: Int, holdOut: Int) {
//        settingsVars.numberOfCycles = numberOfCycles
//        settingsVars.breatheIn = breatheIn
//        settingsVars.holdIn = holdIn
//        settingsVars.breatheOut = breatheOut
//        settingsVars.holdOut = holdOut
//        cycleLength = breatheIn + holdIn + breatheOut + holdOut
//        sessionLength = cycleLength * Int(numberOfCycles)
//        secondsLeftSession = Double(sessionLength)
//        cyclesLeft = Int(numberOfCycles)
//        secondsStep = Double(breatheIn)
//        secondsLeftStep = Double(breatheIn)
//        cycleBarTo = 0
//        cycleBarFrom = true
//        cycleColor = breatheInColor
//    }
//    
//    func start() {
//        timerMode = .running
//        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {
//            [self] timer in
//            RunLoop.current.add(timer, forMode: .common)
//            timer.tolerance = 0.01
//            if secondsLeftSession.rounded(.up) == 0.00 {
//                exerciseFinished = true
//                self.reset()
//            }
//            secondsLeftSession -= 0.01
//            secondsLeftStep -= 0.01
//            
//            withAnimation(.default){
//                cycleBarTo = cycleBarFrom ? (1 - CGFloat(secondsLeftStep) / CGFloat(secondsStep)) : (CGFloat(secondsLeftStep) / CGFloat(secondsStep)) }
//            if secondsLeftStep.rounded(.up) == 0.0 {
//                
//                if settingsVars.soundOn == true {
//                    soundGenerator.seek(to: .zero)
//                    soundGenerator.play()
//                }
//                
//                if settingsVars.vibrationOn == true {
//                    vibrationGenerator.notificationOccurred(.success)
//                    vibrate()
//                }
//                
//                cycleBarFrom.toggle()
//                switch cycleStep {
//                case .breatheIn:
//                    if settingsVars.holdIn != 0 {
//                        secondsStep = Double(settingsVars.holdIn)
//                        secondsLeftStep = Double(settingsVars.holdIn)
//                        cycleStep = .holdIn
//                        cycleColor = holdInColor
//                    } else {
//                        secondsStep = Double(settingsVars.breatheOut)
//                        secondsLeftStep = Double(settingsVars.breatheOut)
//                        cycleStep = .breatheOut
//                        cycleColor = breatheOutColor
//                    }
//                case .holdIn:
//                    secondsStep = Double(settingsVars.breatheOut)
//                    secondsLeftStep = Double(settingsVars.breatheOut)
//                    cycleStep = .breatheOut
//                    cycleColor = breatheOutColor
//                case .breatheOut:
//                    if settingsVars.holdOut != 0 {
//                        secondsStep = Double(settingsVars.holdOut)
//                        secondsLeftStep = Double(settingsVars.holdOut)
//                        cycleStep = .holdOut
//                        cycleColor = holdOutColor
//                    } else {
//                        cyclesLeft -= 1
//                        secondsStep = Double(settingsVars.breatheIn)
//                        secondsLeftStep = Double(settingsVars.breatheIn)
//                        cycleStep = .breatheIn
//                        cycleColor = breatheInColor
//                    }
//                case .holdOut:
//                    cyclesLeft -= 1
//                    secondsStep = Double(settingsVars.breatheIn)
//                    secondsLeftStep = Double(settingsVars.breatheIn)
//                    cycleStep = .breatheIn
//                    cycleColor = breatheInColor
//                }
//            }
//        })
//    }
//
//    func pause() {
//        timerMode = .paused
//        timer.invalidate()
//    }
//    
//    func reset() {
//        timerMode = .notRunning
//        secondsLeftSession = Double(sessionLength)
//        cyclesLeft = Int(settingsVars.numberOfCycles)
//        secondsLeftStep = Double(settingsVars.breatheIn)
//        secondsStep  = Double(settingsVars.breatheIn)
//        cycleStep = .breatheIn
//        cycleColor = breatheInColor
//        cycleBarFrom = true
//        withAnimation(.default){ cycleBarTo = 0 }
//        timer.invalidate()
//    }
//    
//    func vibrate() {
//        // make sure that the device supports haptics
//        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
//
//        var events = [CHHapticEvent]()
//
//        // create one intense, sharp tap
//        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
//        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
//        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
//        events.append(event)
//
//        // convert those events into a pattern and play it immediately
//        do {
//            let pattern = try CHHapticPattern(events: events, parameters: [])
//            let player = try vibrationGeneratorAdvanced?.makePlayer(with: pattern)
//            try player?.start(atTime: 0)
//        } catch {
//            print("Failed to play pattern: \(error.localizedDescription).")
//        }
//    }
//    
//    private let breatheInColor = Color("background5")
//    private let holdInColor = Color("background7")
//    private let breatheOutColor = Color("background9")
//    private let holdOutColor = Color("background10")
//}
//
//
//// MARK: - Timer
//enum TimerMode {
//    case notRunning
//    case running
//    case paused
//}
//
//enum CycleStep : CustomStringConvertible {
//    case breatheIn
//    case holdIn
//    case breatheOut
//    case holdOut
//      
//    var description : String {
//        switch self {
//        case .breatheIn: return "Breathe In"
//        case .holdIn: return "Hold In"
//        case .breatheOut: return "Breathe Out"
//        case .holdOut: return "Hold Out"
//        }
//    }
//}
//
//func secondsToMinutesAndSeconds(_ seconds: Int) -> String {
//    let minutes = "\((seconds % 3600) / 60)"
//    let seconds = "\((seconds % 3600) % 60)"
//    let minuteStamp = minutes.count > 1 ? minutes : "0" + minutes
//    let secondStamp = seconds.count > 1 ? seconds : "0" + seconds
//    
//    return "\(minuteStamp) : \(secondStamp)"
//}
