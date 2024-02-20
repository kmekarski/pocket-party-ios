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
    @State var folds: [Bool] = [false, false]
    @State var foldDirection: Int = 1
    var body: some View {
        ZStack {
            if playersVM.gameIsOn {
                if let gameMode = playersVM.gameMode,
                   !currentPlayers.isEmpty {
                    background
                    VStack {
                        header
                        Spacer()
                        question
                        Spacer()
                    }
                    GameInfoModalView(isShowing: $showInfo, title: gameMode.title, description: gameMode.rulesDescription)
                }
            } else {
                GameOverView()
            }
        }
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(dev.homeVM)
            .environmentObject(dev.playersVMNeverHaveIEver)
        GameView()
            .environmentObject(dev.homeVM)
            .environmentObject(dev.playersVMScenesFromAHat)
    }
}

extension GameView {
    private var players: [Player] {
        playersVM.players
    }
    
    private var currentPlayers: [Player] {
        playersVM.currentPlayers
    }
    
    private var playersQueue: [Player] {
        playersVM.playersQueue
    }
    
    private var gameMode: GameMode {
        playersVM.gameMode ?? .neverHaveIEver
    }
    
    private func setNewFoldDirection() {
        foldDirection *= -1
    }
    
    private func playerTitle(player: Player) -> some View {
        VStack(spacing: 6) {
            Text(player.name + " " + player.theme.emoji)
                .foregroundColor(player.theme.textColor)
                .font(.system(size: 28, weight: .semibold))
            heartsDisplay(player: player)
                .font(.system(size: 26, weight: .semibold))
        }
    }
    
    private func bottomButtons(player: Player, playerNumber: Int) -> some View {
        switch(gameMode) {
        case .neverHaveIEver:
            return Button(action: {
                setNewFoldDirection()
                withAnimation(.easeIn(duration: 0.5)) {
                    folds[0] = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    playersVM.nextPlayer(playerNumber: 0)
                    folds[0] = false
                }
            }, label: {
                WideButtonView("Next question", size: .big, colorScheme: .primary)
            })
        case .scenesFromAHat:
            return Button(action: {
                if playersQueue.isEmpty {
                    playersVM.nextPlayer(playerNumber: playerNumber)
                    return
                }
                withAnimation(.easeIn(duration: 0.5)) {
                    folds[playerNumber] = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    playersVM.nextPlayer(playerNumber: playerNumber)
                    folds[playerNumber] = false
                }
            }, label: {
                WideButtonView("\(player.name) out!", size: .big, colorScheme: .primary)
            })
        }
    }
    
    private func playerCard(playerId: String, playerNumber: Int) -> some View {
        ZStack {
            if let player = players.first(where: { el in
                el.id == playerId
            }) {
                player.theme.color.ignoresSafeArea()
                VStack {
                    playerTitle(player: player)
                    Spacer()
                    bottomButtons(player: player, playerNumber: playerNumber)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 150)
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
                .ignoresSafeArea()
            }
        }
    }
    
    private var background: some View {
        ZStack {
            if let gameMode = playersVM.gameMode {
                switch gameMode {
                case .neverHaveIEver:
                    ZStack {
                        ForEach(playersQueue.reversed()) { player in
                            playerCard(playerId: player.id, playerNumber: 0)
                        }
                        playerCard(playerId: currentPlayers[0].id, playerNumber: 0)
                            .rotationEffect(.degrees(Double(folds[0] ? (foldDirection * 90) : 0)), anchor: UnitPoint(x: 0, y: 1.4))
                    }
                    
                case .scenesFromAHat:
                    HStack(spacing: 0) {
                        ForEach(0..<2, id: \.self) { index in
                            ZStack {
                                currentPlayers[1-index].theme.color.ignoresSafeArea()
                                ForEach(playersQueue.reversed()) { player in
                                    playerCard(playerId: player.id, playerNumber: index)
                                }
                                playerCard(playerId: currentPlayers[index].id, playerNumber: index)
                                    .rotationEffect(.degrees(Double(folds[index] ? (-90 + 180 * index) : 0)), anchor: UnitPoint(x: 0, y: 1.4))
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var header: some View {
        HStack {
            Button {
                homeVM.goToMainMenu()
                playersVM.resetPlayers()
            } label: {
                IconButtonView("xmark")
            }
            Spacer()
            Button {
                showInfo.toggle()
            } label: {
                IconButtonView("info")
            }
        }
        .padding()
        .padding(.horizontal)
    }
    
    private func heartsDisplay(player: Player) -> some View {
        HStack(spacing: 0) {
            ForEach(0..<player.lives, id: \.self) { _ in
                Image(systemName: "heart.fill")
                    .foregroundColor(.accentColor)
            }
        }
    }
    
    private var question: some View {
        VStack {
            if playersVM.gameMode == .neverHaveIEver {
                Text("\(playersVM.currentQuestionIndex+1) / \(playersVM.questions.count)")
            }
            Text("Some question???")
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .background(Color.white)
        .cornerRadius(24)
        .subtleShadow()
        .offset(y: -32)
        .padding(.horizontal, 32)
    }
}
