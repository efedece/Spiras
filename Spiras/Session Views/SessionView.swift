//
//  SessionView.swift
//  Spiras
//
//  Created by Fernando Jose Del Campo Guerola on 12/27/20.
//

import SwiftUI

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView()
    }
}

struct SessionView: View {
//    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .center, spacing: Constants.mediumSpacing){
            ZStack {
                Circle()
                    .trim(from: 0, to: 1)
                    .stroke(Color.white, style: StrokeStyle(lineWidth: Constants.timerCircleLineWidth, lineCap: .round))
                    .frame(width: Constants.timerCircleDimensions, height: Constants.timerCircleDimensions)
                Circle()
                    .trim(from: 0, to: 0.9)
                    .stroke(Color(.red), style: StrokeStyle(lineWidth: Constants.timerCircleLineWidth, lineCap: .round)) //FIXME: cycleColor
                    .frame(width: Constants.timerCircleDimensions, height: Constants.timerCircleDimensions)
                    .rotationEffect(.init(degrees: -90))
                VStack{
                    Text(secondsToMinutesAndSeconds(Int(10))) // FIXME: .rounded(.up)
                        .font(.system(size: Constants.superLargeFont))
                        .fontWeight(.bold)
                        .padding(.vertical, Constants.smallSpacing)
                    Text("\("Hold")") // FIXME: cycleStep.description
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
                    Text("\(secondsToMinutesAndSeconds(Int(10)))") // FIXME: Int(exercisePlan.secondsLeftSession.rounded(.up))
                        .font(.system(size: Constants.mediumFont))
                }
                .frame(width: (UIScreen.main.bounds.width / 2) - Constants.veryLargeSpacing)

                VStack {
                    Text("Cycles left:")
                        .font(.system(size: Constants.mediumFont))
                        .fontWeight(.semibold)
                    Text("\(10)") // FIXME: cyclesLeft
                        .font(.system(size: Constants.mediumFont))
                }
                .frame(width: (UIScreen.main.bounds.width / 2) - Constants.veryLargeSpacing)
            }
            .padding(.top, Constants.veryLargeSpacing)
            
            SessionButtonsView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color(.black))
        .edgesIgnoringSafeArea(.all)
    }
}
