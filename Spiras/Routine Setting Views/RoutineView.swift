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
            RoutineView(routine: .constant(SingleRoutine.data[0]), saveAction: {})
        }
    }
}

struct RoutineView: View {
    @Binding var routine: SingleRoutine
    let saveAction: () -> Void

    var body: some View {
        VStack(alignment: .center) {
            // Settings
            Text("BREATHE CYCLE SETTINGS")
                .font(.system(size: Constants.mediumFont))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.vertical, Constants.largeSpacing)
            
            RoutineCycleSettingsView(breatheIn: $routine.breatheIn, holdIn: $routine.holdIn, breatheOut: $routine.breatheOut, holdOut: $routine.holdOut, cycleLength: $routine.cycleLength, numberOfCycles: $routine.numberOfCycles, sessionLength: $routine.sessionLength) { saveAction() }
                .frame(width: UIScreen.main.bounds.width, height: Constants.settingsWheelHeight + Constants.veryLargeSpacing)
                .padding(.vertical, Constants.mediumSpacing)
            
            RoutineOtherSettingsView(breatheIn: $routine.breatheIn, holdIn: $routine.holdIn, breatheOut: $routine.breatheOut, holdOut: $routine.holdOut, cycleLength: $routine.cycleLength, numberOfCycles: $routine.numberOfCycles, sessionLength: $routine.sessionLength, vibrationOn: $routine.vibrationOn, soundOn: $routine.soundOn) { saveAction() }
                .padding(.bottom, Constants.mediumSpacing)
            
            // Action Button
            RoutineButtonsView(breatheIn: $routine.breatheIn, holdIn: $routine.holdIn, breatheOut: $routine.breatheOut, holdOut: $routine.holdOut, numberOfCycles: $routine.numberOfCycles, vibrationOn: $routine.vibrationOn, soundOn: $routine.soundOn)
        }
        .navigationBarTitle("\(routine.title)",  displayMode: .inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(Color(UIColor.systemBackground))
        .environment(\.colorScheme, .dark)
    }
}

