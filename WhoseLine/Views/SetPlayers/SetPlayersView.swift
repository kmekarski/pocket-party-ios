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
    
    private var playerIsValid: Bool {
        return !newPlayerName.isEmpty && selectedThemeIndex != nil
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
                showAddPlayerModel = true
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
                        SetPlayersTeamView(team: playersVM.tempTeams[index], teamIndex: index)
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
                    WideButtonView("Start Game", disabled: playersVM.tempPlayers.count < gameMode.minimumPlayers, size: .big, colorScheme: .primary)
                }
                .disabled(playersVM.tempPlayers.count < gameMode.minimumPlayers)
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
                guard playerIsValid else { return }
                playersVM.addPlayer(name: newPlayerName, theme: PlayerTheme.allCases[selectedThemeIndex!])
                newPlayerName = ""
                selectedThemeIndex = nil
                showAddPlayerModel = false
            }, label: {
                WideButtonView("Add", disabled: !playerIsValid, colorScheme: .primary)
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
