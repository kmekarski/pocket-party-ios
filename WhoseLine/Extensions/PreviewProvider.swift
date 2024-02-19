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
        Player(id: "1", name: "John", theme: .playful),
        Player(id: "2", name: "Blake", theme: .dark),
        Player(id: "3", name: "Emily", theme: .animal)
    ]
    
    private init() {
        self.homeVM = HomeViewModel()
        self.playersVM = PlayersViewModel()
        self.playersVMNeverHaveIEver = PlayersViewModel()
        self.playersVMNeverHaveIEver.setGameMode(.neverHaveIEver)
        self.playersVMNeverHaveIEver.players = players
        self.playersVMNeverHaveIEver.startGame()
        
        self.playersVMScenesFromAHat = PlayersViewModel()
        self.playersVMScenesFromAHat.setGameMode(.scenesFromAHat)
        self.playersVMScenesFromAHat.players = players
        self.playersVMScenesFromAHat.startGame()
    }
}
