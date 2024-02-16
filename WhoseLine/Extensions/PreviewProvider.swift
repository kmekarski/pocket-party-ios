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
    let homeVMGame: HomeViewModel
    
    private init() {
        self.homeVM = HomeViewModel()
        self.homeVMGame = HomeViewModel()
        homeVMGame.startGame()
    }
}
