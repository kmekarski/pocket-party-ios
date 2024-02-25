//
//  MoveFromBottomTransitionModifier.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 20/02/2024.
//

import Foundation
import SwiftUI

struct MoveFromEdgeTransitionModifier: ViewModifier {
    var active: Bool
    var edge: Edge
    func body(content: Content) -> some View {
        var offsetX: CGFloat {
            switch edge {
            case .leading:
                return -UIScreen.main.bounds.width
            case .trailing:
                return UIScreen.main.bounds.width
            case .top, .bottom:
                return 0
            }
        }
        var offsetY: CGFloat {
            switch edge {
            case .top:
                return -UIScreen.main.bounds.height
            case .bottom:
                return UIScreen.main.bounds.height
            case .leading, .trailing:
                return 0
            }
        }
        return content
            .offset(x: active ? 0 : offsetX, y: active ? 0 : offsetY)
    }
}
