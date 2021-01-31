//
//  RoutineButtonsView.swift
//  Spiras
//
//  Created by Fernando Jose Del Campo Guerola on 12/27/20.
//

import SwiftUI

struct RoutineButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineButtonsView(breatheIn: .constant(SingleRoutine.data[0].data.breatheIn), holdIn: .constant(SingleRoutine.data[0].data.holdIn), breatheOut: .constant(SingleRoutine.data[0].data.breatheOut), holdOut: .constant(SingleRoutine.data[0].data.holdOut), numberOfCycles: .constant(SingleRoutine.data[0].data.numberOfCycles), vibrationOn: .constant(SingleRoutine.data[0].data.vibrationOn), soundOn: .constant(SingleRoutine.data[0].data.soundOn))//, sessionTimer: .constant(SessionTimer()))
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
    @State var sessionFinished = false

    var body: some View {
        ZStack {
            Button(
                action: {
                    sessionOn = true
                }, label: {
                    HStack(spacing: Constants.smallSpacing) {
                        Image(systemName: "play.fill")
                            .foregroundColor(.white)
                        Text("Start session")
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, Constants.mediumSpacing)
                    .frame(width: UIScreen.main.bounds.width/2   - Constants.veryLargeSpacing)
                    .background(Constants.buttonColor)
                    .clipShape(Capsule())
                    .shadow(radius: 6)
                })
                .fullScreenCover(isPresented: $sessionOn) {
                    SessionView(breatheIn: $breatheIn, holdIn: $holdIn, breatheOut: $breatheOut, holdOut: $holdOut, numberOfCycles: $numberOfCycles, vibrationOn: $vibrationOn, soundOn: $soundOn, sessionOn: $sessionOn)
            }
        }
    }
}

