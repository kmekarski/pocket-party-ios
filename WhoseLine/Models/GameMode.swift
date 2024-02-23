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

struct TabooQuestion {
    let wordToGuess: String
    let forbiddenWords: [String]
}

enum SetBeforeGame: String {
    case players
    case teams
}

enum GameMode: String, CaseIterable {
    case scenesFromAHat
    case truthOrDare
    case taboo
    
    var minimumPlayers: Int {
        switch self {
        case .scenesFromAHat:
            return 3
        case .truthOrDare:
            return 2
        case .taboo:
            return 2
        }
    }
    
    var playersOnScreen: Int {
        switch self {
        case .scenesFromAHat:
            return 2
        case .truthOrDare:
            return 1
        case .taboo:
            return 2
        }
    }
    
    var setBeforeGame: SetBeforeGame {
        switch self {
        case .scenesFromAHat, .truthOrDare:
            return .players
        case .taboo:
            return .teams
        }
    }
    
    var title: String {
        switch self {
        case .scenesFromAHat:
            return "Scenes From a Hat"
        case .truthOrDare:
            return "Truth or Dare"
        case .taboo:
            return "Taboo"
        }
    }
    
    var subtitle: String {
        switch self {
        case .scenesFromAHat:
            return "Classic improvisation game"
        case .truthOrDare:
            return "Everyone has played this one"
        case .taboo:
            return "Guess it, but don't say it!"
        }
    }
    
    var icon: String {
        switch self {
        case .scenesFromAHat:
            return "theatermasks.fill"
        case .truthOrDare:
            return "eyes.inverse"
        case .taboo:
            return "mouth.fill"
        }
    }
    
    var rulesDescription: String {
        switch self {
        case .scenesFromAHat:
            return "Scenes From a Hat is a game where players improvise scenes based on suggestions written on slips of paper."
        case .truthOrDare:
            return "Truth or Dare is a classic party game where players take turns choosing between answering a truth question or completing a dare."
        case .taboo:
            return "Taboo is a word guessing game where players provide clues to their teammates without saying certain 'taboo' words."
        }
    }
    var truthOrDareQuestions: [TruthOrDareQuestion] {
        switch self {
        case .scenesFromAHat:
            return []
        case .truthOrDare:
            return [
                TruthOrDareQuestion(truth: "Truth 1", dare: "Dare 1"),
                TruthOrDareQuestion(truth: "Truth 2", dare: "Dare 2"),
                TruthOrDareQuestion(truth: "Truth 3", dare: "Dare 3"),
                TruthOrDareQuestion(truth: "Truth 4", dare: "Dare 4"),
                TruthOrDareQuestion(truth: "Truth 5", dare: "Dare 5"),
                TruthOrDareQuestion(truth: "Truth 6", dare: "Dare 6"),
                TruthOrDareQuestion(truth: "Truth 7", dare: "Dare 7"),
                TruthOrDareQuestion(truth: "Truth 8", dare: "Dare 8"),
                TruthOrDareQuestion(truth: "Truth 9", dare: "Dare 9"),
                TruthOrDareQuestion(truth: "Truth 10", dare: "Dare 10"),
                TruthOrDareQuestion(truth: "Truth 11", dare: "Dare 11"),
                TruthOrDareQuestion(truth: "Truth 12", dare: "Dare 12"),
                TruthOrDareQuestion(truth: "Truth 13", dare: "Dare 13"),
                TruthOrDareQuestion(truth: "Truth 14", dare: "Dare 14"),
                TruthOrDareQuestion(truth: "Truth 15", dare: "Dare 15"),
                TruthOrDareQuestion(truth: "Truth 16", dare: "Dare 16"),
                TruthOrDareQuestion(truth: "Truth 17", dare: "Dare 17"),
                TruthOrDareQuestion(truth: "Truth 18", dare: "Dare 18"),
                TruthOrDareQuestion(truth: "Truth 19", dare: "Dare 19"),
                TruthOrDareQuestion(truth: "Truth 20", dare: "Dare 20"),
                TruthOrDareQuestion(truth: "Truth 21", dare: "Dare 21"),
            ]
        case .taboo:
            return []
        }
    }
    
    var tabooQuestions: [TabooQuestion] {
        switch self {
        case .scenesFromAHat, .truthOrDare:
            return []
        case .taboo:
            return [
                TabooQuestion(wordToGuess: "Cartoon", forbiddenWords: [
                    "Forbidden 1",
                    "Forbidden 2",
                    "Forbidden 3",
                    "Forbidden 4",
                ]),
                TabooQuestion(wordToGuess: "Lipstick", forbiddenWords: [
                    "Forbidden 1",
                    "Forbidden 2",
                    "Forbidden 3",
                    "Forbidden 4",
                ]),
                TabooQuestion(wordToGuess: "Chicken", forbiddenWords: [
                    "Forbidden 1",
                    "Forbidden 2",
                    "Forbidden 3",
                    "Forbidden 4",
                ]),
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
        case .truthOrDare:
            return []
        case .taboo:
            return []
        }
    }
}
