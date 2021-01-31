//
//  SessionButtonsView.swift
//  Spiras
//
//  Created by Fernando Jose Del Campo Guerola on 12/27/20.
//

import SwiftUI

struct SessionButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        SessionButtonsView(timerMode: .constant(.running))
            .previewLayout(.fixed(width: .infinity, height: 100))
    }
}

struct SessionButtonsView: View {
    @Binding var timerMode: TimerMode

    var body: some View {
        HStack(spacing: Constants.mediumSpacing) {
            // Play - Pause Button
            Button(action: {
                if timerMode == .running { timerMode = .paused } else { timerMode = .running }
            }) {
                HStack(spacing: Constants.smallSpacing) {
                    Image(systemName: timerMode == .paused ? "pause.fill" : "play.fill")
                        .foregroundColor(.white)
                    Text(timerMode == .paused ? "Pause" : "Play")
                        .foregroundColor(.white)
                }
                .padding(.vertical, Constants.mediumSpacing)
                .frame(width: UIScreen.main.bounds.width/2   - Constants.veryLargeSpacing)
                .background(Constants.buttonColor)
                .clipShape(Capsule())
                .shadow(radius: 6)
            }
            
//            // Restart Button
//                Button(action: {
//                    // sessionTimer.reset()
//                }) {
//                    HStack(spacing: Constants.smallSpacing) {
//                        Image(systemName: "arrow.clockwise")
//                            .foregroundColor(Constants.buttonColor)
//                        Text("Restart session")
//                            .foregroundColor(Constants.buttonColor)
//                    }
//                    .padding(.vertical, Constants.mediumSpacing)
//                    .frame(width: UIScreen.main.bounds.width/2 - Constants.veryLargeSpacing)
//                    .background(Capsule().stroke(Constants.buttonColor, lineWidth: 2))
//                    .shadow(radius: 6)
//                }
        }
        .padding(EdgeInsets(top: Constants.largeSpacing, leading: 0, bottom: Constants.largeSpacing, trailing: 0))
    }
}
