//
//  PlayersViewModel.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 18/02/2024.
//

import Foundation
import SwiftUI

final class PlayersViewModel: ObservableObject {
    @Published var players: [Player] = []
    @Published var tempPlayers: [Player] = []
    @Published var currentPlayers: [Player] = []
    @Published var gameMode: GameMode?
    @Published var currentQuestionIndex = 0
    @Published var currentQuestion: String = ""
    @Published var currentTruthOrDareQuestion: TruthOrDareQuestion = TruthOrDareQuestion(truth: "", dare: "")
    @Published var questions: [String] = []
    @Published var truthOrDareQuestions: [TruthOrDareQuestion] = []
    @Published var gameIsOn: Bool = true
    
    @Published var playersQueue: [Player] = []
    
    @Published var removedPlayers: [Player] = []
    
    @Published var navPath: [String] = []
    
    func goBack() {
        navPath.removeLast()
    }
    
    func goToMainMenu() {
        navPath.removeAll()
    }
    
    @Published var topPlayersWithPlaces: [PlayerWithPlace] = []
    
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
        questions = gameMode.questions
        truthOrDareQuestions = gameMode.truthOrDareQuestions
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
            removePlayerFromGame(currentPlayer)
        }
        
        if players.count == 1 {
            endGame()
        }
        
        print("players count: ", players.count)
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
    
    func nextQuestion() {
        guard let gameMode = gameMode else { return }
        switch gameMode {
        case .neverHaveIEver, .scenesFromAHat:
            if currentQuestionIndex < questions.count - 1 {
                currentQuestionIndex += 1
                currentQuestion = questions[currentQuestionIndex]
            } else {
                endGame()
            }
        case .truthOrDare:
            if currentQuestionIndex < truthOrDareQuestions.count - 1 {
                currentQuestionIndex += 1
                currentTruthOrDareQuestion = truthOrDareQuestions[currentQuestionIndex]
            } else {
                endGame()
            }
            print(currentQuestionIndex, truthOrDareQuestions.count)
        }
    }
    
    func startGame() {
        guard let gameMode = gameMode else { return }
        withAnimation(.spring()) {
            gameIsOn = true
        }
        resetPlayers()
        players = tempPlayers
        players.shuffle()
        currentPlayers = Array(players.prefix(upTo: gameMode.playersOnScreen))
        playersQueue = Array(players.suffix(from: gameMode.playersOnScreen))
        
        switch gameMode {
        case .neverHaveIEver, .scenesFromAHat:
            questions.shuffle()
            currentQuestion = questions.first!
            currentQuestionIndex = 0
        case .truthOrDare:
            truthOrDareQuestions.shuffle()
            currentTruthOrDareQuestion = truthOrDareQuestions.first!
            currentQuestionIndex = 0
        }
    }
    
    func endGame() {
        var allPlayers: [Player] = []
        allPlayers.append(contentsOf: removedPlayers)
        allPlayers.append(contentsOf: players)
        allPlayers.sort { lhs, rhs in
            return lhs.lives > rhs.lives  // most lives first
        }
        var place = 0
        for (index, player) in allPlayers.enumerated() {
            if index == 3 {
                break
            }
            if index == 0 || allPlayers[index - 1].lives > player.lives{
                place += 1
            }
            let playerWithPlace = PlayerWithPlace(player: player, place: place)
            topPlayersWithPlaces.append(playerWithPlace)
        }
        print(topPlayersWithPlaces
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.gameIsOn = false
            self.navPath.append(AppState.gameOver.rawValue)
        }
    }
    
    func resetPlayers() {
        players = []
        currentPlayers = []
        removedPlayers = []
        topPlayersWithPlaces = []
    }
}
