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
                    WideButtonView("Start Game", disabled: playersVM.players.isEmpty, size: .big)
                })
            }
            .padding()
            .padding(.horizontal)
            ModalView(isShowing: $showAddPlayerModel, title: "New player", height: 190, content: {
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
            Spacer()
            Button(action: {
                playersVM.addPlayer(newPlayerName)
                newPlayerName = ""
                showAddPlayerModel = false
            }, label: {
                WideButtonView("Add", disabled: newPlayerName.isEmpty)
            })
        }
    }
}
