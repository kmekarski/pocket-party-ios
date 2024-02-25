//
//  PlayerWithPlace.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 21/02/2024.
//

import Foundation

struct PlayerWithPlace: Identifiable {
    var id: String
    var player: Player
    var place: Int
    
    init(player: Player, place: Int) {
        self.id = player.id
        self.player = player
        self.place = place
    }
}
