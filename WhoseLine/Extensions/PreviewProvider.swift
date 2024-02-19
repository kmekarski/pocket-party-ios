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
    let playersVMNeverHaveIEver: PlayersViewModel
    let playersVMScenesFromAHat: PlayersViewModel
    
    let players = [
        Player(id: "1", name: "John", theme: .playful, lives: 3),
        Player(id: "2", name: "Blake", theme: .dark, lives: 3),
        Player(id: "3", name: "Emily", theme: .animal, lives: 3),
        Player(id: "4", name: "Sophie", theme: .sportsy, lives: 3)
    ]
    
    private init() {
        self.homeVM = HomeViewModel()
        self.playersVM = PlayersViewModel()
        self.playersVMNeverHaveIEver = PlayersViewModel()
        self.playersVMNeverHaveIEver.setGameMode(.neverHaveIEver)
        self.playersVMNeverHaveIEver.tempPlayers = players
        self.playersVMNeverHaveIEver.startGame()
        
        self.playersVMScenesFromAHat = PlayersViewModel()
        self.playersVMScenesFromAHat.setGameMode(.scenesFromAHat)
        self.playersVMScenesFromAHat.tempPlayers = players
        self.playersVMScenesFromAHat.startGame()
    }
}
