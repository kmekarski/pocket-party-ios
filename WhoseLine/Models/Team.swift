//
//  Team.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 22/02/2024.
//

import Foundation

struct Team: Identifiable {
    var id: String
    var player1: Player?
    var player2: Player?
    var points: Int = 0
    
    var valid: Bool {
        return player1 != nil && player2 != nil
    }
    
    mutating func swapPlayers() {
        swap(&player1, &player2)
    }
    
    mutating func givePoints(_ numberOfPoints: Int) {
        self.points += numberOfPoints
    }
}
