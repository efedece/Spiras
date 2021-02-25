//
//  AnimationView.swift
//  Spiras
//
//  Created by Fernando Jose Del Campo Guerola on 12/27/20.
//

import SwiftUI

struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView(
            animationState: .constant(.breatheIn),
            animationDuration: .constant(Double(SingleRoutine.data[0].data.breatheIn)),
            animationDurationLeft: .constant(Double(SingleRoutine.data[0].data.breatheIn)),
            animationColor: .constant(Constants.breatheInColor)
        )
    }
}

struct AnimationView: View {
    // Cycle animation variables
    @Binding var animationState: CycleStep
    @Binding var animationDuration: Double
    @Binding var animationDurationLeft: Double
    @State var animationNumberOfPetals: Double = 5.0
    @Binding var animationColor: Color
    
    
    // Other animation variables
    /// Duration of the BlurFade transition based on the **breathingAnimation**
    private var fadeDuration: Double {
        return animationDuration * 0.6
    }
    @State var backColor = Color(UIColor.black)
        
    var body: some View {
        // Flower
        ZStack {
            if animationState == .breatheIn || animationState == .breatheOut {
                FlowerView(animationState: $animationState,
                           animationDuration: $animationDuration,
                           animationColor: $animationColor
                ).transition(
                    AnyTransition.asymmetric(
                        insertion: AnyTransition.opacity.animation(Animation.default.delay(animationDuration)),
                        removal: AnyTransition.blurFade.animation(Animation.easeIn(duration: fadeDuration))
                    )
                )
            }
            
            // This FlowerView creates a mask around the Main FlowerView
            FlowerView(animationState: $animationState,
                       animationDuration: $animationDurationLeft,
                       animationColor: $backColor
            )
            
            // Main FlowerView
            FlowerView(animationState: $animationState,
                       animationDuration: $animationDurationLeft,
                       animationColor: $animationColor)
        }
    }
}
