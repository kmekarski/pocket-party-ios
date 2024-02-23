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
    @Published var currentRoundIndex: Int = 1
    private var currentSubRoundIndex: Int = 1
    
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
            self.nextTeam()
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
        if gameMode == .taboo {
            currentSubRoundIndex += 1
            if currentSubRoundIndex > tempTeams.count {
                currentRoundIndex += 1
                currentSubRoundIndex = 1
            }
            if currentRoundIndex > settings.numberOfRounds {
                endGame()
            }
        }
        
        if let firstInQueue = teamsQueue.first, gameIsOn {
            teamsQueue.append(currentTeam!)
            currentTeam = firstInQueue
            currentTeam!.swapPlayers()
            teamsQueue.remove(at: 0)
        }
    }
    
    func nextTabooRound() {
        isShowingNextTeamBoard = false
        timeElapsed = 0
    }
    
    func showNextTeamBoard() {
        if currentRoundIndex <= settings.numberOfRounds {
            isShowingNextTeamBoard = true
        }
    }
    
    func givePointToTeam(teamId: String) {
        if let index = teams.firstIndex(where: { team in
            teamId == team.id
        }), currentTeam != nil {
            teams[index].givePoints(1)
            currentTeam!.givePoints(1)
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
    
    func startGame() {
        guard let gameMode = gameMode else { return }
        gameIsOn = true
        
        switch gameMode.setBeforeGame {
        case .players:
            resetPlayers()
            setUpPlayers()
        case .teams:
            resetTeams()
            setUpTeams()
        }
        
        setUpQuestions()
        setUpRounds()
        setUpTimer()
    }
    
    func setUpQuestions() {
        guard let gameMode = gameMode else { return }
        currentQuestionIndex = 0
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
            tabooQuestions = gameMode.tabooQuestions
            tabooQuestions.shuffle()
            currentTabooQuestion = tabooQuestions.first!
        }
    }
    
    func setUpRounds() {
        currentRoundIndex = 1
        currentSubRoundIndex = 1
    }
    
    func setUpTimer() {
        timeElapsed = 0
        timer.fire()
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
    
    func setUpTeams() {
        if tempTeams.count > 0 {
            teams = tempTeams
            teams.shuffle()
            currentTeam = teams.first!
            teamsQueue = Array(teams.suffix(from: 1))
            isShowingNextTeamBoard = true
        }
    }
    
    func resetPlayers() {
        players = []
        currentPlayers = []
        removedPlayers = []
        playersWithPlaces = []
    }
    
    func resetTeams() {
        teams = []
        currentTeam = nil
        teamsWithPlaces = []
    }
    
    func endGame() {
        guard let gameMode = gameMode else { return }
        
        switch gameMode.setBeforeGame {
        case .players:
            calculatePlayersPlaces()
        case .teams:
            calculateTeamsPlaces()
        }
        
        switch gameMode {
        case .scenesFromAHat, .truthOrDare:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.gameIsOn = false
                self.navPath.append(AppState.gameOver.rawValue)
                self.currentQuestionIndex = 0
            }
        case .taboo:
            self.gameIsOn = false
            self.navPath.append(AppState.gameOver.rawValue)
            self.currentQuestionIndex = 0
        }
    }
    
    func calculatePlayersPlaces() {
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
    }
    
    func calculateTeamsPlaces() {
        var allTeams: [Team] = []
        allTeams.append(contentsOf: teams)
        allTeams.sort { lhs, rhs in
            return lhs.points > rhs.points  // most points first
        }
        var place = 0
        for (index, team) in allTeams.enumerated() {
            if index == 0 || allTeams[index - 1].points > team.points{
                place += 1
            }
            let teamWithPlace = TeamWithPlace(team: team, place: place)
            teamsWithPlaces.append(teamWithPlace)
        }
        print(teamsWithPlaces)
    }
}
