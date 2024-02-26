//
//  GameViewModel.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 18/02/2024.
//

import Foundation
import SwiftUI

final class GameViewModel: ObservableObject {
    
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
    var currentSubRoundIndex: Int = 1
    
    // Cards
    @Published var currentCardIndex = 0
    @Published var currentQuestionsOnlyPrompt: String = ""
    @Published var currentTruthOrDareCard: TruthOrDareCard = TruthOrDareCard(truth: "", dare: "")
    @Published var currentTabooCard: TabooCard = TabooCard(wordToGuess: "", forbiddenWords: [""])
    @Published var questionsOnlyPrompts: [String] = []
    @Published var truthOrDareCards: [TruthOrDareCard] = []
    @Published var tabooCards: [TabooCard] = []
    
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
    
    func setGameMode(_ gameMode: GameMode) {
        self.gameMode = gameMode
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
    
    func setUpRounds() {
        currentRoundIndex = 1
        currentSubRoundIndex = 1
    }
    
    func setUpTimer() {
        timeElapsed = 0
        timer.fire()
    }
}
