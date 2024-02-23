//
//  WhoseLineApp.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 13/02/2024.
//

import SwiftUI

@main
struct WhoseLineApp: App {
    var playersVM: PlayersViewModel
    
    init() {
        self.playersVM = PlayersViewModel()
    }
    var body: some Scene {
        WindowGroup {
            HomeView()
                .preferredColorScheme(.light)
                .environmentObject(playersVM)
        }
    }
}
