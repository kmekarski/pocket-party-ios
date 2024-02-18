//
//  HomeView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 13/02/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    var body: some View {
        ZStack {
            MainMenuView()
            SetPlayersView()
                .offset(y: homeVM.appState != .mainMenu ? 0 : UIScreen.main.bounds.height)
            GameView()
                .offset(y: homeVM.appState == .game ? 0 : UIScreen.main.bounds.height)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(dev.homeVM)
            .environmentObject(dev.playersVM)
    }
}
