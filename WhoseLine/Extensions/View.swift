//
//  View.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 18/02/2024.
//

import Foundation
import SwiftUI

extension View {
    func subtleShadow() -> some View {
            modifier(SubtleShadowModifier())
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
}
