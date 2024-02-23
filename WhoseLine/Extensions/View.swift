//
//  View.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 18/02/2024.
//

import Foundation
import SwiftUI

extension View {
    func customShadow(_ type: CustomShadowType) -> some View {
        modifier(CustomShadowModifier(type: type))
    }
    
    func foldTransition(active: Bool, direction: FoldDirection) -> some View {
        modifier(FoldTransitionModifier(foldDirection: direction, active: active))
    }
    
    func viewTitle() -> some View {
        modifier(ViewTitleModifier())
    }
    
    func moveFromEdgeTransition(active: Bool, edge: Edge) -> some View {
        modifier(MoveFromEdgeTransitionModifier(active: active, edge: edge))
    }
    
    func gameQuestionCard(_ type: GameQuestionCardType) -> some View {
        modifier(GameQuestionModifier(type: type))
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
