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
    var playerVMs: [GameMode: PlayersViewModel] = [:]
    
    let players = [
        Player(id: "1", name: "John", theme: .playful, lives: 3),
        Player(id: "2", name: "Blake", theme: .dark, lives: 3),
        Player(id: "3", name: "Emily", theme: .animal, lives: 3),
        Player(id: "4", name: "Sophie", theme: .sportsy, lives: 3)
    ]
    
    private init() {
        self.playersVM = PlayersViewModel()
        self.playersVMWithSetPlayers = PlayersViewModel()
        self.playersVMWithSetPlayers.tempPlayers = players
        
        for mode in GameMode.allCases {
            let viewModel = PlayersViewModel()
            viewModel.setGameMode(mode)
            viewModel.tempPlayers = players
            viewModel.startGame()
            playerVMs[mode] = viewModel
        }
    }
}
