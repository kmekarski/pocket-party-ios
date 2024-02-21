//
//  SubtleShadowModifier.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 18/02/2024.
//

import Foundation
import SwiftUI

enum CustomShadowType {
    case subtleDownShadow
    case middleShadow
    case subtlerDownShadow
    case subtleBorderShadow
}
struct CustomShadowModifier: ViewModifier {
    var type: CustomShadowType = .subtleDownShadow
    func body(content: Content) -> some View {
        switch type {
        case.subtleDownShadow:
            return content
                .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 5)
        case .middleShadow:
            return content
                .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 0)
        case.subtleBorderShadow:
            return content
                .shadow(color: .black.opacity(0.3), radius: 2)
        case .subtlerDownShadow:
            return content
                .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 5)
        }
    }
}
