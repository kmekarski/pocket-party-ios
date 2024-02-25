//
//  ViewTitleModifier.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 20/02/2024.
//

import Foundation
import SwiftUI

struct ViewTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(size: 28, weight: .semibold))
    }
}
