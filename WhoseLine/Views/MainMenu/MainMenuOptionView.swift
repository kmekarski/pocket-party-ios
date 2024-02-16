//
//  MainMenuOptionView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 16/02/2024.
//

import SwiftUI

struct MainMenuOptionView: View {
    var title: String
    var subtitle: String
    var icon: String
    var foregroundColor: Color = .white
    var backgroundColor: Color = Color.theme.accent
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .foregroundColor(foregroundColor)
                            .font(.system(size: 24, weight: .bold))
                Text(subtitle)
                    .foregroundColor(foregroundColor)
                    .font(.system(size: 20, weight: .regular))
            }

            Spacer()
            Image(systemName: icon)
                .foregroundColor(foregroundColor)
                .font(.system(size: 36, weight: .regular))
        }
        .padding(28)
        .padding(.leading)
        .background(backgroundColor)
        .cornerRadius(24)
        .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 6)
    }
}

struct MainMenuOptionView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            ForEach(1..<6) { _ in
                MainMenuOptionView(title: "Scenes from a Hat", subtitle: "Classic WLIIA Game", icon: "gear", foregroundColor: .white, backgroundColor: .theme.accent)
            }
        }
        .padding(.horizontal, 24)
    }
}
