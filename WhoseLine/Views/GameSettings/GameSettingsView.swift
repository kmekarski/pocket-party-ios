//
//  GameSettingsView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 21/02/2024.
//

import SwiftUI

struct GameSettingsView: View {
    @EnvironmentObject var playersVM: PlayersViewModel
    var gameMode: GameMode
    @State var numberOfLivesOptionIndex: Int? = 2
    @State var numberOfCardsOptionIndex: Int? = 2
    @State var numberOfRoundsOptionIndex: Int? = 0
    @State var timeOfRoundOptionIndex: Int? = 1
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            VStack {
                header
                Spacer()
                Text(gameMode.rulesDescription)
                    .padding(.bottom)
                Text("Minimum number of players: \(minimumNumberOfPlayers)")
                settings
                Spacer()
                nextButton
            }
            .padding()
            .padding(.horizontal)
            .onAppear() {
                playersVM.setGameMode(gameMode)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview("Taboo") {
    NavigationStack {
        GameSettingsView(gameMode: .taboo)
            .environmentObject(PlayersViewModel())
    }
}

#Preview("Scenes From a Hat") {
    NavigationStack {
        GameSettingsView(gameMode: .scenesFromAHat)
            .environmentObject(PlayersViewModel())
    }
}

#Preview("Truth or Dare") {
    NavigationStack {
        GameSettingsView(gameMode: .truthOrDare)
            .environmentObject(PlayersViewModel())
    }
}

extension GameSettingsView {
    private var header: some View {
        HStack(alignment: .top) {
            Button {
                playersVM.goBack()
            } label: {
                IconButtonView("arrow.left")
            }
            Spacer()
            Text(gameMode.title)
                .viewTitle()
            Spacer()
            IconButtonView("plus").opacity(0)
        }
    }
    
    private var minimumNumberOfPlayers: Int {
        switch gameMode.setBeforeGame {
        case .players:
            return gameMode.minimumPlayers
        case .teams:
            return gameMode.minimumPlayers * 2
        }
    }
    
    private var settings: some View {
        VStack {
            switch gameMode {
            case .scenesFromAHat:
                let livesOptions = ["1", "2", "3"]
                VStack {
                    HStack {
                        Text("Number of lives: ")
                        CustomPickerView(collection:                     livesOptions, selectedIndex: $numberOfLivesOptionIndex)
                    }
                }
            case .truthOrDare:
                let numberOfCardsOptions = ["10", "15", "20"]
                let livesOptions = ["1", "2", "3"]
                VStack {
                    HStack {
                        Text("Number of cards: ")
                        CustomPickerView(collection:                     numberOfCardsOptions, selectedIndex: $numberOfCardsOptionIndex)
                    }
                    HStack {
                        Text("Number of lives: ")
                        CustomPickerView(collection:                     livesOptions, selectedIndex: $numberOfLivesOptionIndex)
                    }
                }
            case .taboo:
                let numberOfRoundsOptions = ["1", "2", "3"]
                let timeOfRoundOptions = ["20", "30", "40"]
                VStack {
                    HStack {
                        Text("Number of rounds: ")
                        CustomPickerView(collection:                     numberOfRoundsOptions, selectedIndex: $numberOfRoundsOptionIndex)
                    }
                    HStack {
                        Text("Time of round: ")
                        CustomPickerView(collection:                     timeOfRoundOptions, selectedIndex: $timeOfRoundOptionIndex)
                    }
                }
            }
        }
    }
    
    private var nextButton: some View {
        VStack {
            NavigationLink(value: "setPlayers") {
                WideButtonView("Next", disabled: false, size: .big, colorScheme: .primary)
            }
            .disabled(false)
        }
    }
}
