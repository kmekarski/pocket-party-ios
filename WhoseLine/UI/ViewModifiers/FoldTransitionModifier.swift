//
//  FoldTransitionModifier.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 20/02/2024.
//

import Foundation
import SwiftUI

enum FoldDirection: Int {
    case left = -1
    case right = 1
}

struct FoldTransitionModifier: ViewModifier {
    let foldDirection: FoldDirection
    let active: Bool
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(Double(active ? (foldDirection.rawValue * 90) : 0)), anchor: UnitPoint(x: 0, y: 1.4))
    }
}
