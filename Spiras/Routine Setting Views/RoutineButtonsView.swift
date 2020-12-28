//
//  RoutineButtonsView.swift
//  Spiras
//
//  Created by Fernando Jose Del Campo Guerola on 12/27/20.
//

import SwiftUI

//struct RoutineButtonsView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoutineButtonsView(isRunning:)
//            .previewLayout(.fixed(width: .infinity, height: 100))
//    }
//}

struct RoutineButtonsView: View {
    @Binding var isRunning: Bool
    var body: some View {
        Button(action: { isRunning.toggle() },
               label: {
                HStack(spacing: Constants.smallSpacing) {
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                    Text("Start session")
                        .foregroundColor(.white)
                }
                .padding(.vertical, Constants.mediumSpacing)
                .frame(width: UIScreen.main.bounds.width/2   - Constants.veryLargeSpacing)
                .background(Color("background8"))
                .clipShape(Capsule())
                .shadow(radius: 6)
               })
            .fullScreenCover(isPresented: $isRunning) {
                SessionView()
            }
    }
}

