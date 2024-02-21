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
    
    let playersVM: PlayersViewModel
    let playersVMWithSetPlayers: PlayersViewModel
    let playersVMAfterGame: PlayersViewModel
    var playerVMs: [GameMode: PlayersViewModel] = [:]
    
    let players = [
        Player(id: "1", name: "John", theme: .playful, lives: 3),
        Player(id: "2", name: "Blake", theme: .dark, lives: 3),
        Player(id: "3", name: "Emily", theme: .animal, lives: 3),
        Player(id: "4", name: "Sophie", theme: .sportsy, lives: 3)
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
        PlayerWithPlace(player: Player(id: "4", name: "Sopgie", theme: .sportsy, lives: 1), place: 3)
    ]
    
    private init() {
        self.playersVM = PlayersViewModel()
        
        self.playersVMWithSetPlayers = PlayersViewModel()
        self.playersVMWithSetPlayers.tempPlayers = players
        
        self.playersVMAfterGame = PlayersViewModel()
        self.playersVMAfterGame.players = playersAfterGame
        self.playersVMAfterGame.playersWithPlaces = playersWithPlaces
        
        for mode in GameMode.allCases {
            let viewModel = PlayersViewModel()
            viewModel.setGameMode(mode)
            viewModel.tempPlayers = players
            viewModel.startGame()
            playerVMs[mode] = viewModel
        }
    }
}
