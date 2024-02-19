//
//  PlayersViewModel.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 18/02/2024.
//

import Foundation

final class PlayersViewModel: ObservableObject {
    @Published var players: [Player] = []
    @Published var tempPlayers: [Player] = []
    @Published var currentPlayers: [Player] = []
    @Published var previousPlayer: Player?
    @Published var gameMode: GameMode?
    @Published var currentQuestionIndex = 0
    @Published var currentQuestion = ""
    @Published var questions = [
        "Question 1",
        "Question 2",
        "Question 3",
        "Question 4",
        "Question 5"
    ]
    @Published var gameIsOn: Bool = true
    
    var playersQueue: [Player] {
        let unreversed = players.filter { player in
            !currentPlayers.contains { $0.id == player.id }
        }
        return unreversed.reversed()
    }
    
    var currentPlayersIndices: [Int] = []
    
    func addPlayer(name: String, theme: PlayerTheme) {
        let newPlayer = Player(id: UUID().uuidString, name: name, theme: theme, lives: 3)
        tempPlayers.append(newPlayer)
    }
    
    func deletePlayer(id: String) {
        tempPlayers.removeAll { player in
            player.id == id
        }
    }
    
    func setGameMode(_ gameMode: GameMode) {
        self.gameMode = gameMode
    }
    
    func decreasePlayerLives(playerNumber: Int) {
        let currentPlayer = currentPlayers[playerNumber]
        let currentPlayerIndex = currentPlayersIndices[playerNumber]
        if currentPlayer.lives > 0 {
            currentPlayers[playerNumber].lives -= 1
            players[currentPlayerIndex].lives -= 1
        }
        
        if currentPlayers[playerNumber].lives == 0 {
            removePlayerFromGame(currentPlayer)
        }
        
        if players.count == 1 {
            endGame()
        }
    }
    
    func removePlayerFromGame(_ playerToRemove: Player) {
        players.removeAll { player in
            player.id == playerToRemove.id
        }
    }
    
    func nextPlayer(playerNumber: Int) {
        guard currentPlayersIndices.count > playerNumber  else { return }
        
        if gameMode == .scenesFromAHat {
            decreasePlayerLives(playerNumber: playerNumber)
        }
        
        if let firstInQueue = playersQueue.first {
            currentPlayers[playerNumber] = firstInQueue
            currentPlayersIndices[0] = players.firstIndex(where: { player in
                player.id == currentPlayers[0].id
            })!
            currentPlayersIndices[1] = players.firstIndex(where: { player in
                player.id == currentPlayers[1].id
            })!
        }
        
        print("all players: ", players)
        print("\n")
        print("players queue: ", playersQueue)
        print("\n")
        print("current players: ", currentPlayers)
        print("\n")
        print("current players indices: ", currentPlayersIndices)
    }
    
    func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            currentQuestion = questions[currentQuestionIndex]
        }
    }
    
    func startGame() {
        gameIsOn = true
        players = tempPlayers
        players.shuffle()
        switch(gameMode) {
        case .neverHaveIEver:
            currentPlayers = [players[0]]
            currentPlayersIndices = [0]
        case .scenesFromAHat:
            currentPlayers = [players[0], players[1]]
            currentPlayersIndices = [0, 1]
            print("all players: ", players)
            print("\n")
            print("players queue: ", playersQueue)
            print("\n")
            print("current players: ", currentPlayers)
            print("\n")
            print("current players indices: ", currentPlayersIndices)
        case .none:
            break
        }
    }
    
    func endGame() {
        gameIsOn = false
    }
    
    func resetPlayers() {
        players = []
        currentPlayers = []
        currentPlayersIndices = []
    }
    
    private func allPlayerIndicesAreUnique() -> Bool {
        return Set(currentPlayersIndices).count == currentPlayersIndices.count
    }
}
