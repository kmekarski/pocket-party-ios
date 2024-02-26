//
//  GameViewModel+Game.swift
//  PocketParty
//
//  Created by Klaudiusz Mękarski on 26/02/2024.
//

import Foundation

extension GameViewModel {
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
        
        setUpCards()
        setUpRounds()
        setUpTimer()
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
        case .questionsOnly, .truthOrDare:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.gameIsOn = false
                self.navPath.append(AppState.gameOver.rawValue)
                self.currentCardIndex = 0
            }
        case .taboo:
            self.gameIsOn = false
            self.navPath.append(AppState.gameOver.rawValue)
            self.currentCardIndex = 0
        }
    }
}
