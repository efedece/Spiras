//
//  SessionView.swift
//  Spiras
//
//  Created by Fernando Jose Del Campo Guerola on 12/27/20.
//

import SwiftUI

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView(
            breatheIn: .constant(SingleRoutine.data[0].data.breatheIn),
            holdIn: .constant(SingleRoutine.data[0].data.holdIn),
            breatheOut: .constant(SingleRoutine.data[0].data.breatheOut),
            holdOut: .constant(SingleRoutine.data[0].data.holdOut),
            numberOfCycles: .constant(SingleRoutine.data[0].data.numberOfCycles),
            vibrationOn: .constant(SingleRoutine.data[0].data.vibrationOn),
            soundOn: .constant(SingleRoutine.data[0].data.soundOn),
            timerState: .constant(TimerMode.notSet),
            sessionSecondsLeft: .constant(Double(SingleRoutine.data[0].data.sessionLength)),
            cycleStepSecondsLeft: .constant(Double(SingleRoutine.data[0].data.breatheIn)),
            cyclesLeft: .constant(0),//.constant(SingleRoutine.data[0].data.numberOfCycles),
            cycleStepSeconds: .constant(Double(SingleRoutine.data[0].data.breatheIn)),
            cycleColor: .constant(Constants.breatheInColor),
            cycleStep: .constant(CycleStep.breatheIn),
            buttonAction: {(timerMode: TimerMode) -> Void in }
        )
    }
}

struct SessionView: View {
    @Environment(\.presentationMode) var presentationMode
    
    // Breathe cycle settings variables
    @Binding var breatheIn: Int
    @Binding var holdIn: Int
    @Binding var breatheOut: Int
    @Binding var holdOut: Int
    @Binding var numberOfCycles: Double
    @Binding var vibrationOn: Bool
    @Binding var soundOn: Bool

    // Timer variables
    @Binding var timerState: TimerMode
    @Binding var sessionSecondsLeft: Double
    @Binding var cycleStepSecondsLeft: Double
    @Binding var cyclesLeft: Int

    // Animation variables
    @Binding var cycleStepSeconds: Double
    @Binding var cycleColor: Color
    @Binding var cycleStep: CycleStep
    
    let buttonAction: (TimerMode) -> Void
    

    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: Constants.mediumSpacing){
                // Cycle step description
                Text("\(cycleStep.description)")
                    .font(.system(size: Constants.veryLargeFont))
                    .fontWeight(.semibold)
                    .padding(.top, Constants.largeSpacing)
                
                Text(secondsToMinutesAndSeconds(Int(cycleStepSecondsLeft.rounded(.up))))
                    .font(.system(size: Constants.largeFont))
                    .fontWeight(.semibold)
                
                // Cycle animation
                AnimationView(animationState: $cycleStep, animationDuration: $cycleStepSeconds, animationDurationLeft: $cycleStepSecondsLeft, animationColor: $cycleColor)
                    
                .frame(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height / 2) + Constants.veryLargeSpacing)
                
                // Session details
                HStack(spacing: Constants.mediumSpacing) {
                    VStack {
                        Text("Time left:")
                            .font(.system(size: Constants.mediumFont))
                            .fontWeight(.semibold)
                        Text("\(secondsToMinutesAndSeconds(Int(sessionSecondsLeft.rounded(.up))))")
                            .font(.system(size: Constants.mediumFont))
                    }
                    .frame(width: (UIScreen.main.bounds.width / 2) - Constants.veryLargeSpacing)
                    
                    VStack {
                        Text("Cycles left:")
                            .font(.system(size: Constants.mediumFont))
                            .fontWeight(.semibold)
                        Text("\(cyclesLeft)")
                            .font(.system(size: Constants.mediumFont))
                    }
                    .frame(width: (UIScreen.main.bounds.width / 2) - Constants.veryLargeSpacing)
                }
                .padding(.vertical, Constants.mediumSpacing)
            }
            
            // Show session completed view on timer end
            if timerState == .finished {
                SessionCompletedView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(Constants.backgroundColor)
            .edgesIgnoringSafeArea(.all)
        .environment(\.colorScheme, .dark)
        .onTapGesture {
            timerState = .paused
            buttonAction(timerState) // Pause timer
            presentationMode.wrappedValue.dismiss()
        }
    }
}
