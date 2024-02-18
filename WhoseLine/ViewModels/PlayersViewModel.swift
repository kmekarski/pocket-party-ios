//
//  PlayersViewModel.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 18/02/2024.
//

import Foundation

final class PlayersViewModel: ObservableObject {
    @Published var players: [Player] = []
    
    func addPlayer(_ name: String) {
        let newPlayer = Player(id: UUID().uuidString, name: name)
        players.append(newPlayer)
    }
    
    func deletePlayer(id: String) {
        players.removeAll { player in
            player.id == id
        }
    }
}
