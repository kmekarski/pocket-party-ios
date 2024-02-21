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
    case topWithBorder
    case flippedTop
    case background
    case backgroundDark
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
                        .fill(.shadow(.inner(color: .black.opacity(0.15), radius: 6)))
                        .foregroundColor(.white)
                )
                    .cornerRadius(24)
                    .customShadow(.subtleDownShadow)
                    .offset(y: -32)
                    .padding(.horizontal, 32)
            )
        case .topWithBorder:
            return AnyView(
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(24)
                    
                    content
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(maxHeight: .infinity)
                        .background(Color.theme.background)
                        .cornerRadius(18)
                        .padding(6)
                }
                    .frame(maxWidth: 350)
                    .frame(height: 150)
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
            )
        case .backgroundDark:
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
        }
    }
}
