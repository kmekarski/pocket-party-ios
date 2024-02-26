//
//  HomeView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 13/02/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var playersVM: GameViewModel
    var body: some View {
        NavigationStack(path: $playersVM.navPath) {
            MainMenuView()
                .navigationDestination(for: String.self) { pathValue in
                    ForEach(GameMode.allCases, id: \.self) { mode in
                        if pathValue == AppState.gameSettings.rawValue + mode.rawValue {
                            GameSettingsView(gameMode: mode)
                        }
                    }
                    if pathValue == AppState.setPlayers.rawValue {
                        SetPlayersView()
                    }
                    if pathValue == AppState.game.rawValue {
                        GameView()
                    }
                    if pathValue == AppState.gameOver.rawValue {
                        GameOverView()
                    }
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(dev.playersVMWithSetPlayers)
    }
}
