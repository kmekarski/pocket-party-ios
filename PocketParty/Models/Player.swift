//
//  Player.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 18/02/2024.
//

import Foundation

struct Player: Identifiable {
    var id: String
    var name: String
    var theme: PlayerTheme
    var lives: Int
    
    mutating func setLives(_ numberOfLives: Int) {
        self.lives = numberOfLives
    }
}
