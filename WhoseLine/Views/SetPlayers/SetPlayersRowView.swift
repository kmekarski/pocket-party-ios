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
            Text(player.name)
                .font(.system(size: 24, weight: .semibold))
            Spacer()
            Button(action: {
                playersVM.deletePlayer(id: player.id)
            }, label: {
                IconButtonView("xmark", size: .small)
            })
        }
        .padding()
        .foregroundColor(Color.white)
        .background(Color.theme.accent)
        .cornerRadius(20)
    }
}

#Preview {
    let player = Player(id: "1", name: "John")
    return VStack(spacing: 10) {
        SetPlayersRowView(player: player)
        SetPlayersRowView(player: player)
        SetPlayersRowView(player: player)
    }
    .padding()
    .environmentObject(PlayersViewModel())
}
