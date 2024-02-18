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

struct ButtonColorTheme {
    let foreground: Color
    let background: Color
}

enum WideButtonColorTheme {
    case primary
    case secondary
    
    var foregroundColor: Color {
        switch self {
        case .primary:
            return .white
        case .secondary:
            return .theme.accent
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .primary:
            return .theme.accent
        case .secondary:
            return .theme.secondaryBackground
        }
    }
}

struct WideButtonView: View {
    var text: String
    var disabled: Bool = false
    var size: WideButtonSize = .small
    var colorScheme: WideButtonColorTheme = .primary
    
    init(_ text: String, colorScheme: WideButtonColorTheme) {
        self.text = text
        self.colorScheme = colorScheme
    }
    
    init(_ text: String, disabled: Bool, colorScheme: WideButtonColorTheme) {
        self.text = text
        self.disabled = disabled
        self.colorScheme = colorScheme
    }
    
    init(_ text: String, size: WideButtonSize, colorScheme: WideButtonColorTheme) {
        self.text = text
        self.size = size
        self.colorScheme = colorScheme
    }
    
    init(_ text: String, disabled: Bool, size: WideButtonSize, colorScheme: WideButtonColorTheme) {
        self.text = text
        self.disabled = disabled
        self.size = size
        self.colorScheme = colorScheme
    }

    var body: some View {
        Text(text)
            .font(.system(size: size == .big ? 20 : 16, weight: .bold))
            .foregroundColor(colorScheme.foregroundColor.opacity(disabled ? 0.55 : 1))
            .frame(maxWidth: .infinity)
            .padding(.vertical, size == .big ? 16 : 10)
            .background(colorScheme.backgroundColor.opacity(disabled ? 0.55 : 1))
            .cornerRadius(20)
            .subtleShadow()
    }
}

struct WideButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            HStack {
                VStack(spacing: 20) {
                    WideButtonView("Game", colorScheme: .primary)
                    WideButtonView("Game", size: .big, colorScheme: .primary)
                    WideButtonView("Game", disabled: true, colorScheme: .primary)
                    WideButtonView("Game", disabled: true, size: .big, colorScheme: .primary)
                }
                VStack(spacing: 20) {
                    WideButtonView("Game", colorScheme: .secondary)
                    WideButtonView("Game", size: .big, colorScheme: .secondary)
                    WideButtonView("Game", disabled: true, colorScheme: .secondary)
                    WideButtonView("Game", disabled: true, size: .big, colorScheme: .secondary)
                }
            }
            .padding()
        }
    }
}
