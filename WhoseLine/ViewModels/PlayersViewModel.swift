//
//  PlayersViewModel.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 18/02/2024.
//

import Foundation

final class PlayersViewModel: ObservableObject {
    @Published var players: [Player] = []
    @Published var currentPlayer: Player?
    var currentPlayerIndex: Int?
    
    func addPlayer(name: String, theme: PlayerTheme) {
        let newPlayer = Player(id: UUID().uuidString, name: name, theme: theme)
        players.append(newPlayer)
    }
    
    func deletePlayer(id: String) {
        players.removeAll { player in
            player.id == id
        }
    }
    
    func nextPlayer() {
        guard currentPlayerIndex != nil else { return }
        currentPlayerIndex! += 1
        if currentPlayerIndex == players.count {
            currentPlayerIndex = 0
        }
        currentPlayer = players[currentPlayerIndex!]
    }
    
    func startGame() {
        players.shuffle()
        currentPlayer = players.first
        currentPlayerIndex = 0
    }
    
}
