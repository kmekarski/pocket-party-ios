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
            Button {
                homeVM.goToNextState()
                playersVM.setGameMode(.scenesFromAHat)
            } label: {
                MainMenuOptionView(title: "Scenes from a Hat", subtitle: "Classic WLIIA Game", icon: "gear", foregroundColor: .white, backgroundColor: .theme.accent)
            }
            Button {
                homeVM.goToNextState()
                playersVM.setGameMode(.neverHaveIEver)
            } label: {
                MainMenuOptionView(title: "Never have I ever", subtitle: "Everyone have played that", icon: "gear", foregroundColor: .white, backgroundColor: .theme.accent)
            }
        }
    }
}
