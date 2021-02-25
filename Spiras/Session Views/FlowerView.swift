//
//  FlowerView.swift
//  Spiras
//
//  Created by Fernando Jose Del Campo Guerola on 12/27/20.
//

import SwiftUI

struct FlowerView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerView(animationState: .constant(.breatheIn),
                   animationDuration: .constant(Double(SingleRoutine.data[0].data.breatheIn)),
//                   animationNumberOfPetals: .constant(Double(SingleRoutine.data[0].data.breatheIn)),
                   animationColor: .constant(Constants.breatheInColor)
        )
                
    }
}

struct FlowerView: View {
    // Cycle animation variables
    @Binding var animationState: CycleStep
    @Binding var animationDuration: Double
    @Binding var animationColor: Color
    
    // Other animation variables
    @State var animationNumberOfPetals: Double = 7
    let circleDiameter: CGFloat = 160
    @State private var anchorType: UnitPoint = .center
    @State private var ofssetAmount: CGFloat = 0
    @State private var rotationAmount: Double = 0
    @State private var scaleAmount: CGFloat = 0
    @State private var animationType: Animation = .easeInOut
    @State private var animationAmount: Double = 0
    /// This represents the absolute amount of rotation needed for each petal
    private var absolutePetalAngle: Double {
        return 360 / animationNumberOfPetals
    }
    
    var body: some View {
        ZStack() {
            ForEach(0..<Int(animationNumberOfPetals), id: \.self) {
                Circle() // Petal
                    .frame(width: circleDiameter, height: circleDiameter)
                    .foregroundColor(animationColor)
                    .opacity(0.3)
                    
                    // rotate the petal around it's leading anchor to create the flower
                    .rotationEffect(.degrees(absolutePetalAngle * Double($0)),
                                    anchor: anchorType)
            }
        }
        // Center the view along the center of the Flower
        .offset(x: ofssetAmount)
        
        // create a frame around the flower,
        // helful for adding padding around the whole flower
        .frame(width: circleDiameter * 2, height: circleDiameter * 2)
        
        .rotationEffect(.degrees(rotationAmount))
        .scaleEffect(scaleAmount)
        
        // smoothly animate any change to the Flower
        .animation(animationType)//.easeInOut(duration: animationAmount))
        
        // The purpose of the code bellow is to align the orientation to perfectly match Apple's implementation
//        .rotationEffect(.degrees(-60))
        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        
        .onAppear() {
            animationStateSettings()
        }
        
        .onChange(of: animationState, perform: { value in
            animationStateSettings()
        })
    }
    
    func animationStateSettings() {
        switch animationState {
        case .breatheIn:
            anchorType = .leading
            ofssetAmount = circleDiameter / 2
            rotationAmount = -60
            scaleAmount = 1
            animationAmount = animationDuration
            animationType = .easeInOut(duration: animationAmount)

        case .holdIn:
            anchorType = .leading
            ofssetAmount = circleDiameter / 2
            rotationAmount = 360
            scaleAmount = 1
            animationAmount = animationDuration
            animationType = .linear(duration: animationAmount)
            
        case .breatheOut:
            anchorType = .center
            ofssetAmount = 0
            rotationAmount = -150
            scaleAmount = 0.3
            animationAmount = animationDuration
            animationType = .easeInOut(duration: animationAmount)
            
        case .holdOut:
            anchorType = .center
            ofssetAmount = 0
            rotationAmount = 360
            scaleAmount = 0.25
            animationAmount = animationDuration
            animationType = .linear(duration: animationAmount)
            
        }
    }
}
