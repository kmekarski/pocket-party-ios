//
//  GameSettingsView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 21/02/2024.
//

import SwiftUI

struct GameSettingsView: View {
    @EnvironmentObject var playersVM: PlayersViewModel
    var gameMode: GameMode
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            VStack {
                header
                Spacer()
                Text("Minimum number of players: \(minimumNumberOfPlayers)")
                Spacer()
                nextButton
            }
            .padding()
            .padding(.horizontal)
            .onAppear() {
                playersVM.setGameMode(gameMode)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview("Taboo") {
    NavigationStack {
        GameSettingsView(gameMode: .taboo)
            .environmentObject(PlayersViewModel())
    }
}

#Preview("Scenes From a Hat") {
    NavigationStack {
        GameSettingsView(gameMode: .scenesFromAHat)
            .environmentObject(PlayersViewModel())
    }
}

#Preview("Truth or Dare") {
    NavigationStack {
        GameSettingsView(gameMode: .truthOrDare)
            .environmentObject(PlayersViewModel())
    }
}

extension GameSettingsView {
    private var header: some View {
        HStack(alignment: .top) {
            Button {
                playersVM.goBack()
            } label: {
                IconButtonView("arrow.left")
            }
            Spacer()
            Text(gameMode.title)
                .viewTitle()
            Spacer()
            IconButtonView("plus").opacity(0)
        }
    }
    
    private var minimumNumberOfPlayers: Int {
        switch gameMode.setBeforeGame {
        case .players:
            return gameMode.minimumPlayers
        case .teams:
            return gameMode.minimumPlayers * 2
        }
    }
    
    private var nextButton: some View {
        VStack {
            NavigationLink(value: "setPlayers") {
                WideButtonView("Next", disabled: false, size: .big, colorScheme: .primary)
            }
            .disabled(false)
        }
    }
}
