//
//  BackgroundImageModifier.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 24/02/2024.
//

import Foundation
import SwiftUI

struct BackgroundImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    Color.theme.background.ignoresSafeArea()
                    Image("Background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            )
    }
}

