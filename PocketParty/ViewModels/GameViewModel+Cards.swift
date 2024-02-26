//
//  GameViewModel+Cards.swift
//  PocketParty
//
//  Created by Klaudiusz Mękarski on 26/02/2024.
//

import Foundation

extension GameViewModel {
    func nextCard() {
        guard let gameMode = gameMode else { return }
        switch gameMode {
        case .questionsOnly:
            if currentCardIndex < questionsOnlyPrompts.count - 1 {
                currentCardIndex += 1
                currentQuestionsOnlyPrompt = questionsOnlyPrompts[currentCardIndex]
            } else {
                endGame()
            }
        case .truthOrDare:
            if currentCardIndex < truthOrDareCards.count - 1 {
                currentCardIndex += 1
                currentTruthOrDareCard = truthOrDareCards[currentCardIndex]
            } else {
                endGame()
            }
        case .taboo:
            if currentCardIndex < tabooCards.count - 1 {
                currentCardIndex += 1
                currentTabooCard = tabooCards[currentCardIndex]
            } else {
                endGame()
            }
        }
    }
    
    func setUpCards() {
        guard let gameMode = gameMode else { return }
        currentCardIndex = 0
        switch gameMode {
        case .questionsOnly:
            questionsOnlyPrompts = gameMode.questionsOnlyPrompts
            questionsOnlyPrompts.shuffle()
            currentQuestionsOnlyPrompt = questionsOnlyPrompts.first!
        case .truthOrDare:
            truthOrDareCards = gameMode.truthOrDareCards
            truthOrDareCards.shuffle()
            truthOrDareCards = truthOrDareCards.suffix(settings.numberOfCards)
            currentTruthOrDareCard = truthOrDareCards.first!
        case .taboo:
            tabooCards = gameMode.tabooCards
            tabooCards.shuffle()
            currentTabooCard = tabooCards.first!
        }
    }
}
