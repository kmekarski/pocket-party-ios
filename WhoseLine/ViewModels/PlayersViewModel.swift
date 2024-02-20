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
    
    @Published var playersQueue: [Player] = []
        
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
        let currentPlayerIndex = players.firstIndex { player in
            player.id == currentPlayer.id
        }!
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
        decreasePlayerLives(playerNumber: playerNumber)
        if let firstInQueue = playersQueue.first {
            let currentPlayer = currentPlayers[playerNumber]
            currentPlayers[playerNumber] = firstInQueue
            playersQueue.append(currentPlayer)
            playersQueue.remove(at: 0)
        }
        
        print("all players: ", players)
        print("\n")
        print("queue: ", playersQueue)
        print("\n")
        print("current: ", currentPlayers)
    }
    
    func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            currentQuestion = questions[currentQuestionIndex]
        }
    }
    
    func startGame() {
        guard let gameMode = gameMode else { return }
        gameIsOn = true
        players = tempPlayers
        players.shuffle()
        currentPlayers = Array(players.prefix(upTo: gameMode.playersOnScreen))
        playersQueue = Array(players.suffix(from: gameMode.playersOnScreen))
    }
    
    func endGame() {
        gameIsOn = false
    }
    
    func resetPlayers() {
        players = []
        currentPlayers = []
    }
}
