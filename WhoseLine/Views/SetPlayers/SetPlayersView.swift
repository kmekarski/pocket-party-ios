//
//  SetPlayersView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 18/02/2024.
//

import SwiftUI

struct SetPlayersView: View {
    @Environment(\.presentationMode) var presentationMode
//    @Binding var path: [String]
    @EnvironmentObject var playersVM: PlayersViewModel
    @State var showAddPlayerModel: Bool = false
    @State var newPlayerName: String = ""
    @State var selectedThemeIndex: Int?
    @State var selectedTeamIndex: Int?
    @State var selectedPlayerInTeamIndex: Int?
    var body: some View {
        ZStack {
            if let gameMode = playersVM.gameMode {
                Color.theme.background.ignoresSafeArea()
                VStack {
                    header
                    playersList
                    Spacer()
                    startButton
                }
                .padding()
                .padding(.horizontal)
                if collectionCount < gameMode.minimumPlayers {
                    tooFewPlayersInfo
                }
                ModalView(isShowing: $showAddPlayerModel, title: "New player", height: 210, content: {
                    addPlayerModalContent
                })
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview("Truth or Dare") {
    let playersVM = PlayersViewModel()
    playersVM.gameMode = .truthOrDare
    return NavigationStack {
        SetPlayersView()
    }
    .environmentObject(playersVM)
}

#Preview("Taboo") {
    let playersVM = PlayersViewModel()
    playersVM.gameMode = .taboo
    return NavigationStack {
        SetPlayersView()
    }
    .environmentObject(playersVM)
}

extension SetPlayersView {
    private var gameMode: GameMode {
        return playersVM.gameMode ?? .truthOrDare
    }
    
    private var collectionCount: Int {
        switch gameMode.setBeforeGame {
        case .players:
            playersVM.tempPlayers.count
        case .teams:
            playersVM.tempTeams.count
        }
    }
    
    private var isPlayerValid: Bool {
        return !newPlayerName.isEmpty && selectedThemeIndex != nil
    }
    
    private var isEverythingValid: Bool {
        switch gameMode.setBeforeGame {
        case .players:
            return collectionCount >= gameMode.minimumPlayers
        case .teams:
            let allTeamsValid = playersVM.tempTeams.allSatisfy { team in
                team.valid
            }
            return collectionCount >= gameMode.minimumPlayers && allTeamsValid
        }
    }
    
    private var header: some View {
        HStack(alignment: .top) {
            Button {
                playersVM.goBack()
            } label: {
                IconButtonView("arrow.left")
            }
            Spacer()
            Text(gameMode.setBeforeGame.rawValue.capitalized)
                .viewTitle()
            Spacer()
            Button {
                switch gameMode.setBeforeGame {
                case .players:
                    showAddPlayerModel = true
                case .teams:
                    playersVM.addTeam()
                }
            } label: {
                IconButtonView("plus")
            }
        }
    }
    
    private var playersList: some View {
        ScrollView {
            VStack(spacing: 12) {
                switch gameMode.setBeforeGame {
                case .players:
                    ForEach(playersVM.tempPlayers) { player in
                        SetPlayersPlayerView(player: player)
                    }
                case.teams:
                    ForEach(playersVM.tempTeams.indices, id: \.self) { index in
                        SetPlayersTeamView(selectedPlayerInTeamIndex: $selectedPlayerInTeamIndex, team: playersVM.tempTeams[index], teamIndex: index) {
                            showAddPlayerModel = true
                            selectedTeamIndex = index
                        } onXTap: {
                            playersVM.deleteTeam(id: playersVM.tempTeams[index].id)
                        }
                    }
                }
                
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 24)
    }
    
    private var tooFewPlayersInfo: some View {
        return VStack {
            if let gameMode = playersVM.gameMode {
                Spacer()
                Text(collectionCount == 0 ?  "No \(gameMode.setBeforeGame.rawValue) set to play" : "We need \(gameMode.minimumPlayers) or more \(gameMode.setBeforeGame.rawValue)")
                    .font(.system(size: 24))
                    .padding(.bottom, 4)
                Button(action: {
                    switch gameMode.setBeforeGame {
                    case .players:
                        showAddPlayerModel = true
                    case .teams:
                        playersVM.addTeam()
                    }
                }, label: {
                    Text("Let's add some!")
                        .font(.system(size: 28, weight: .semibold))
                })
                Spacer()
            }
        }
    }
    
    private var startButton: some View {
        VStack {
            if let gameMode = playersVM.gameMode {
                NavigationLink(value: "game") {
                    WideButtonView("Start Game", disabled: !isEverythingValid, size: .big, colorScheme: .primary)
                }
                .disabled(!isEverythingValid)
            }
        }
    }
    
    private var addPlayerModalContent: some View {
        VStack {
            RegularTextFieldView(title: "Name:", text: $newPlayerName)
            Divider()
            emojiPicker
            Spacer()
            Button(action: {
                guard isPlayerValid else { return }
                let newPlayerTheme = PlayerTheme.allCases[selectedThemeIndex!]
                switch gameMode.setBeforeGame {
                case .players:
                    playersVM.addPlayer(name: newPlayerName, theme: newPlayerTheme)
                    print(playersVM.tempPlayers)
                case .teams:
                    guard let selectedTeamIndex = selectedTeamIndex,
                          let selectedPlayerInTeamIndex = selectedPlayerInTeamIndex else { return }
                    playersVM.addPlayerInTeam(teamIndex: selectedTeamIndex, playerInTeamIndex: selectedPlayerInTeamIndex, name: newPlayerName, theme: newPlayerTheme)
                }
                newPlayerName = ""
                selectedThemeIndex = nil
                self.selectedTeamIndex = nil
                self.selectedPlayerInTeamIndex = nil
                showAddPlayerModel = false
            }, label: {
                WideButtonView("Add", disabled: !isPlayerValid, colorScheme: .primary)
            })
        }
    }
    
    private var emojiWidth: CGFloat { 40 }
    private var highlightSize: CGFloat { 48 }
    
    private var emojiHighlightOffset: CGFloat {
        if let index = selectedThemeIndex {
            return CGFloat(-2.5*emojiWidth + CGFloat(index) * emojiWidth)
        }
        return 0
    }
    
    private var emojiPicker: some View {
        ZStack {
            if selectedThemeIndex != nil {
                Rectangle()
                    .foregroundColor(.white.opacity(0.3))
                    .frame(width: highlightSize, height: highlightSize)
                    .cornerRadius(10)
                    .offset(x: emojiHighlightOffset)
            }
            HStack(spacing: 0) {
                ForEach(0..<PlayerTheme.allCases.count, id: \.self) { index in
                    Text(PlayerTheme.allCases[index].emoji)
                        .font(.system(size: selectedThemeIndex == index ? 36 : 24))
                        .frame(minWidth: emojiWidth)
                        .onTapGesture {
                            withAnimation(.linear(duration: 0.2)) {
                                selectedThemeIndex = index
                            }
                        }
                }
            }
            .frame(height: 30)
            .padding()
        }
    }
}
