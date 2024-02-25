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
    
    var hasPoints: Bool {
        switch self {
        case .scenesFromAHat, .truthOrDare:
            false
        case .taboo:
            true
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
                TruthOrDareQuestion(truth: "What is the most embarrassing thing that has happened to you in public?", dare: "Do your best impression of a celebrity."),
                TruthOrDareQuestion(truth: "Have you ever cheated on a test or exam?", dare: "Sing a song loudly in public."),
                TruthOrDareQuestion(truth: "What is the silliest fear you have?", dare: "Call a friend and tell them a ridiculous story."),
                TruthOrDareQuestion(truth: "Have you ever pretended to be sick to get out of something? What was it?", dare: "Dance to a song of the group's choosing."),
                TruthOrDareQuestion(truth: "What's the strangest dream you've ever had?", dare: "Speak in an accent for the next 3 rounds."),
                TruthOrDareQuestion(truth: "What's the most trouble you've ever been in at school?", dare: "Wear socks on your hands for the next 10 minutes."),
                TruthOrDareQuestion(truth: "What's the grossest thing you've ever eaten?", dare: "Eat a spoonful of a condiment you dislike."),
                TruthOrDareQuestion(truth: "Have you ever snooped through someone else's phone or computer?", dare: "Send a text message to your crush or an ex."),
                TruthOrDareQuestion(truth: "What's the most childish thing you still do?", dare: "Do 20 jumping jacks."),
                TruthOrDareQuestion(truth: "What's the weirdest habit you have?", dare: "Wear your clothes backward for the next hour."),
                TruthOrDareQuestion(truth: "Have you ever lied to get out of trouble? What was it?", dare: "Do your best impression of a baby."),
                TruthOrDareQuestion(truth: "What's the most embarrassing thing you've ever Googled?", dare: "Do a cartwheel."),
                TruthOrDareQuestion(truth: "What's the most embarrassing thing your parents have caught you doing?", dare: "Try to lick your elbow."),
                TruthOrDareQuestion(truth: "Have you ever picked your nose and eaten it?", dare: "Wear a funny hat for the next hour."),
                TruthOrDareQuestion(truth: "What's the most embarrassing thing you've sent to the wrong person?", dare: "Speak only in whispers for the next 10 minutes."),
                TruthOrDareQuestion(truth: "Have you ever cheated in a game and got caught?", dare: "Do an impression of a famous movie character."),
                TruthOrDareQuestion(truth: "What's the most embarrassing thing you've done while under the influence?", dare: "Do the chicken dance."),
                TruthOrDareQuestion(truth: "Have you ever pretended to be someone else online?", dare: "Talk in a high-pitched voice for the next 5 minutes."),
                TruthOrDareQuestion(truth: "What's the most embarrassing thing you've said to someone you liked?", dare: "Try to juggle three objects of the group's choosing."),
                TruthOrDareQuestion(truth: "What's the most embarrassing thing you've worn in public?", dare: "Speak like a robot for the next 3 rounds."),
                TruthOrDareQuestion(truth: "Have you ever lied about your age?", dare: "Do a one-minute stand-up comedy routine."),
                TruthOrDareQuestion(truth: "What's the most embarrassing thing you've ever done in front of a crush?", dare: "Sing everything you say for the next 5 minutes."),
                TruthOrDareQuestion(truth: "Have you ever pretended to know someone you actually didn't?", dare: "Make up a rap about a random object."),
                TruthOrDareQuestion(truth: "What's the weirdest thing you've ever searched for on the internet?", dare: "Do your best impression of a famous singer."),
                TruthOrDareQuestion(truth: "What's the most embarrassing thing you've done at a party?", dare: "Wear sunglasses indoors for the next 15 minutes."),
                TruthOrDareQuestion(truth: "What's the most embarrassing thing you've posted on social media?", dare: "Speak in rhymes for the next 5 minutes."),
                TruthOrDareQuestion(truth: "Have you ever farted loudly in public?", dare: "Do an interpretive dance of a famous scene from a movie."),
                TruthOrDareQuestion(truth: "What's the most embarrassing thing your parents have caught you doing?", dare: "Wear your clothes inside out for the next hour."),
                TruthOrDareQuestion(truth: "What's the grossest thing you've ever eaten?", dare: "Do a handstand against a wall for 1 minute."),
                TruthOrDareQuestion(truth: "Have you ever walked into a glass door or window?", dare: "Speak in an accent for the next 3 rounds.")
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
                    "Animation",
                    "Character",
                    "Drawing",
                    "Show",
                ]),
                TabooQuestion(wordToGuess: "Lipstick", forbiddenWords: [
                    "Makeup",
                    "Cosmetic",
                    "Smear",
                    "Tube",
                ]),
                TabooQuestion(wordToGuess: "Football", forbiddenWords: [
                    "Soccer",
                    "Sport",
                    "Field",
                    "Touchdown",
                ]),
                TabooQuestion(wordToGuess: "Guitar", forbiddenWords: [
                    "Instrument",
                    "Music",
                    "Strings",
                    "Strum",
                ]),
                TabooQuestion(wordToGuess: "Coffee", forbiddenWords: [
                    "Beverage",
                    "Caffeine",
                    "Morning",
                    "Bean",
                ]),
                TabooQuestion(wordToGuess: "Computer", forbiddenWords: [
                    "Device",
                    "Machine",
                    "Internet",
                    "Keyboard",
                ]),
                TabooQuestion(wordToGuess: "Camera", forbiddenWords: [
                    "Photography",
                    "Picture",
                    "Lens",
                    "Shutter",
                ]),
                TabooQuestion(wordToGuess: "Book", forbiddenWords: [
                    "Novel",
                    "Story",
                    "Read",
                    "Chapter",
                ]),
                TabooQuestion(wordToGuess: "Pizza", forbiddenWords: [
                    "Italian",
                    "Food",
                    "Cheese",
                    "Slice",
                ]),
                TabooQuestion(wordToGuess: "Rainbow", forbiddenWords: [
                    "Colors",
                    "Sky",
                    "Arc",
                    "Pot of gold",
                ]),
                TabooQuestion(wordToGuess: "Car", forbiddenWords: [
                    "Automobile",
                    "Vehicle",
                    "Drive",
                    "Road",
                ]),
                TabooQuestion(wordToGuess: "Tree", forbiddenWords: [
                    "Plant",
                    "Wood",
                    "Leaves",
                    "Branch",
                ]),
                TabooQuestion(wordToGuess: "Dog", forbiddenWords: [
                    "Canine",
                    "Pet",
                    "Bark",
                    "Tail",
                ]),
                TabooQuestion(wordToGuess: "Cupcake", forbiddenWords: [
                    "Baking",
                    "Sweet",
                    "Frosting",
                    "Muffin",
                ]),
                TabooQuestion(wordToGuess: "Sunflower", forbiddenWords: [
                    "Plant",
                    "Yellow",
                    "Seeds",
                    "Sun",
                ]),
                TabooQuestion(wordToGuess: "Ocean", forbiddenWords: [
                    "Sea",
                    "Water",
                    "Wave",
                    "Beach",
                ]),
                TabooQuestion(wordToGuess: "Basketball", forbiddenWords: [
                    "Sport",
                    "Hoops",
                    "Court",
                    "Dribble",
                ]),
                TabooQuestion(wordToGuess: "Rain", forbiddenWords: [
                    "Precipitation",
                    "Water",
                    "Wet",
                    "Umbrella",
                ]),
                TabooQuestion(wordToGuess: "Movie", forbiddenWords: [
                    "Film",
                    "Cinema",
                    "Actor",
                    "Screen",
                ]),
                TabooQuestion(wordToGuess: "Cake", forbiddenWords: [
                    "Dessert",
                    "Birthday",
                    "Bake",
                    "Frosting",
                ]),
                TabooQuestion(wordToGuess: "Snowman", forbiddenWords: [
                    "Winter",
                    "Cold",
                    "Frosty",
                    "Carrot",
                ]),
                TabooQuestion(wordToGuess: "Phone", forbiddenWords: [
                    "Cellular",
                    "Call",
                    "Text",
                    "Screen",
                ]),
                TabooQuestion(wordToGuess: "Tiger", forbiddenWords: [
                    "Animal",
                    "Stripes",
                    "Roar",
                    "Wild",
                ]),
                TabooQuestion(wordToGuess: "Music", forbiddenWords: [
                    "Sound",
                    "Song",
                    "Beat",
                    "Melody",
                ]),
                TabooQuestion(wordToGuess: "Ice Cream", forbiddenWords: [
                    "Dessert",
                    "Cold",
                    "Scoop",
                    "Cone",
                ]),
                TabooQuestion(wordToGuess: "Dance", forbiddenWords: [
                    "Move",
                    "Rhythm",
                    "Groove",
                    "Step",
                ]),
                TabooQuestion(wordToGuess: "Chair", forbiddenWords: [
                    "Furniture",
                    "Sit",
                    "Legs",
                    "Seat",
                ]),
                TabooQuestion(wordToGuess: "Fire", forbiddenWords: [
                    "Flame",
                    "Heat",
                    "Burn",
                    "Campfire",
                ]),
                TabooQuestion(wordToGuess: "Train", forbiddenWords: [
                    "Rail",
                    "Transportation",
                    "Track",
                    "Choo-choo",
                ]),
                TabooQuestion(wordToGuess: "Banana", forbiddenWords: [
                    "Fruit",
                    "Yellow",
                    "Peel",
                    "Monkey",
                ]),
                TabooQuestion(wordToGuess: "Jacket", forbiddenWords: [
                    "Coat",
                    "Clothing",
                    "Warm",
                    "Zipper",
                ]),
                TabooQuestion(wordToGuess: "Clock", forbiddenWords: [
                    "Time",
                    "Tick",
                    "Alarm",
                    "Hands",
                ]),
                TabooQuestion(wordToGuess: "Bicycle", forbiddenWords: [
                    "Cycle",
                    "Two-wheeler",
                    "Pedal",
                    "Ride",
                ]),
                TabooQuestion(wordToGuess: "Painting", forbiddenWords: [
                    "Art",
                    "Canvas",
                    "Brush",
                    "Frame",
                ]),
                TabooQuestion(wordToGuess: "House", forbiddenWords: [
                    "Home",
                    "Building",
                    "Roof",
                    "Door",
                ]),
                TabooQuestion(wordToGuess: "Beach", forbiddenWords: [
                    "Sand",
                    "Ocean",
                    "Wave",
                    "Sun",
                ]),
                TabooQuestion(wordToGuess: "Elephant", forbiddenWords: [
                    "Animal",
                    "Trunk",
                    "Big",
                    "Gray",
                ]),
                TabooQuestion(wordToGuess: "Teacher", forbiddenWords: [
                    "Instructor",
                    "School",
                    "Educator",
                    "Class",
                ]),
                TabooQuestion(wordToGuess: "Shoes", forbiddenWords: [
                    "Footwear",
                    "Sneakers",
                    "Laces",
                    "Walk",
                ]),
                TabooQuestion(wordToGuess: "Flower", forbiddenWords: [
                    "Blossom",
                    "Petals",
                    "Plant",
                    "Garden",
                ]),
                TabooQuestion(wordToGuess: "Balloon", forbiddenWords: [
                    "Inflatable",
                    "Float",
                    "Pop",
                    "Helium",
                ]),
                TabooQuestion(wordToGuess: "Star", forbiddenWords: [
                    "Night",
                    "Sky",
                    "Twinkle",
                    "Shine",
                ]),
                TabooQuestion(wordToGuess: "Fish", forbiddenWords: [
                    "Aquatic",
                    "Swim",
                    "Scale",
                    "Water",
                ]),
                TabooQuestion(wordToGuess: "Doctor", forbiddenWords: [
                    "Physician",
                    "Medicine",
                    "Hospital",
                    "Patient",
                ]),
                TabooQuestion(wordToGuess: "Sunglasses", forbiddenWords: [
                    "Shade",
                    "Eyes",
                    "Sun",
                    "UV",
                ]),
                TabooQuestion(wordToGuess: "Moon", forbiddenWords: [
                    "Night",
                    "Sky",
                    "Lunar",
                    "Glow",
                ]),
                TabooQuestion(wordToGuess: "Chocolate", forbiddenWords: [
                    "Sweet",
                    "Candy",
                    "Cocoa",
                    "Brown",
                ]),
            ]
        }
    }
    
    var questions: [String] {
        switch self {
        case .scenesFromAHat:
            return [
                "It is the last night on an international singles' only cruise",
                "The police has been called in to investigate a robbery on a nudists' beach",
                "Tensions rise in the cottage of Snow White & the 7 Dwarfs",
                "You're on an international flight",
                "Scenes from Ancient Rome"
            ]
        case .truthOrDare:
            return []
        case .taboo:
            return []
        }
    }
}
