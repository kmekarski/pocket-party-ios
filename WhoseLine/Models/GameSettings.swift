//
//  GameSettings.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 23/02/2024.
//

import Foundation

struct GameSettings {
    private let defaultNumberOfLives = 2
    private let defaultNumberOfCards = 10
    private let defaultNumberOfRounds = 2
    private let defaultTimeOfRound = 30
    
    var numberOfLivesString: String?
    var numberOfCardsString: String?
    var numberOfRoundsString: String?
    var timeOfRoundString: String?
    
    init() {
        self.numberOfLivesString = String(defaultNumberOfLives)
        self.numberOfCardsString = String(defaultNumberOfCards)
        self.numberOfRoundsString = String(defaultNumberOfRounds)
        self.timeOfRoundString = String(defaultTimeOfRound)
    }
    
    var numberOfLives: Int {
        Int(numberOfLivesString ?? String(defaultNumberOfLives)) ?? defaultNumberOfLives
    }
    
    var numberOfCards: Int {
        Int(numberOfCardsString ?? String(defaultNumberOfCards)) ?? defaultNumberOfCards
    }
    
    var numberOfRounds: Int {
        Int(numberOfRoundsString ?? String(defaultNumberOfRounds)) ?? defaultNumberOfRounds
    }
    
    var timeOfRound: Int {
        Int(timeOfRoundString ?? String(defaultTimeOfRound)) ?? defaultTimeOfRound
    }
}
