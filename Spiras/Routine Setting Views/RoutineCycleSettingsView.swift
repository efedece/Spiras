//
//  RoutineCycleSettingsView.swift
//  Spiras
//
//  Created by Fernando Jose Del Campo Guerola on 12/25/20.
//

import SwiftUI

struct RoutineCycleSettingView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineCycleSettingsView(breatheIn: .constant(SingleRoutine.data[0].data.breatheIn), holdIn: .constant(SingleRoutine.data[0].data.holdIn), breatheOut: .constant(SingleRoutine.data[0].data.breatheOut), holdOut: .constant(SingleRoutine.data[0].data.holdOut),  cycleLength: .constant(SingleRoutine.data[0].data.cycleLength), numberOfCycles: .constant(SingleRoutine.data[0].data.numberOfCycles), sessionLength: .constant(SingleRoutine.data[0].data.sessionLength), saveAction: {})
            .previewLayout(.fixed(width: .infinity, height: Constants.settingsWheelHeight + Constants.veryLargeSpacing))
    }
}

struct RoutineCycleSettingsView: View {
    @Binding var breatheIn: Int
    @Binding var holdIn: Int
    @Binding var breatheOut: Int
    @Binding var holdOut: Int
    @Binding var cycleLength: Int
    @Binding var numberOfCycles: Double
    @Binding var sessionLength: Int
    
    let saveAction: () -> Void
    let timerRange = Array(0...59)
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: Constants.smallSpacing) {
                VStack {
                    Text("Breathe In").font(.system(size: Constants.smallFont)).multilineTextAlignment(.center)
                    Picker(selection: $breatheIn, label: Text("")) {
                        ForEach(0 ..< timerRange.count) { Text("\(timerRange[$0])") .font(.system(size: Constants.smallFont)) }
                    }
                    .onChange(of: breatheIn, perform: { value in
                        cycleLength = breatheIn + holdIn + breatheOut + holdOut
                        sessionLength = cycleLength * Int (numberOfCycles)
                        saveAction()
                    })
                    .frame(maxWidth: geometry.size.width/4 - Constants.settingsWheelWidth, maxHeight: Constants.settingsWheelHeight)
                    .clipped()
                }
                VStack {
                    Text("Hold In").font(.system(size: Constants.smallFont)).multilineTextAlignment(.center)
                    Picker(selection: $holdIn, label: Text("")) {
                        ForEach(0 ..< timerRange.count) { Text("\(timerRange[$0])") .font(.system(size: Constants.smallFont)) }
                    }
                    .onChange(of: holdIn, perform: { value in
                        cycleLength = breatheIn + holdIn + breatheOut + holdOut
                        sessionLength = cycleLength * Int (numberOfCycles)
                        saveAction()
                    })
                    .frame(maxWidth: geometry.size.width/4 - Constants.settingsWheelWidth, maxHeight: Constants.settingsWheelHeight)
                    .clipped()
                }
                VStack {
                    Text("Breathe Out").font(.system(size: Constants.smallFont)).multilineTextAlignment(.center)
                    Picker(selection: $breatheOut, label: Text("")) {
                        ForEach(0 ..< timerRange.count) { Text("\(timerRange[$0])") .font(.system(size: Constants.smallFont)) }
                    }
                    .onChange(of: breatheOut, perform: { value in
                        cycleLength = breatheIn + holdIn + breatheOut + holdOut
                        sessionLength = cycleLength * Int (numberOfCycles)
                        saveAction()
                    })
                    .frame(maxWidth: geometry.size.width/4 - Constants.settingsWheelWidth, maxHeight: Constants.settingsWheelHeight)
                    .clipped()
                }
                VStack {
                    Text("Hold Out").font(.system(size: Constants.smallFont)).multilineTextAlignment(.center)
                    Picker(selection: $holdOut, label: Text("")) {
                        ForEach(0 ..< timerRange.count) { Text("\(timerRange[$0])") .font(.system(size: Constants.smallFont)) }
                    }
                    .onChange(of: holdOut, perform: { value in
                        cycleLength = breatheIn + holdIn + breatheOut + holdOut
                        sessionLength = cycleLength * Int (numberOfCycles)
                        saveAction()
                    })
                    .frame(maxWidth: geometry.size.width/4 - Constants.settingsWheelWidth, maxHeight: Constants.settingsWheelHeight)
                    .clipped()
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: Constants.settingsWheelHeight + Constants.veryLargeSpacing, alignment: .center)
        }
    }
}
