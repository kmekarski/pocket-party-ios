//
//  WideButtonView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 13/02/2024.
//

import SwiftUI

enum WideButtonSize {
    case big
    case small
}

struct WideButtonView: View {
    var text: String
    var foregroundColor: Color = .white
    var backgroundColor: Color = Color.theme.accent
    var disabled: Bool = false
    var size: WideButtonSize = .small
    
    init(_ text: String) {
        self.text = text
    }
    
    init(_ text: String, disabled: Bool) {
        self.text = text
        self.disabled = disabled
    }
    
    init(_ text: String, size: WideButtonSize) {
        self.text = text
        self.size = size
    }
    
    init(_ text: String, disabled: Bool, size: WideButtonSize) {
        self.text = text
        self.disabled = disabled
        self.size = size
    }
    
    init(_ text: String, foregroundColor: Color, backgroundColor: Color) {
        self.text = text
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }
    var body: some View {
        Text(text)
            .font(.system(size: size == .big ? 20 : 16, weight: .bold))
            .foregroundColor(foregroundColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical, size == .big ? 16 : 10)
            .background(backgroundColor.opacity(disabled ? 0.55 : 1))
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 5)

    }
}

struct WideButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            WideButtonView("Game")
            WideButtonView("Game", size: .big)
            WideButtonView("Game", disabled: true)
            WideButtonView("Game", disabled: true, size: .big)
        }
        .padding()
    }
}
