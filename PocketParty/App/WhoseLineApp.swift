//
//  WhoseLineApp.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 13/02/2024.
//

import SwiftUI

@main
struct WhoseLineApp: App {
    var playersVM: GameViewModel
    
    init() {
        self.playersVM = GameViewModel()
    }
    var body: some Scene {
        WindowGroup {
            HomeView()
                .preferredColorScheme(.light)
                .environmentObject(playersVM)
        }
    }
}
