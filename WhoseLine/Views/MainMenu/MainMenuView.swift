//
//  MainMenuView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 13/02/2024.
//

import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var playersVM: PlayersViewModel
    @State private var navPath: [String] = []
    @State var showSettings: Bool = false
    var body: some View {
        NavigationStack(path: $playersVM.navPath) {
            ZStack {
                Color.theme.background.ignoresSafeArea()
                ScrollView {
                    VStack {
                        header
                            .padding(.bottom, 8)
                        menuButtons
                    }
                    .padding(.top)
                    .padding(.horizontal)
                }
                SettingsModalView(isShowing: $showSettings)
            }
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
            .environmentObject(dev.playersVM)
    }
}

extension MainMenuView {
    private var header: some View {
        HStack(alignment: .top) {
            IconButtonView("gearshape.fill").opacity(0)
            Spacer()
            Image("MainLogo")
                .resizable()
                .scaledToFit()
                .frame(height: 156)
            Spacer()
            Button {
                showSettings.toggle()
            } label: {
                IconButtonView("gearshape.fill")
                    .offset(y: 18)
            }
        }
    }
    
    private var menuButtons: some View {
        VStack(spacing: 24) {
            NavigationLink(value: AppState.setPlayers.rawValue + GameMode.scenesFromAHat.rawValue) {
                MainMenuOptionView(title: "Scenes From a Hat", subtitle: "Classic WLIIA Game", icon: "gear", foregroundColor: .white, backgroundColor: .theme.accent)
            }
            NavigationLink(value: AppState.setPlayers.rawValue + GameMode.neverHaveIEver.rawValue) {
                MainMenuOptionView(title: "Never Have I Ever", subtitle: "Classic WLIIA Game", icon: "gear", foregroundColor: .white, backgroundColor: .theme.accent)
            }
            .navigationDestination(for: String.self) { pathValue in
                if pathValue == AppState.setPlayers.rawValue + GameMode.scenesFromAHat.rawValue {
                    SetPlayersView(gameMode: .scenesFromAHat)
                } else if pathValue == AppState.setPlayers.rawValue + GameMode.neverHaveIEver.rawValue {
                    SetPlayersView(gameMode: .neverHaveIEver)
                } else if pathValue == AppState.game.rawValue {
                    GameView()
                } else if pathValue == AppState.gameOver.rawValue {
                    GameOverView()
                }
            }
        }
    }
}
