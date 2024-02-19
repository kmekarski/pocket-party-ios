//
//  SetPlayersView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 18/02/2024.
//

import SwiftUI

struct SetPlayersView: View {
    @EnvironmentObject var homeVM: HomeViewModel
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
                    if !playersVM.tempPlayers.isEmpty {
                        playersList
                    }
                    Spacer()
                    Button(action: {
                        guard playersVM.tempPlayers.count >= gameMode.minimumPlayers else { return }
                        homeVM.goToNextState()
                        playersVM.startGame()
                    }, label: {
                        WideButtonView("Start Game", disabled: playersVM.tempPlayers.count < gameMode.minimumPlayers, size: .big, colorScheme: .primary)
                    })
                }
                .padding()
                .padding(.horizontal)
                if playersVM.tempPlayers.count < gameMode.minimumPlayers {
                    tooFewPlayersInfo
                }
                ModalView(isShowing: $showAddPlayerModel, title: "New player", height: 210, content: {
                    addPlayerModalContent
                })
            }
        }
    }
}

#Preview {
    let playersVM = PlayersViewModel()
    playersVM.gameMode = .neverHaveIEver
    return SetPlayersView()
        .environmentObject(HomeViewModel())
        .environmentObject(playersVM)
}

extension SetPlayersView {
    private var playerIsValid: Bool {
        return !newPlayerName.isEmpty && selectedThemeIndex != nil
    }
    
    private var header: some View {
        HStack(alignment: .top) {
            Button {
                homeVM.goToMainMenu()
            } label: {
                IconButtonView("arrow.left")
            }
            Spacer()
            Text("Players")
                .font(.system(size: 28, weight: .semibold))
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
                ForEach(playersVM.tempPlayers) { player in
                    SetPlayersRowView(player: player)
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 24)
    }
    
    private var tooFewPlayersInfo: some View {
        VStack {
            if let gameMode = playersVM.gameMode {
                Spacer()
                Text(playersVM.tempPlayers.count == 0 ?  "No players set to play" : "We need \(gameMode.minimumPlayers) or more players")
                    .font(.system(size: 24))
                    .padding(.bottom, 4)
                Button(action: {
                    showAddPlayerModel = true
                }, label: {
                    Text("Let's add some!")
                        .font(.system(size: 28, weight: .semibold))
                })
                Spacer()
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
    
    private var emojiWidth: CGFloat { 48 }
    private var highlightSize: CGFloat { 58 }
    
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
