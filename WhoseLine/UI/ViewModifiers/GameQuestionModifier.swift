//
//  GameQuestionModifier.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 21/02/2024.
//

import Foundation
import SwiftUI

enum GameQuestionCardType {
    case top
    case flippedTop
    case background
    case verticalTop
    case verticalBackground
}

struct GameQuestionModifier: ViewModifier {
    var type: GameQuestionCardType
    func body(content: Content) -> some View {
        switch type {
        case.top:
            return AnyView(content
                .padding()
                .frame(maxWidth: 350)
                .frame(height: 150)
                .background(
                    RoundedRectangle(cornerSize: CGSize(width: 24, height: 24))
                        .fill(.shadow(.inner(color: .black.opacity(0.25), radius: 6)))
                        .foregroundColor(.white)
                )
                    .cornerRadius(24)
                    .customShadow(.subtleDownShadow)
                    .offset(y: -32)
                    .padding(.horizontal, 32)
            )
        case .flippedTop:
            return AnyView(content
                .padding()
                .frame(maxWidth: 350)
                .frame(height: 150)
                .background(Color.theme.accent)
                .cornerRadius(24)
                .customShadow(.subtleDownShadow)
                .offset(y: -32)
                .padding(.horizontal, 32)
            )
        case .background:
            return AnyView(content
                .foregroundColor(.theme.accent)
                .frame(maxWidth: 350)
                .frame(height: 150)
                .background(Color.white)
                .cornerRadius(24)
                .offset(y: -32)
                .padding(.horizontal, 32)
                .brightness(-0.1)
            )
        case .verticalTop:
            return AnyView(content
                .padding()
                .frame(maxWidth: 220)
                .frame(height: 280)
                .background(
                    RoundedRectangle(cornerSize: CGSize(width: 24, height: 24))
                        .fill(.shadow(.inner(color: .black.opacity(0.25), radius: 6)))
                        .foregroundColor(.white)
                )
                    .cornerRadius(24)
                    .customShadow(.subtleDownShadow)
                    .padding(.horizontal, 32)
            )
        case .verticalBackground:
            return AnyView(content
                .foregroundColor(.theme.accent)
                .frame(maxWidth: 220)
                .frame(height: 280)
                .background(Color.white)
                .cornerRadius(24)
                .padding(.horizontal, 32)
                .brightness(-0.1)
            )
        }
    }
}
