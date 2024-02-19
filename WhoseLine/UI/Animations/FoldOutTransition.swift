//
//  FoldOutTransition.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 19/02/2024.
//

import Foundation
import SwiftUI

struct FoldOutTransition: AnimatableModifier {
    var angle: Double

    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }

    func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                Angle(degrees: angle),
                axis: (x: 1.0, y: 0.0, z: 0.0)
            )
            .opacity(angle < -90 ? 0 : 1)
    }
}
