//
//  GameMode.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 19/02/2024.
//

import Foundation

enum GameMode {
    case scenesFromAHat
    case neverHaveIEver
    
    var minimumPlayers: Int {
        switch self {
        case .scenesFromAHat:
            return 3
        case .neverHaveIEver:
            return 2
        }
    }
    
    var playersOnScreen: Int {
        switch self {
        case .scenesFromAHat:
            return 2
        case .neverHaveIEver:
            return 1
        }
    }
    
    var title: String {
        switch self {
        case .scenesFromAHat:
            return "Scenes From a Hat"
        case .neverHaveIEver:
            return "Never Have I Ever"
        }
    }
    
    var rulesDescription: String {
        switch self {
        case .scenesFromAHat:
            return "Scenes From a Hat is a game where players improvise scenes based on suggestions written on slips of paper."
        case .neverHaveIEver:
            return "Never Have I Ever is a game where players take turns admitting things they have never done."
        }
    }
}
