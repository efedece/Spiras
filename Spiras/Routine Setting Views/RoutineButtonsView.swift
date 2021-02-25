//
//  RoutineButtonsView.swift
//  Spiras
//
//  Created by Fernando Jose Del Campo Guerola on 12/27/20.
//

import SwiftUI

struct RoutineButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineButtonsView(
            breatheIn: .constant(SingleRoutine.data[0].data.breatheIn),
            holdIn: .constant(SingleRoutine.data[0].data.holdIn),
            breatheOut: .constant(SingleRoutine.data[0].data.breatheOut),
            holdOut: .constant(SingleRoutine.data[0].data.holdOut),
            numberOfCycles: .constant(SingleRoutine.data[0].data.numberOfCycles),
            vibrationOn: .constant(SingleRoutine.data[0].data.vibrationOn),
            soundOn: .constant(SingleRoutine.data[0].data.soundOn)
        )
            .previewLayout(.fixed(width: .infinity, height: 100))
    }
}

struct RoutineButtonsView: View {
    @Binding var breatheIn: Int
    @Binding var holdIn: Int
    @Binding var breatheOut: Int
    @Binding var holdOut: Int
    @Binding var numberOfCycles: Double
    @Binding var vibrationOn: Bool
    @Binding var soundOn: Bool
    @State var sessionOn = false
    @StateObject var sessionTimer = SessionTimer()

    var body: some View {
        HStack {
            // Start Button
            Button(
                action: {
                    if sessionTimer.timerState == .notSet {
                        // Set timer & run
                        sessionTimer.setTimer(breatheIn: breatheIn, holdIn: holdIn, breatheOut: breatheOut, holdOut: holdOut, numberOfCycles: Int(numberOfCycles),  vibrationOn: vibrationOn, soundOn: soundOn)
                    }
                    sessionTimer.timerState = .running
                    sessionTimer.run()
                    sessionOn = true
                }, label: {
                    HStack(spacing: Constants.smallSpacing) {
                        Image(systemName: "play.fill")
                            .foregroundColor(.white)
                        if sessionTimer.timerState == .notSet {
                            Text("Start session")
                                .foregroundColor(.white)
                        } else {
                            Text("Resume session")
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.vertical, Constants.mediumSpacing)
                    .frame(width: UIScreen.main.bounds.width/2   - Constants.largeSpacing)
                    .background(Constants.buttonColor)
                    .clipShape(Capsule())
                    .shadow(radius: 6)
                })
            if sessionTimer.timerState != .notSet {
                // Restart Button
                Button(action: {
                    sessionTimer.reset()
                    sessionTimer.timerState = .running
                    sessionTimer.run()
                    sessionOn = true    
                }, label: {
                    HStack(spacing: Constants.smallSpacing) {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.white)
                        Text("Restart session")
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, Constants.mediumSpacing)
                    .frame(width: UIScreen.main.bounds.width/2 - Constants.largeSpacing)
                    .background(Constants.buttonColor)
                    .clipShape(Capsule())
                    .shadow(radius: 6)
                })
            }
        }
        .fullScreenCover(isPresented: $sessionOn) {
            SessionView(
                breatheIn: $breatheIn,
                holdIn: $holdIn,
                breatheOut: $breatheOut,
                holdOut: $holdOut,
                numberOfCycles: $numberOfCycles,
                vibrationOn: $vibrationOn,
                soundOn: $soundOn,
                timerState: $sessionTimer.timerState,
                sessionSecondsLeft: $sessionTimer.sessionSecondsLeft,
                cycleStepSecondsLeft: $sessionTimer.cycleStepSecondsLeft,
                cyclesLeft: $sessionTimer.cyclesLeft,
                cycleStepSeconds: $sessionTimer.cycleStepSeconds,
                cycleColor: $sessionTimer.cycleStepColor,
                cycleStep: $sessionTimer.cycleStep
            ) { (timerMode: TimerMode) -> Void in
                if timerMode == .paused {
                    sessionTimer.pause()
                } else if timerMode == .running {
                    sessionTimer.run()
                }
            }
        }
    }
}

