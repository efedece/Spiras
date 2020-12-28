//
//  SessionButtonsView.swift
//  Spiras
//
//  Created by Fernando Jose Del Campo Guerola on 12/27/20.
//

import SwiftUI

struct SessionButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        SessionButtonsView()
            .previewLayout(.fixed(width: .infinity, height: 100))
    }
}

struct SessionButtonsView: View {
//    $timer: SessionTimer
    var body: some View {
        HStack(spacing: Constants.mediumSpacing) {
            // Play - Pause Button
            Button(action: {
//                if exercisePlan.timerMode == .notRunning {
//                    exercisePlan.setTimerLength(numberOfCycles: exercisePlan.settingsVars.numberOfCycles, breatheIn: exercisePlan.settingsVars.breatheIn, holdIn: exercisePlan.settingsVars.holdIn, breatheOut: exercisePlan.settingsVars.breatheOut, holdOut: exercisePlan.settingsVars.holdOut)
//                }
//                exercisePlan.timerMode == .running ? exercisePlan.pause() : exercisePlan.start()
            }) {
                HStack(spacing: Constants.smallSpacing) {
//                    Image(systemName: exercisePlan.timerMode == .running ? "pause.fill" : "play.fill")
                    Image(systemName: "pause.fill")
                        .foregroundColor(.white)
                        
//                    Text(exercisePlan.timerMode == .running ? "Pause" : "Play")
                        Text("Pause session")
                        .foregroundColor(.white)
                }
                .padding(.vertical, Constants.mediumSpacing)
                .frame(width: UIScreen.main.bounds.width/2   - Constants.veryLargeSpacing)
                .background(Color("background8"))
                .clipShape(Capsule())
                .shadow(radius: 6)
            }
            
            // Restart Button
//            if exercisePlan.timerMode != .notRunning {
                Button(action: {
//                    exercisePlan.reset()
                }) {
                    HStack(spacing: Constants.smallSpacing) {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(Color("background8"))
                        Text("Restart session")
                            .foregroundColor(Color("background8"))
                    }
                    .padding(.vertical, Constants.mediumSpacing)
                    .frame(width: UIScreen.main.bounds.width/2 - Constants.veryLargeSpacing)
                    .background(Capsule().stroke(Color("background8"), lineWidth: 2))
                    .shadow(radius: 6)
                }
//            }
        }
        .padding(EdgeInsets(top: Constants.largeSpacing, leading: 0, bottom: Constants.largeSpacing, trailing: 0))
    }
}
