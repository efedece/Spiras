//
//  SessionCompletedView.swift
//  Spiras
//
//  Created by Fernando Jose Del Campo Guerola on 12/27/20.
//

import SwiftUI

struct SessionCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        SessionCompletedView()
    }
}

struct SessionCompletedView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Session completed 🎉")
                .font(.system(size:Constants.veryLargeFont))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding()
            Text("You finished your breathe cycle session")
                .font(.system(size: Constants.mediumFont))
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("1-Vivid Sky Blue"))
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

