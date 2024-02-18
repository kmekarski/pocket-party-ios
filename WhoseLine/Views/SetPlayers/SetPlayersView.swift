//
//  SetPlayersView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 18/02/2024.
//

import SwiftUI

struct SetPlayersView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    @EnvironmentObject var playersVM: PlayersViewModel
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            VStack {
                header
                playersList
                Spacer()
                Button(action: {
                    homeVM.goToGame()
                }, label: {
                    WideButtonView("Start Game", size: .big)
                })
            }
            .padding()
            .padding(.horizontal)
        }
    }
}

#Preview {
    SetPlayersView()
        .environmentObject(HomeViewModel())
        .environmentObject(PlayersViewModel())
}

extension SetPlayersView {
    private var header: some View {
        HStack {
            Button {
                homeVM.goToMainMenu()
            } label: {
                IconButtonView("arrow.left")
            }
            Spacer()
            Text("Players")
            Spacer()
            Button {
                playersVM.addPlayer()
            } label: {
                IconButtonView("plus")
            }
        }
    }
    
    private var playersList: some View {
        VStack {
            ForEach(playersVM.players) { player in
                SetPlayersRowView(player: player)
            }
        }
    }
}
