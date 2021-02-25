//
//  SessionButtonsView.swift
//  Spiras
//
//  Created by Fernando Jose Del Campo Guerola on 12/27/20.
//

import SwiftUI

struct SessionButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        SessionButtonsView(
            timerMode: .constant(.running),
            buttonAction: {(timerMode: TimerMode) -> Void in }
        )
        .previewLayout(.fixed(width: .infinity, height: 100))
    }
}

// Codigo de SessionView
//                // Pause / play button
//                SessionButtonsView(timerMode: $timerState) { (timerMode: TimerMode) -> Void in
//                    return buttonAction(timerMode) // Pause / resume timer
//                }
//                    .padding(.vertical, Constants.mediumSpacing)


struct SessionButtonsView: View {
    @Binding var timerMode: TimerMode
    let buttonAction: (TimerMode) -> Void

    var body: some View {
        HStack(spacing: Constants.mediumSpacing) {
            // Play - Pause Button
            Button(action: {
                if timerMode == .running {
                    timerMode = .paused
                } else {
                    timerMode = .running
                }
                buttonAction(timerMode)
            }) {
                HStack(spacing: Constants.smallSpacing) {
                    Image(systemName: timerMode == .running ? "pause.fill" : "play.fill")
                        .foregroundColor(.white)
                    Text(timerMode == .running ? "Pause" : "Play")
                        .foregroundColor(.white)
                }
                .padding(.vertical, Constants.mediumSpacing)
                .frame(width: UIScreen.main.bounds.width/2   - Constants.veryLargeSpacing)
                .background(Constants.buttonColor)
                .clipShape(Capsule())
                .shadow(radius: 6)
            }
        }
        .padding(EdgeInsets(top: Constants.largeSpacing, leading: 0, bottom: Constants.largeSpacing, trailing: 0))
    }
}
