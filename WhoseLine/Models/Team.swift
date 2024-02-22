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
    
    var valid: Bool {
        return player1 != nil && player2 != nil
    }
}
