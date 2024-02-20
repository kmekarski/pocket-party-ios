//
//  MainMenuView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 13/02/2024.
//

import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    @EnvironmentObject var playersVM: PlayersViewModel
    @State var showSettings: Bool = false
    var body: some View {
        NavigationStack {
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
            .environmentObject(dev.homeVM)
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
            NavigationLink {
                SetPlayersView(gameMode: .scenesFromAHat)
            } label: {
                MainMenuOptionView(title: "Scenes from a Hat", subtitle: "Classic WLIIA Game", icon: "gear", foregroundColor: .white, backgroundColor: .theme.accent)
            }
            
            NavigationLink {
                SetPlayersView(gameMode: .neverHaveIEver)
            } label: {
                MainMenuOptionView(title: "Never Have I Ever", subtitle: "Classic WLIIA Game", icon: "gear", foregroundColor: .white, backgroundColor: .theme.accent)
            }
        }
    }
}
