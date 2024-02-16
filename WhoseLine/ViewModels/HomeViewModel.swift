//
//  HomeViewModel.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 13/02/2024.
//

import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var appState: AppState = .mainMenu
    
    func startGame() {
        withAnimation(.spring()) {
            appState = .game
        }
    }
    
    func endGame() {
        withAnimation(.spring()) {
            appState = .mainMenu
        }
    }
}
