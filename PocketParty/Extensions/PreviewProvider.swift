//
//  PreviewProvider.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 13/02/2024.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    
    let playersVM: GameViewModel
    let playersVMWithSetPlayers: GameViewModel
    let playersVMAfterGame: GameViewModel
    var playerVMs: [GameMode: GameViewModel] = [:]
    
    let players = [
        Player(id: "1", name: "John", theme: .playful, lives: 3),
        Player(id: "2", name: "Blake", theme: .dark, lives: 3),
        Player(id: "3", name: "Emily", theme: .animal, lives: 3),
        Player(id: "4", name: "Sophie", theme: .sportsy, lives: 3)
    ]
    
    let emptyTeam = Team(id: "1")
    let halfEmptyTeam = Team(id: "2", player1: Player(id: "1", name: "John", theme: .playful, lives: 3))
    let fullTeam = Team(id: "3", player1: Player(id: "5", name: "John", theme: .playful, lives: 3), player2: Player(id: "6", name: "Emily", theme: .animal, lives: 3))
    
    let teams = [
        Team(id: "1", player1: Player(id: "1", name: "JohnTeam", theme: .playful, lives: 3), player2: Player(id: "2", name: "EmilyTeam", theme: .animal, lives: 3)),
        Team(id: "2", player1: Player(id: "3", name: "BlakeTeam", theme: .dark, lives: 3), player2: Player(id: "4", name: "SophieTeam", theme: .sportsy, lives: 3))
    ]
    
    let playersAfterGame = [
        Player(id: "1", name: "John", theme: .playful, lives: 3),
        Player(id: "2", name: "Blake", theme: .dark, lives: 2),
        Player(id: "3", name: "Emily", theme: .animal, lives: 2),
        Player(id: "4", name: "Sophie", theme: .sportsy, lives: 1)
    ]
    
    let playersWithPlaces = [
        PlayerWithPlace(player: Player(id: "1", name: "John", theme: .playful, lives: 3), place: 1),
        PlayerWithPlace(player: Player(id: "2", name: "Blake", theme: .dark, lives: 2), place: 2),
        PlayerWithPlace(player: Player(id: "3", name: "Emily", theme: .animal, lives: 2), place: 2),
        PlayerWithPlace(player: Player(id: "4", name: "Sopgie", theme: .sportsy, lives: 0), place: 3)
    ]
    
    let teamsWithPlaces = [
        TeamWithPlace(team: Team(id: "1", player1: Player(id: "1", name: "John", theme: .playful, lives: 3), player2: Player(id: "2", name: "Blake", theme: .dark, lives: 2), points: 10), place: 1),
        TeamWithPlace(team: Team(id: "2", player1: Player(id: "3", name: "Emily", theme: .animal, lives: 3), player2: Player(id: "4", name: "Sophie", theme: .sportsy, lives: 2), points: 7), place: 2),

    ]
    
    private init() {
        self.playersVM = GameViewModel()
        
        self.playersVMWithSetPlayers = GameViewModel()
        self.playersVMWithSetPlayers.tempPlayers = players
        self.playersVMWithSetPlayers.tempTeams = teams
        
        self.playersVMAfterGame = GameViewModel()
        self.playersVMAfterGame.setGameMode(.taboo)
        self.playersVMAfterGame.players = playersAfterGame
        self.playersVMAfterGame.playersWithPlaces = playersWithPlaces
        self.playersVMAfterGame.teamsWithPlaces = teamsWithPlaces
        
        for mode in GameMode.allCases {
            let viewModel = GameViewModel()
            viewModel.setGameMode(mode)
            viewModel.tempPlayers = players
            viewModel.tempTeams = teams
            viewModel.startGame()
            playerVMs[mode] = viewModel
        }
    }
}
