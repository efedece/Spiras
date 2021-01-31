//
//  SessionView.swift
//  Spiras
//
//  Created by Fernando Jose Del Campo Guerola on 12/27/20.
//

import SwiftUI

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView(breatheIn: .constant(SingleRoutine.data[0].data.breatheIn), holdIn: .constant(SingleRoutine.data[0].data.holdIn), breatheOut: .constant(SingleRoutine.data[0].data.breatheOut), holdOut: .constant(SingleRoutine.data[0].data.holdOut), numberOfCycles: .constant(SingleRoutine.data[0].data.numberOfCycles), vibrationOn: .constant(SingleRoutine.data[0].data.vibrationOn), soundOn: .constant(SingleRoutine.data[0].data.soundOn), sessionOn: .constant(true))
    }
}

struct SessionView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var breatheIn: Int
    @Binding var holdIn: Int
    @Binding var breatheOut: Int
    @Binding var holdOut: Int
    @Binding var numberOfCycles: Double
    @Binding var vibrationOn: Bool
    @Binding var soundOn: Bool
    @Binding var sessionOn: Bool
    @StateObject var sessionTimer = SessionTimer()

    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: Constants.mediumSpacing){
                ZStack {
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(Color.white, style: StrokeStyle(lineWidth: Constants.timerCircleLineWidth, lineCap: .round))
                        .frame(width: Constants.timerCircleDimensions, height: Constants.timerCircleDimensions)
                    Circle()
                        .trim(from: 0, to: sessionTimer.cycleBarTo)
                        .stroke(sessionTimer.cycleColor, style: StrokeStyle(lineWidth: Constants.timerCircleLineWidth, lineCap: .round))
                        .frame(width: Constants.timerCircleDimensions, height: Constants.timerCircleDimensions)
                        .rotationEffect(.init(degrees: -90))
                    VStack{
                        Text(secondsToMinutesAndSeconds(Int(sessionTimer.secondsLeftStep.rounded(.up))))
                            .font(.system(size: Constants.superLargeFont))
                            .fontWeight(.bold)
                            .padding(.vertical, Constants.smallSpacing)
                        Text("\(sessionTimer.cycleStep.description)")
                            .font(.system(size: Constants.largeFont))
                            .fontWeight(.semibold)
                    }
                }
                .padding(.top, Constants.veryLargeSpacing)
                HStack(spacing: Constants.mediumSpacing) {
                    VStack {
                        Text("Time left:")
                            .font(.system(size: Constants.mediumFont))
                            .fontWeight(.semibold)
                        Text("\(secondsToMinutesAndSeconds(Int(sessionTimer.secondsLeftSession.rounded(.up))))") 
                            .font(.system(size: Constants.mediumFont))
                    }
                    .frame(width: (UIScreen.main.bounds.width / 2) - Constants.veryLargeSpacing)
                    
                    VStack {
                        Text("Cycles left:")
                            .font(.system(size: Constants.mediumFont))
                            .fontWeight(.semibold)
                        Text("\(sessionTimer.cyclesLeft)")
                            .font(.system(size: Constants.mediumFont))
                    }
                    .frame(width: (UIScreen.main.bounds.width / 2) - Constants.veryLargeSpacing)
                }
                .padding(.top, Constants.veryLargeSpacing)
                
                SessionButtonsView(timerMode: $sessionTimer.timerState)
            }
            if sessionTimer.timerState == .finished {
                SessionCompletedView()
            }
        }
        .onAppear {
            if sessionTimer.timerState == .notSet { //FIXME: Correguir para que no se reinicie
                sessionTimer.setTimer(breatheIn: breatheIn, holdIn: holdIn, breatheOut: breatheOut, holdOut: holdOut, numberOfCycles: Int(numberOfCycles),  vibrationOn: vibrationOn, soundOn: soundOn)
            }
            sessionTimer.timerState = .paused
        }
        .onChange(of: sessionTimer.timerState, perform: { value in
            if sessionTimer.timerState == .paused {
                sessionTimer.run()
            } else if sessionTimer.timerState == .running {
                sessionTimer.pause()
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(Color(UIColor.systemBackground))
        .environment(\.colorScheme, .dark)
        .onTapGesture {
            sessionTimer.timerState = .paused
            presentationMode.wrappedValue.dismiss()
        }
    }
}
