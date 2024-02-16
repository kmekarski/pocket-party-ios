//
//  WhoseLineApp.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 13/02/2024.
//

import SwiftUI

@main
struct WhoseLineApp: App {
    @ObservedObject var homeVM = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(homeVM)
        }
    }
}
