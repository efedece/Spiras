//
//  RoutineOtherSettingsView.swift
//  Spiras
//
//  Created by Fernando Jose Del Campo Guerola on 12/25/20.
//

import SwiftUI

struct RoutineOtherSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineOtherSettingsView(breatheIn: .constant(SingleRoutine.data[0].data.breatheIn), holdIn: .constant(SingleRoutine.data[0].data.holdIn), breatheOut: .constant(SingleRoutine.data[0].data.breatheOut), holdOut: .constant(SingleRoutine.data[0].data.holdOut),  cycleLength: .constant(SingleRoutine.data[0].data.cycleLength), numberOfCycles: .constant(SingleRoutine.data[0].data.numberOfCycles), sessionLength: .constant(SingleRoutine.data[0].data.sessionLength),vibrationOn: .constant(SingleRoutine.data[0].data.vibrationOn), soundOn: .constant(SingleRoutine.data[0].data.soundOn), saveAction: {})
            .previewLayout(.fixed(width: .infinity, height: 200))
    }
}

struct RoutineOtherSettingsView: View {
    @Binding var breatheIn: Int
    @Binding var holdIn: Int
    @Binding var breatheOut: Int
    @Binding var holdOut: Int
    @Binding var cycleLength: Int
    @Binding var numberOfCycles: Double
    @Binding var sessionLength: Int
    @Binding var vibrationOn: Bool
    @Binding var soundOn: Bool
    let saveAction: () -> Void

    var body: some View {
        VStack{
            HStack(spacing: Constants.largeSpacing) {
                VStack {
                    HStack{
                        Text("Number of cycles:")
                            .font(.system(size: Constants.smallFont))
                            .multilineTextAlignment(.center)
                        Text("\(Int(numberOfCycles))")
                            .font(.system(size: Constants.mediumFont))
                    }
                    Slider(value: $numberOfCycles, in: 1...30.0, step: 1.0)
                        .onChange(of: numberOfCycles, perform: { value in
                            sessionLength = cycleLength * Int (numberOfCycles)
                            saveAction()
                        })
                        .clipped()
                        .frame(maxWidth: UIScreen.main.bounds.width/2 - Constants.verySmallSpacing)
                }
                VStack {
                    Text("Session length")
                        .font(.system(size: Constants.smallFont))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, Constants.smallSpacing)
                    Text(secondsToMinutesAndSeconds(sessionLength))
                        .font(.system(size: Constants.mediumFont))
                        .padding(.bottom, Constants.smallSpacing)
                }
            }
            .padding(.top, Constants.smallSpacing)
            .padding(.bottom, Constants.mediumSpacing)
            
            HStack {
                Button(action: {
                    vibrationOn.toggle()
                    saveAction()
                }) {
                    HStack(spacing: Constants.verySmallSpacing) {
                        Text("Vibration:")
                            .font(.system(size: Constants.mediumFont))
                            .foregroundColor(.white)
                        Image(systemName: vibrationOn ? "iphone.radiowaves.left.and.right" : "iphone.slash").foregroundColor(.white)
                            .frame(width: Constants.largeSpacing, height: Constants.largeSpacing)
                    }
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width/2   - Constants.veryLargeSpacing)
                }
                Button(action: {
                    soundOn.toggle()
//                    saveAction()
                }) {
                    HStack(spacing: Constants.verySmallSpacing) {
                        Text("Sound:")
                            .font(.system(size: Constants.mediumFont))
                            .foregroundColor(.white)
                        Image(systemName: soundOn ? "speaker.wave.3.fill" : "speaker.slash.fill").foregroundColor(.white)
                            .frame(width: Constants.largeSpacing, height: Constants.largeSpacing)
                    }
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width/2   - Constants.veryLargeSpacing)
                }
            }
        }
    }
}

