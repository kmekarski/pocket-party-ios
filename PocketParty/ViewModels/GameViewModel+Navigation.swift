//
//  GameViewModel+Navigation.swift
//  PocketParty
//
//  Created by Klaudiusz Mękarski on 26/02/2024.
//

import Foundation

extension GameViewModel {
    func goBack() {
        if navPath.count > 0 {
            navPath.removeLast()
        }
    }
    
    func goToMainMenu() {
        if navPath.count > 0 {
            navPath.removeAll()
        }
    }
}
