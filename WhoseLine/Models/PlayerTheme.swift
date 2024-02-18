//
//  PlayerTheme.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 18/02/2024.
//

import Foundation
import SwiftUI

enum PlayerTheme: CaseIterable {
    case playful
    case sportsy
    case dark
    case artsy
    case animal
    case futuristic
    
    var color: Color {
        switch self {
        case .playful:
            return Color("PlayfulPlayerColor")
        case .sportsy:
            return Color("SportsyPlayerColor")
        case .dark:
            return Color("DarkPlayerColor")
        case .artsy:
            return Color("ArtsyPlayerColor")
        case .animal:
            return Color("AnimalPlayerColor")
        case .futuristic:
            return Color("FuturisticPlayerColor")
        }
    }
    
    var textColor: Color {
        switch self {
        case .playful, .sportsy, .animal:
            return .black
        case .dark, .artsy, .futuristic:
            return .white
        }
    }
    
    var emoji: String {
        switch self {
        case .playful:
            return "🎉"
        case .sportsy:
            return "🏀"
        case .dark:
            return "😈"
        case .artsy:
            return "🎨"
        case .animal:
            return "🐾"
        case .futuristic:
            return "🚀"
        }
    }
}
