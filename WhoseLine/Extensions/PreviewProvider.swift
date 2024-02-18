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
    
    private init() {
        self.homeVM = HomeViewModel()
        self.playersVM = PlayersViewModel()
    }
}
