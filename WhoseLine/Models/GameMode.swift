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

enum GameMode: String, CaseIterable {
    case scenesFromAHat
    case truthOrDare
    case neverHaveIEver
    case taboo
    
    var minimumPlayers: Int {
        switch self {
        case .scenesFromAHat:
            return 3
        case .neverHaveIEver:
            return 2
        case .truthOrDare:
            return 2
        case .taboo:
            return 4
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
        case .taboo:
            return 2
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
        case .taboo:
            return "Taboo"
        }
    }
    
    var subtitle: String {
        switch self {
        case .scenesFromAHat:
            return "Classic improvisation game"
        case .neverHaveIEver:
            return "Past adventures revealed"
        case .truthOrDare:
            return "Everyone has played this one"
        case .taboo:
            return "Taboo subtitle"
        }
    }
    
    var icon: String {
        switch self {
        case .scenesFromAHat:
            return "theatermasks.fill"
        case .neverHaveIEver:
            return "eyes.inverse"
        case .truthOrDare:
            return "mouth.fill"
        case .taboo:
            return "mouth.fill"
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
        case .taboo:
            return "Taboo rules description"
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
                TruthOrDareQuestion(truth: "Truth 5", dare: "Dare 5"),
                TruthOrDareQuestion(truth: "Truth 6", dare: "Dare 6"),
                TruthOrDareQuestion(truth: "Truth 7", dare: "Dare 7")
            ]
        case .taboo:
            return []
        }
    }
    
    var tabooQuestions: [TabooQuestion] {
        switch self {
        case .scenesFromAHat, .neverHaveIEver, .truthOrDare:
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
        case .taboo:
            return []
        }
    }
}
