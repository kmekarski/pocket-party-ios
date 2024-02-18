//
//  HomeViewModel.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 13/02/2024.
//

import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published private(set) var appState: AppState = .mainMenu
    
    func goToGame() {
        withAnimation(.spring()) {
            appState = .game
        }
    }
    
    func goToMainMenu() {
        withAnimation(.spring()) {
            appState = .mainMenu
        }
    }
    
    func goToSetPlayers() {
        withAnimation(.spring()) {
            appState = .setPlayers
        }
    }
}
