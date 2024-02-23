//
//  PlayersViewModel.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 18/02/2024.
//

import Foundation
import SwiftUI

final class PlayersViewModel: ObservableObject {
    
    // Game
    @Published var gameMode: GameMode?
    @Published var settings: GameSettings = GameSettings() {
        didSet {
            for index in tempPlayers.indices {
                tempPlayers[index].setLives(settings.numberOfLives)
            }
        }
    }
    @Published var gameIsOn: Bool = true
    
    //Questions
    @Published var currentQuestionIndex = 0
    @Published var currentQuestion: String = ""
    @Published var currentTruthOrDareQuestion: TruthOrDareQuestion = TruthOrDareQuestion(truth: "", dare: "")
    @Published var currentTabooQuestion: TabooQuestion = TabooQuestion(wordToGuess: "", forbiddenWords: [""])
    @Published var questions: [String] = []
    @Published var truthOrDareQuestions: [TruthOrDareQuestion] = []
    @Published var tabooQuestions: [TabooQuestion] = []
    
    // Players
    @Published var players: [Player] = []
    @Published var tempPlayers: [Player] = []
    @Published var currentPlayers: [Player] = []
    @Published var playersQueue: [Player] = []
    @Published var removedPlayers: [Player] = []
    @Published var playersWithPlaces: [PlayerWithPlace] = []
    
    // Teams
    @Published var teams: [Team] = []
    @Published var tempTeams: [Team] = []
    @Published var currentTeam: Team? = nil
    @Published var teamsQueue: [Team] = []
    @Published var teamsWithPlaces: [TeamWithPlace] = []
    
    // Navigation
    @Published var navPath: [String] = []
    
    func goBack() {
        if navPath.count > 0 {
            navPath.removeLast()
        }
    }
    
    func goToMainMenu() {
        if navPath.count > 0 {
            navPath.removeAll()
        }
    }
    
    // Timer
    private lazy var timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in self.timeElapsed += 1
        if self.timeElapsed == self.settings.timeOfRound {
            // Time is up
            self.showNextTeamBoard()
        }
    }
    
    @Published var timeElapsed: Int = 0
    @Published var isShowingNextTeamBoard: Bool = false
    
    func addPlayer(name: String, theme: PlayerTheme) {
        let newPlayer = Player(id: UUID().uuidString, name: name, theme: theme, lives: settings.numberOfLives)
        tempPlayers.append(newPlayer)
    }
    
    func deletePlayer(id: String) {
        tempPlayers.removeAll { player in
            player.id == id
        }
    }
    
    func addTeam() {
        tempTeams.append(Team(id: UUID().uuidString))
    }
    
    func deleteTeam(id: String) {
        tempTeams.removeAll { team in
            team.id == id
        }
    }
    
    func addPlayerInTeam(teamIndex: Int, playerInTeamIndex: Int, name: String, theme: PlayerTheme) {
        let newPlayer = Player(id: UUID().uuidString, name: name, theme: theme, lives: 3)
        if playerInTeamIndex == 0 {
            tempTeams[teamIndex].player1 = newPlayer
        }
        if playerInTeamIndex == 1 {
            tempTeams[teamIndex].player2 = newPlayer
        }
    }
    
    func deletePlayerInTeam(id: String) {
        for (index, team) in tempTeams.enumerated() {
            if team.player1?.id == id {
                tempTeams[index].player1 = nil
                break
            }
            if team.player2?.id == id {
                tempTeams[index].player2 = nil
                break
            }
        }
    }
    
    func setGameMode(_ gameMode: GameMode) {
        self.gameMode = gameMode
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
    
    func nextTeam() {
        if let firstInQueue = teamsQueue.first {
            currentTeam = firstInQueue
            teamsQueue.append(currentTeam!)
            teamsQueue.remove(at: 0)
        }
    }
    
    func nextQuestion() {
        guard let gameMode = gameMode else { return }
        switch gameMode {
        case .scenesFromAHat:
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
        case .taboo:
            if currentQuestionIndex < tabooQuestions.count - 1 {
                currentQuestionIndex += 1
                currentTabooQuestion = tabooQuestions[currentQuestionIndex]
            } else {
                endGame()
            }
        }
    }
    
    func showNextTeamBoard() {
        isShowingNextTeamBoard = true
    }
    
    func nextTabooTeam() {
        isShowingNextTeamBoard = false
        timeElapsed = 0
    }
    
    func startGame() {
        guard let gameMode = gameMode else { return }
        gameIsOn = true
        resetPlayers()
        
        players = tempPlayers
        players.shuffle()

        teams = tempTeams
        teams.shuffle()
        
        currentPlayers = Array(players.prefix(upTo: gameMode.playersOnScreen))
        playersQueue = Array(players.suffix(from: gameMode.playersOnScreen))
        
        switch gameMode {
        case .scenesFromAHat:
            questions = gameMode.questions
            questions.shuffle()
            currentQuestion = questions.first!
        case .truthOrDare:
            truthOrDareQuestions = gameMode.truthOrDareQuestions
            truthOrDareQuestions.shuffle()
            truthOrDareQuestions = truthOrDareQuestions.suffix(settings.numberOfCards)
            currentTruthOrDareQuestion = truthOrDareQuestions.first!
        case .taboo:
            isShowingNextTeamBoard = true
            tabooQuestions = gameMode.tabooQuestions
            tabooQuestions.shuffle()
            currentTabooQuestion = tabooQuestions.first!
            timeElapsed = 0
            timer.fire()
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
            if index == 0 || allPlayers[index - 1].lives > player.lives{
                place += 1
            }
            let playerWithPlace = PlayerWithPlace(player: player, place: place)
            playersWithPlaces.append(playerWithPlace)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.gameIsOn = false
            self.navPath.append(AppState.gameOver.rawValue)
            self.currentQuestionIndex = 0
        }
    }
    
    func resetPlayers() {
        players = []
        currentPlayers = []
        removedPlayers = []
        playersWithPlaces = []
        
        teams = []
        currentTeam = nil
        teamsWithPlaces = []
    }
}
