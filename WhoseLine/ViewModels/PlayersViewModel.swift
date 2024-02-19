//
//  PlayersViewModel.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 18/02/2024.
//

import Foundation

final class PlayersViewModel: ObservableObject {
    @Published var players: [Player] = []
    @Published var currentPlayers: [Player] = []
    @Published var gameMode: GameMode?
    var currentPlayersIndices: [Int] = []
    
    func addPlayer(name: String, theme: PlayerTheme) {
        let newPlayer = Player(id: UUID().uuidString, name: name, theme: theme)
        players.append(newPlayer)
    }
    
    func deletePlayer(id: String) {
        players.removeAll { player in
            player.id == id
        }
    }
    
    func setGameMode(_ gameMode: GameMode) {
        self.gameMode = gameMode
    }
    
    func nextPlayer(playerNumber: Int) {
        guard currentPlayersIndices.count > playerNumber  else { return }
        currentPlayersIndices[playerNumber] += 1
        if currentPlayersIndices[playerNumber] == players.count {
            currentPlayersIndices[playerNumber] = 0
        }
        while !allPlayerIndicesAreUnique() {
            currentPlayersIndices[playerNumber] += 1
            if currentPlayersIndices[playerNumber] == players.count {
                currentPlayersIndices[playerNumber] = 0
            }
        }
        currentPlayers[playerNumber] = players[currentPlayersIndices[playerNumber]]
    }
    
    func startGame() {
        players.shuffle()
        switch(gameMode) {
        case .neverHaveIEver:
            currentPlayers = [players[0]]
            currentPlayersIndices = [0]
        case .scenesFromAHat:
            currentPlayers = [players[0], players[1]]
            currentPlayersIndices = [0, 1]
        case .none:
            break
        }
    }
    
    private func allPlayerIndicesAreUnique() -> Bool {
        return Set(currentPlayersIndices).count == currentPlayersIndices.count
    }
}
