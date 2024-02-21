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
        VStack(spacing: 12) {
            HStack {
                Text(title)
                    .foregroundColor(foregroundColor)
                            .font(.system(size: 24, weight: .bold))
                Spacer()
                Image(systemName: icon)
                    .foregroundColor(foregroundColor)
                    .font(.system(size: 36, weight: .regular))
            }
            Text(subtitle)
                .foregroundColor(foregroundColor)
                .font(.system(size: 22, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(28)
        .background(backgroundColor)
        .cornerRadius(24)
        .customShadow(.subtleDownShadow)
    }
}

struct MainMenuOptionView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            ForEach(GameMode.allCases, id:
                    \.self) { mode in
                MainMenuOptionView(title: mode.title, subtitle: mode.subtitle, icon: mode.icon, foregroundColor: .white, backgroundColor: .theme.accent)
            }
        }
        .padding(.horizontal, 24)
    }
}
