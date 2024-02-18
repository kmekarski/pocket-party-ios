//
//  WhoseLineApp.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 13/02/2024.
//

import SwiftUI

@main
struct WhoseLineApp: App {
    var homeVM: HomeViewModel
    var playersVM: PlayersViewModel
    
    init() {
        self.homeVM = HomeViewModel()
        self.playersVM = PlayersViewModel()
    }
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(homeVM)
        }
    }
}
