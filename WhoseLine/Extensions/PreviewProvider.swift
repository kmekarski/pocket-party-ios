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
    
    let homeVM: HomeViewModel
    let playersVM: PlayersViewModel
    let playersVMGame: PlayersViewModel
    
    let players = [
        Player(id: "1", name: "John", theme: .playful),
        Player(id: "1", name: "Blake", theme: .dark)
    ]
    
    private init() {
        self.homeVM = HomeViewModel()
        self.playersVM = PlayersViewModel()
        self.playersVMGame = PlayersViewModel()
        self.playersVMGame.players = players
        self.playersVMGame.startGame()
    }
}
