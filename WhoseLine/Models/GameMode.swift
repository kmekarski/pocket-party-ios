//
//  GameMode.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 19/02/2024.
//

import Foundation

struct TruthOrDareQuestion {
    let truth: String
    let dare: String
}

enum GameMode: String, CaseIterable {
    case scenesFromAHat
    case truthOrDare
    case neverHaveIEver
    
    var minimumPlayers: Int {
        switch self {
        case .scenesFromAHat:
            return 3
        case .neverHaveIEver:
            return 2
        case .truthOrDare:
            return 2
        }
    }
    
    var playersOnScreen: Int {
        switch self {
        case .scenesFromAHat:
            return 2
        case .neverHaveIEver:
            return 1
        case .truthOrDare:
            return 1
        }
    }
    
    var title: String {
        switch self {
        case .scenesFromAHat:
            return "Scenes From a Hat"
        case .neverHaveIEver:
            return "Never Have I Ever"
        case .truthOrDare:
            return "Truth or Dare"
        }
    }
    
    var subtitle: String {
        switch self {
        case .scenesFromAHat:
            return "Scenes From a Hat2"
        case .neverHaveIEver:
            return "Never Have I Ever2"
        case .truthOrDare:
            return "Truth or Dare2"
        }
    }
    
    var icon: String {
        switch self {
        case .scenesFromAHat:
            return "gear"
        case .neverHaveIEver:
            return "heart"
        case .truthOrDare:
            return "heart.fill"
        }
    }
    
    var rulesDescription: String {
        switch self {
        case .scenesFromAHat:
            return "Scenes From a Hat is a game where players improvise scenes based on suggestions written on slips of paper."
        case .neverHaveIEver:
            return "Never Have I Ever is a game where players take turns admitting things they have never done."
        case .truthOrDare:
            return "Truth or Dare is a classic party game where players take turns choosing between answering a truth question or completing a dare."
        }
    }
    var truthOrDareQuestions: [TruthOrDareQuestion] {
        switch self {
        case .scenesFromAHat, .neverHaveIEver:
            return []
        case .truthOrDare:
            return [
                TruthOrDareQuestion(truth: "Truth 1", dare: "Dare 1"),
                TruthOrDareQuestion(truth: "Truth 2", dare: "Dare 2"),
                TruthOrDareQuestion(truth: "Truth 3", dare: "Dare 3"),
                TruthOrDareQuestion(truth: "Truth 4", dare: "Dare 4"),
                TruthOrDareQuestion(truth: "Truth 5", dare: "Dare 5")
            ]
        }
    }
    
    var questions: [String] {
           switch self {
           case .scenesFromAHat:
               return [
                   "Scene 1",
                   "Scene 2",
                   "Scene 3",
                   "Scene 4",
                   "Scene 5"
               ]
           case .neverHaveIEver:
               return [
                   "Question 1",
                   "Question 2",
                   "Question 3",
                   "Question 4",
                   "Question 5"
               ]
           case .truthOrDare:
               return []
           }
       }
}
