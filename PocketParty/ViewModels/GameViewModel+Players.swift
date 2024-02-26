//
//  GameViewModel+Players.swift
//  PocketParty
//
//  Created by Klaudiusz Mękarski on 26/02/2024.
//

import Foundation

extension GameViewModel {
    
    func addPlayer(name: String, theme: PlayerTheme) {
        let newPlayer = Player(id: UUID().uuidString, name: name, theme: theme, lives: settings.numberOfLives)
        tempPlayers.append(newPlayer)
    }
    
    func deletePlayer(id: String) {
        tempPlayers.removeAll { player in
            player.id == id
        }
    }
    
    func decreasePlayerLives(playerNumber: Int) {
        let currentPlayer = currentPlayers[playerNumber]
        guard let currentPlayerIndex = players.firstIndex(where: { player in
            player.id == currentPlayer.id
        }) else { return }
        if currentPlayer.lives > 0 {
            currentPlayers[playerNumber].lives -= 1
            players[currentPlayerIndex].lives -= 1
        }
        
        if currentPlayers[playerNumber].lives == 0 {
            removePlayerFromGame(currentPlayers[playerNumber])
        }
        
        if players.count == 1 {
            endGame()
        }
    }
    
    func removePlayerFromGame(_ playerToRemove: Player) {
        players.removeAll { player in
            player.id == playerToRemove.id
        }
        removedPlayers.append(playerToRemove)
    }
    
    func nextPlayer(playerNumber: Int) {
        if let firstInQueue = playersQueue.first {
            let currentPlayer = currentPlayers[playerNumber]
            currentPlayers[playerNumber] = firstInQueue
            playersQueue.append(currentPlayer)
            playersQueue.remove(at: 0)
        }
    }
    
    func setUpPlayers() {
        guard let gameMode = gameMode else { return }
        if tempPlayers.count > 0 {
            players = tempPlayers
            players.shuffle()
            currentPlayers = Array(players.prefix(upTo: gameMode.playersOnScreen))
            playersQueue = Array(players.suffix(from: gameMode.playersOnScreen))
        }
    }
    
    func resetPlayers() {
        players = []
        currentPlayers = []
        removedPlayers = []
        playersWithPlaces = []
    }
}
