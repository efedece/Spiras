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
                .font(.headline)
                .fontWeight(.bold)
                .padding()
            Text("You finished your breathe cycle session")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("background5"))
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

