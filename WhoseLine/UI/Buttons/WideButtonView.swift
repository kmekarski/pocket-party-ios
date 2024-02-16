//
//  WideButtonView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 13/02/2024.
//

import SwiftUI

struct WideButtonView: View {
    var text: String
    var foregroundColor: Color = .white
    var backgroundColor: Color = Color.theme.accent
    
    init(_ text: String) {
        self.text = text
    }
    
    init(_ text: String, foregroundColor: Color, backgroundColor: Color) {
        self.text = text
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }
    var body: some View {
        Text(text)
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(foregroundColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .background(backgroundColor)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 5)

    }
}

struct WideButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            WideButtonView("Game")
            WideButtonView("Game")
            WideButtonView("Game")
        }
        .padding()
    }
}
