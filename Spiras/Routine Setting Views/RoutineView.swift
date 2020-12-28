//
//  RoutineView.swift
//  Spiras
//
//  Created by Fernando Jose Del Campo Guerola on 12/25/20.
//

import SwiftUI

struct RoutineView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RoutineView(routine: .constant(SingleRoutine.data[0]))
        }
    }
}

struct RoutineView: View {
    @Binding var routine: SingleRoutine
//    @State private var data: SingleRoutine.Data = SingleRoutine.Data()
//    @StateObject var sessionTimer = SessionTimer()
    @State var isRunning = false
    var body: some View {
        VStack(alignment: .center) {
            // Settings
            Text("BREATHE CYCLE SETTINGS")
                .font(.system(size: Constants.mediumFont))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.vertical, Constants.largeSpacing)
            
            RoutineCycleSettingsView(breatheIn: $routine.breatheIn, holdIn: $routine.holdIn, breatheOut: $routine.breatheOut, holdOut: $routine.holdOut, cycleLength: $routine.cycleLength, numberOfCycles: $routine.numberOfCycles, sessionLength: $routine.sessionLength)
                .frame(width: UIScreen.main.bounds.width, height: Constants.settingsWheelHeight + Constants.veryLargeSpacing)
                .padding(.vertical, Constants.mediumSpacing)
            
            RoutineOtherSettingsView(breatheIn: $routine.breatheIn, holdIn: $routine.holdIn, breatheOut: $routine.breatheOut, holdOut: $routine.holdOut, cycleLength: $routine.cycleLength, numberOfCycles: $routine.numberOfCycles, sessionLength: $routine.sessionLength, vibrationOn: $routine.vibrationOn, soundOn: $routine.soundOn)
                .padding(.bottom, Constants.mediumSpacing)
            
            // Action Button
            RoutineButtonsView(isRunning: $isRunning)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.black))
        .padding(.bottom, Constants.veryLargeSpacing)
        .environment(\.colorScheme, .dark)
    }
}

