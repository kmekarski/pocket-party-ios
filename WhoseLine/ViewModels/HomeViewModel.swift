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
    
    func goToNextState() {
        if let nextState = AppState(rawValue: appState.rawValue + 1) {
            withAnimation(.spring()) {
                appState = nextState
            }
        }
    }
    
    func goToPreviousState() {
        if let previousState = AppState(rawValue: appState.rawValue - 1) {
            withAnimation(.spring()) {
                appState = previousState
            }
        }
    }
}
