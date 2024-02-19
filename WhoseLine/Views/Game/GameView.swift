//
//  GameView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 13/02/2024.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    @EnvironmentObject var playersVM: PlayersViewModel
    @State var showInfo: Bool = false
    var body: some View {
        ZStack {
            if let gameMode = playersVM.gameMode,
               !currentPlayers.isEmpty {
                background
                VStack {
                    header
                        .padding(.bottom)
                    playersNames
                    Spacer()
                    question
                    Spacer()
                    bottomButtons
                }
                GameInfoModalView(isShowing: $showInfo, title: gameMode.title, description: gameMode.rulesDescription)
            }
        }
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(dev.homeVM)
            .environmentObject(dev.playersVMScenesFromAHat)
    }
}

extension GameView {
    private var currentPlayers: [Player] {
        playersVM.currentPlayers
    }
    
    private var background: some View {
        VStack {
            if let gameMode = playersVM.gameMode {
                switch gameMode {
                case .neverHaveIEver:
                    currentPlayers[0].theme.color.ignoresSafeArea()
                case .scenesFromAHat:
                    HStack(spacing: 0) {
                        currentPlayers[0].theme.color.ignoresSafeArea()
                        currentPlayers[1].theme.color.ignoresSafeArea()
                    }
                }
            }
        }
    }
    
    private var header: some View {
        HStack {
            Button {
                homeVM.goToMainMenu()
            } label: {
                IconButtonView("xmark", color: currentPlayers[0].theme.textColor)
            }
            Spacer()
            Button {
                showInfo.toggle()
            } label: {
                IconButtonView("info", color: currentPlayers[playersVM.gameMode == .neverHaveIEver ? 0 : 1].theme.textColor)
            }
        }
        .padding()
        .padding(.horizontal)
    }
    
    private var playersNames: some View {
        VStack {
            if let gameMode = playersVM.gameMode {
                switch gameMode {
                case .neverHaveIEver:
                    Text(currentPlayers[0].name + " " + currentPlayers[0].theme.emoji)
                        .foregroundColor(currentPlayers[0].theme.textColor)
                        .font(.system(size: 36, weight: .semibold))
                case .scenesFromAHat:
                    HStack(spacing: 32) {
                        Text(currentPlayers[0].name + " " + currentPlayers[0].theme.emoji)
                            .foregroundColor(currentPlayers[0].theme.textColor)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        Text(currentPlayers[1].name + " " + currentPlayers[1].theme.emoji)
                            .foregroundColor(currentPlayers[1].theme.textColor)
                            .frame(maxWidth: .infinity)
                        
                    }
                    .font(.system(size: 28, weight: .semibold))
                    .padding()
                }
            }
        }
    }
    
    private var question: some View {
        Text("Some question???")
            .frame(maxWidth: .infinity)
            .frame(height: 150)
            .background(Color.white)
            .cornerRadius(24)
            .subtleShadow()
            .offset(y: -32)
            .padding(.horizontal, 32)
    }
    
    private var bottomButtons: some View {
        VStack {
            if let gameMode = playersVM.gameMode {
                switch gameMode {
                case .neverHaveIEver:
                    Button(action: {
                        playersVM.nextPlayer(playerNumber: 0)
                    }, label: {
                        WideButtonView("Next question", size: .big, colorScheme: .primary)
                    })
                    .padding(.horizontal, 32)
                case .scenesFromAHat:
                    HStack(spacing: 48) {
                        ForEach(currentPlayers.indices, id: \.self) { index in
                            Button(action: {
                                playersVM.nextPlayer(playerNumber: index)
                            }, label: {
                                WideButtonView("\(currentPlayers[index].name) out!", size: .big, colorScheme: .primary)
                            })
                        }
                    }
                    .padding(.horizontal, 24)
                }
            }
            
        }
    }
}
