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
    @State var showAddPlayerModel: Bool = true
    @State var newPlayerName: String = ""
    @State var selectedThemeIndex: Int?
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            VStack {
                header
                if playersVM.players.isEmpty {
                    noPlayersInfo
                } else {
                    playersList
                }
                Spacer()
                Button(action: {
                    homeVM.goToGame()
                }, label: {
                    WideButtonView("Start Game", disabled: playersVM.players.isEmpty, size: .big, colorScheme: .primary)
                })
            }
            .padding()
            .padding(.horizontal)
            ModalView(isShowing: $showAddPlayerModel, title: "New player", height: 210, content: {
                addPlayerModalContent
            })
        }
    }
}

#Preview {
    SetPlayersView()
        .environmentObject(HomeViewModel())
        .environmentObject(PlayersViewModel())
}

extension SetPlayersView {
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
            VStack {
                ForEach(playersVM.players) { player in
                    SetPlayersRowView(player: player)
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 24)
    }
    
    private var noPlayersInfo: some View {
        VStack {
            Spacer()
            Text("No players set to play")
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
    
    private var addPlayerModalContent: some View {
        VStack {
            RegularTextFieldView(title: "Name:", text: $newPlayerName)
            Divider()
            emojiPicker
            Spacer()
            Button(action: {
                guard !newPlayerName.isEmpty, let selectedThemeIndex = selectedThemeIndex else { return }
                playersVM.addPlayer(name: newPlayerName, theme: PlayerTheme.allCases[selectedThemeIndex])
                newPlayerName = ""
                self.selectedThemeIndex = nil
                showAddPlayerModel = false
            }, label: {
                WideButtonView("Add", disabled: newPlayerName.isEmpty, colorScheme: .primary)
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
