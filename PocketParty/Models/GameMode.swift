//
//  GameMode.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 19/02/2024.
//

import Foundation

struct TruthOrDareCard {
    let truth: String
    let dare: String
}

struct TabooCard {
    let wordToGuess: String
    let forbiddenWords: [String]
}

enum SetBeforeGame: String {
    case players
    case teams
}

enum GameMode: String, CaseIterable {
    case questionsOnly
    case truthOrDare
    case taboo
    
    var minimumPlayers: Int {
        switch self {
        case .questionsOnly:
            return 3
        case .truthOrDare:
            return 2
        case .taboo:
            return 2
        }
    }
    
    var playersOnScreen: Int {
        switch self {
        case .questionsOnly:
            return 2
        case .truthOrDare:
            return 1
        case .taboo:
            return 2
        }
    }
    
    var setBeforeGame: SetBeforeGame {
        switch self {
        case .questionsOnly, .truthOrDare:
            return .players
        case .taboo:
            return .teams
        }
    }
    
    var hasPoints: Bool {
        switch self {
        case .questionsOnly, .truthOrDare:
            false
        case .taboo:
            true
        }
    }
    
    var title: String {
        switch self {
        case .questionsOnly:
            return "Questions only"
        case .truthOrDare:
            return "Truth or Dare"
        case .taboo:
            return "Taboo"
        }
    }
    
    var subtitle: String {
        switch self {
        case .questionsOnly:
            return "Classic improvisation game"
        case .truthOrDare:
            return "Everyone has played this one"
        case .taboo:
            return "Guess it, but don't say it!"
        }
    }
    
    var icon: String {
        switch self {
        case .questionsOnly:
            return "theatermasks.fill"
        case .truthOrDare:
            return "eyes.inverse"
        case .taboo:
            return "mouth.fill"
        }
    }
    
    var rulesDescription: String {
        switch self {
        case .questionsOnly:
            return "Questions Only is an improvisational game where players engage in scenes while communicating only through questions. Player who breaks this rule is swapped for another one."
        case .truthOrDare:
            return "Truth or Dare is a classic party game where players take turns choosing between answering a truth question or completing a dare."
        case .taboo:
            return "Taboo is a word guessing game where players provide clues to their teammates without saying certain 'taboo' words."
        }
    }
    var truthOrDareCards: [TruthOrDareCard] {
        switch self {
        case .questionsOnly:
            return []
        case .truthOrDare:
            return [
                TruthOrDareCard(truth: "What is the most embarrassing thing that has happened to you in public?", dare: "Do your best impression of a celebrity."),
                TruthOrDareCard(truth: "Have you ever cheated on a test or exam?", dare: "Sing a song loudly in public."),
                TruthOrDareCard(truth: "What is the silliest fear you have?", dare: "Call a friend and tell them a ridiculous story."),
                TruthOrDareCard(truth: "Have you ever pretended to be sick to get out of something? What was it?", dare: "Dance to a song of the group's choosing."),
                TruthOrDareCard(truth: "What's the strangest dream you've ever had?", dare: "Speak in an accent for the next 3 rounds."),
                TruthOrDareCard(truth: "What's the most trouble you've ever been in at school?", dare: "Wear socks on your hands for the next 10 minutes."),
                TruthOrDareCard(truth: "What's the grossest thing you've ever eaten?", dare: "Eat a spoonful of a condiment you dislike."),
                TruthOrDareCard(truth: "Have you ever snooped through someone else's phone or computer?", dare: "Send a text message to your crush or an ex."),
                TruthOrDareCard(truth: "What's the most childish thing you still do?", dare: "Do 20 jumping jacks."),
                TruthOrDareCard(truth: "What's the weirdest habit you have?", dare: "Wear your clothes backward for the next hour."),
                TruthOrDareCard(truth: "Have you ever lied to get out of trouble? What was it?", dare: "Do your best impression of a baby."),
                TruthOrDareCard(truth: "What's the most embarrassing thing you've ever Googled?", dare: "Do a cartwheel."),
                TruthOrDareCard(truth: "What's the most embarrassing thing your parents have caught you doing?", dare: "Try to lick your elbow."),
                TruthOrDareCard(truth: "Have you ever picked your nose and eaten it?", dare: "Wear a funny hat for the next hour."),
                TruthOrDareCard(truth: "What's the most embarrassing thing you've sent to the wrong person?", dare: "Speak only in whispers for the next 10 minutes."),
                TruthOrDareCard(truth: "Have you ever cheated in a game and got caught?", dare: "Do an impression of a famous movie character."),
                TruthOrDareCard(truth: "What's the most embarrassing thing you've done while under the influence?", dare: "Do the chicken dance."),
                TruthOrDareCard(truth: "Have you ever pretended to be someone else online?", dare: "Talk in a high-pitched voice for the next 5 minutes."),
                TruthOrDareCard(truth: "What's the most embarrassing thing you've said to someone you liked?", dare: "Try to juggle three objects of the group's choosing."),
                TruthOrDareCard(truth: "What's the most embarrassing thing you've worn in public?", dare: "Speak like a robot for the next 3 rounds."),
                TruthOrDareCard(truth: "Have you ever lied about your age?", dare: "Do a one-minute stand-up comedy routine."),
                TruthOrDareCard(truth: "What's the most embarrassing thing you've ever done in front of a crush?", dare: "Sing everything you say for the next 5 minutes."),
                TruthOrDareCard(truth: "Have you ever pretended to know someone you actually didn't?", dare: "Make up a rap about a random object."),
                TruthOrDareCard(truth: "What's the weirdest thing you've ever searched for on the internet?", dare: "Do your best impression of a famous singer."),
                TruthOrDareCard(truth: "What's the most embarrassing thing you've done at a party?", dare: "Wear sunglasses indoors for the next 15 minutes."),
                TruthOrDareCard(truth: "What's the most embarrassing thing you've posted on social media?", dare: "Speak in rhymes for the next 5 minutes."),
                TruthOrDareCard(truth: "Have you ever farted loudly in public?", dare: "Do an interpretive dance of a famous scene from a movie."),
                TruthOrDareCard(truth: "What's the most embarrassing thing your parents have caught you doing?", dare: "Wear your clothes inside out for the next hour."),
                TruthOrDareCard(truth: "What's the grossest thing you've ever eaten?", dare: "Do a handstand against a wall for 1 minute."),
                TruthOrDareCard(truth: "Have you ever walked into a glass door or window?", dare: "Speak in an accent for the next 3 rounds.")
                ]
        case .taboo:
            return []
        }
    }
    
    var tabooCards: [TabooCard] {
        switch self {
        case .questionsOnly, .truthOrDare:
            return []
        case .taboo:
            return [
                TabooCard(wordToGuess: "Cartoon", forbiddenWords: [
                    "Animation",
                    "Character",
                    "Drawing",
                    "Show",
                ]),
                TabooCard(wordToGuess: "Lipstick", forbiddenWords: [
                    "Makeup",
                    "Cosmetic",
                    "Smear",
                    "Tube",
                ]),
                TabooCard(wordToGuess: "Football", forbiddenWords: [
                    "Soccer",
                    "Sport",
                    "Field",
                    "Touchdown",
                ]),
                TabooCard(wordToGuess: "Guitar", forbiddenWords: [
                    "Instrument",
                    "Music",
                    "Strings",
                    "Strum",
                ]),
                TabooCard(wordToGuess: "Coffee", forbiddenWords: [
                    "Beverage",
                    "Caffeine",
                    "Morning",
                    "Bean",
                ]),
                TabooCard(wordToGuess: "Computer", forbiddenWords: [
                    "Device",
                    "Machine",
                    "Internet",
                    "Keyboard",
                ]),
                TabooCard(wordToGuess: "Camera", forbiddenWords: [
                    "Photography",
                    "Picture",
                    "Lens",
                    "Shutter",
                ]),
                TabooCard(wordToGuess: "Book", forbiddenWords: [
                    "Novel",
                    "Story",
                    "Read",
                    "Chapter",
                ]),
                TabooCard(wordToGuess: "Pizza", forbiddenWords: [
                    "Italian",
                    "Food",
                    "Cheese",
                    "Slice",
                ]),
                TabooCard(wordToGuess: "Rainbow", forbiddenWords: [
                    "Colors",
                    "Sky",
                    "Arc",
                    "Pot of gold",
                ]),
                TabooCard(wordToGuess: "Car", forbiddenWords: [
                    "Automobile",
                    "Vehicle",
                    "Drive",
                    "Road",
                ]),
                TabooCard(wordToGuess: "Tree", forbiddenWords: [
                    "Plant",
                    "Wood",
                    "Leaves",
                    "Branch",
                ]),
                TabooCard(wordToGuess: "Dog", forbiddenWords: [
                    "Canine",
                    "Pet",
                    "Bark",
                    "Tail",
                ]),
                TabooCard(wordToGuess: "Cupcake", forbiddenWords: [
                    "Baking",
                    "Sweet",
                    "Frosting",
                    "Muffin",
                ]),
                TabooCard(wordToGuess: "Sunflower", forbiddenWords: [
                    "Plant",
                    "Yellow",
                    "Seeds",
                    "Sun",
                ]),
                TabooCard(wordToGuess: "Ocean", forbiddenWords: [
                    "Sea",
                    "Water",
                    "Wave",
                    "Beach",
                ]),
                TabooCard(wordToGuess: "Basketball", forbiddenWords: [
                    "Sport",
                    "Hoops",
                    "Court",
                    "Dribble",
                ]),
                TabooCard(wordToGuess: "Rain", forbiddenWords: [
                    "Precipitation",
                    "Water",
                    "Wet",
                    "Umbrella",
                ]),
                TabooCard(wordToGuess: "Movie", forbiddenWords: [
                    "Film",
                    "Cinema",
                    "Actor",
                    "Screen",
                ]),
                TabooCard(wordToGuess: "Cake", forbiddenWords: [
                    "Dessert",
                    "Birthday",
                    "Bake",
                    "Frosting",
                ]),
                TabooCard(wordToGuess: "Snowman", forbiddenWords: [
                    "Winter",
                    "Cold",
                    "Frosty",
                    "Carrot",
                ]),
                TabooCard(wordToGuess: "Phone", forbiddenWords: [
                    "Cellular",
                    "Call",
                    "Text",
                    "Screen",
                ]),
                TabooCard(wordToGuess: "Tiger", forbiddenWords: [
                    "Animal",
                    "Stripes",
                    "Roar",
                    "Wild",
                ]),
                TabooCard(wordToGuess: "Music", forbiddenWords: [
                    "Sound",
                    "Song",
                    "Beat",
                    "Melody",
                ]),
                TabooCard(wordToGuess: "Ice Cream", forbiddenWords: [
                    "Dessert",
                    "Cold",
                    "Scoop",
                    "Cone",
                ]),
                TabooCard(wordToGuess: "Dance", forbiddenWords: [
                    "Move",
                    "Rhythm",
                    "Groove",
                    "Step",
                ]),
                TabooCard(wordToGuess: "Chair", forbiddenWords: [
                    "Furniture",
                    "Sit",
                    "Legs",
                    "Seat",
                ]),
                TabooCard(wordToGuess: "Fire", forbiddenWords: [
                    "Flame",
                    "Heat",
                    "Burn",
                    "Campfire",
                ]),
                TabooCard(wordToGuess: "Train", forbiddenWords: [
                    "Rail",
                    "Transportation",
                    "Track",
                    "Choo-choo",
                ]),
                TabooCard(wordToGuess: "Banana", forbiddenWords: [
                    "Fruit",
                    "Yellow",
                    "Peel",
                    "Monkey",
                ]),
                TabooCard(wordToGuess: "Jacket", forbiddenWords: [
                    "Coat",
                    "Clothing",
                    "Warm",
                    "Zipper",
                ]),
                TabooCard(wordToGuess: "Clock", forbiddenWords: [
                    "Time",
                    "Tick",
                    "Alarm",
                    "Hands",
                ]),
                TabooCard(wordToGuess: "Bicycle", forbiddenWords: [
                    "Cycle",
                    "Two-wheeler",
                    "Pedal",
                    "Ride",
                ]),
                TabooCard(wordToGuess: "Painting", forbiddenWords: [
                    "Art",
                    "Canvas",
                    "Brush",
                    "Frame",
                ]),
                TabooCard(wordToGuess: "House", forbiddenWords: [
                    "Home",
                    "Building",
                    "Roof",
                    "Door",
                ]),
                TabooCard(wordToGuess: "Beach", forbiddenWords: [
                    "Sand",
                    "Ocean",
                    "Wave",
                    "Sun",
                ]),
                TabooCard(wordToGuess: "Elephant", forbiddenWords: [
                    "Animal",
                    "Trunk",
                    "Big",
                    "Gray",
                ]),
                TabooCard(wordToGuess: "Teacher", forbiddenWords: [
                    "Instructor",
                    "School",
                    "Educator",
                    "Class",
                ]),
                TabooCard(wordToGuess: "Shoes", forbiddenWords: [
                    "Footwear",
                    "Sneakers",
                    "Laces",
                    "Walk",
                ]),
                TabooCard(wordToGuess: "Flower", forbiddenWords: [
                    "Blossom",
                    "Petals",
                    "Plant",
                    "Garden",
                ]),
                TabooCard(wordToGuess: "Balloon", forbiddenWords: [
                    "Inflatable",
                    "Float",
                    "Pop",
                    "Helium",
                ]),
                TabooCard(wordToGuess: "Star", forbiddenWords: [
                    "Night",
                    "Sky",
                    "Twinkle",
                    "Shine",
                ]),
                TabooCard(wordToGuess: "Fish", forbiddenWords: [
                    "Aquatic",
                    "Swim",
                    "Scale",
                    "Water",
                ]),
                TabooCard(wordToGuess: "Doctor", forbiddenWords: [
                    "Physician",
                    "Medicine",
                    "Hospital",
                    "Patient",
                ]),
                TabooCard(wordToGuess: "Sunglasses", forbiddenWords: [
                    "Shade",
                    "Eyes",
                    "Sun",
                    "UV",
                ]),
                TabooCard(wordToGuess: "Moon", forbiddenWords: [
                    "Night",
                    "Sky",
                    "Lunar",
                    "Glow",
                ]),
                TabooCard(wordToGuess: "Chocolate", forbiddenWords: [
                    "Sweet",
                    "Candy",
                    "Cocoa",
                    "Brown",
                ]),
            ]
        }
    }
    
    var questionsOnlyPrompts: [String] {
        switch self {
        case .questionsOnly:
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
