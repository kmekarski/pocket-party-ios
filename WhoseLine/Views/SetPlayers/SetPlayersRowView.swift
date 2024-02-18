//
//  SetPlayersRowView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 18/02/2024.
//

import SwiftUI

struct SetPlayersRowView: View {
    @EnvironmentObject var playersVM: PlayersViewModel
    var player: Player
    var body: some View {
        HStack {
            HStack(spacing: 12) {
                Text(player.name)
                Text(player.theme.emoji)
            }
            .font(.system(size: 20, weight: .semibold))


            Spacer()
            Button(action: {
                playersVM.deletePlayer(id: player.id)
            }, label: {
                IconButtonView("xmark", color: player.theme.textColor, size: .small)
                    .fontWeight(.semibold)
            })
        }
        .padding(.vertical)
        .padding(.trailing)
        .padding(.leading, 24)
        .foregroundColor(player.theme.textColor)
        .background(player.theme.color)
        .cornerRadius(20)
    }
}

#Preview {
    return VStack(spacing: 10) {
        ForEach(PlayerTheme.allCases, id: \.self) { theme in
            SetPlayersRowView(player: Player(id: "1", name: "John", theme: theme))
        }
    }
    .padding()
    .environmentObject(PlayersViewModel())
}