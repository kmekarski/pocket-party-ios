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
    @State var gameSettings: GameSettings = GameSettings()
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            VStack {
                header
                Text(gameMode.rulesDescription)
                    .font(.custom(size: 20))
                    .padding(.top)
                Divider()
                    .padding(.vertical)
                settingsView
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
    GameSettingsView(gameMode: .taboo)
        .environmentObject(PlayersViewModel())
}

#Preview("Scenes From a Hat") {
    GameSettingsView(gameMode: .scenesFromAHat)
        .environmentObject(PlayersViewModel())
}

#Preview("Truth or Dare") {
    GameSettingsView(gameMode: .truthOrDare)
        .environmentObject(PlayersViewModel())
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
    
    private var pickerWidth: CGFloat { 130 }
    
    private var settingsView: some View {
        VStack {
            HStack {
                Text("Number of players: ")
                Spacer()
                HStack(spacing: 0) {
                    Text("\(minimumNumberOfPlayers)+")
                        .font(.custom(size: 24))
                }
                .frame(width: pickerWidth)
            }
            .padding(.bottom)
            switch gameMode {
            case .scenesFromAHat:
                let livesOptions = ["1", "2", "3"]
                VStack {
                    HStack {
                        Text("Number of lives: ")
                        Spacer()
                        CustomPickerView(collection:                     livesOptions, selectedItem: $playersVM.settings.numberOfLivesString)
                            .frame(width: pickerWidth, alignment: .leading)
                    }
                }
            case .truthOrDare:
                let numberOfCardsOptions = ["10", "15", "20"]
                let livesOptions = ["1", "2", "3"]
                VStack {
                    HStack {
                        Text("Number of cards: ")
                        Spacer()
                        CustomPickerView(collection:                     numberOfCardsOptions, selectedItem: $playersVM.settings.numberOfCardsString)
                            .frame(width: pickerWidth, alignment: .leading)
                    }
                    HStack {
                        Text("Number of lives: ")
                        Spacer()
                        CustomPickerView(collection: livesOptions, selectedItem: $playersVM.settings.numberOfLivesString)
                            .frame(width: pickerWidth, alignment: .leading)
                    }
                }
            case .taboo:
                let numberOfRoundsOptions = ["1", "2", "3"]
                let timeOfRoundOptions = ["20", "30", "40"]
                VStack {
                    HStack {
                        Text("Number of rounds: ")
                        Spacer()
                        CustomPickerView(collection:                     numberOfRoundsOptions, selectedItem: $playersVM.settings.numberOfRoundsString)
                            .frame(width: pickerWidth, alignment: .leading)
                    }
                    HStack {
                        Text("Time of round: ")
                        Spacer()
                        CustomPickerView(collection:                     timeOfRoundOptions, selectedItem: $playersVM.settings.timeOfRoundString)
                            .frame(width: pickerWidth, alignment: .leading)

                    }
                }
            }
        }
        .font(.custom(size: 20, weight: .regular))
        .frame(maxWidth: 320)
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
