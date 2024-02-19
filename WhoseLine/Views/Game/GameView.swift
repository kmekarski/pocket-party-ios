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
    var body: some View {
        ZStack {
            if playersVM.gameIsOn {
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
    
    private var currentPlayersIndices: [Int] {
        playersVM.currentPlayersIndices
    }
    
    private var playersQueue: [Player] {
        playersVM.playersQueue
    }
    
    
    private func playerCard(playerId: String, playerNumber: Int) -> some View {
        let player = players.first { el in
            el.id == playerId
        }!
        return ZStack {
            player.theme.color.ignoresSafeArea()
            VStack {
                VStack(spacing: 6) {
                    Text(player.name + " " + player.theme.emoji)
                        .foregroundColor(player.theme.textColor)
                        .font(.system(size: 28, weight: .semibold))
                    heartsDisplay(player: player)
                        .font(.system(size: 26, weight: .semibold))
                }
                Spacer()
                Button(action: {
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
            .frame(maxWidth: .infinity)
            .padding(.top, 150)
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
            .ignoresSafeArea()
        }
    }
    
    private var background: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            if let gameMode = playersVM.gameMode {
                switch gameMode {
                case .neverHaveIEver:
                    currentPlayers[0].theme.color.ignoresSafeArea()
                case .scenesFromAHat:
                    HStack(spacing: 0) {
                        ZStack {
                            ForEach(playersQueue.reversed()) { player in
                                playerCard(playerId: player.id, playerNumber: 0)
                            }
                            playerCard(playerId: currentPlayers[0].id, playerNumber: 0)
                                .rotationEffect(.degrees(folds[0] ? -90 : 0), anchor: UnitPoint(x: 0, y: 1.4))
                        }
                        ZStack {
                            ForEach(playersQueue.reversed()) { player in
                                playerCard(playerId: player.id, playerNumber: 1)
                            }
                            playerCard(playerId: currentPlayers[1].id, playerNumber: 1)
                                .rotationEffect(.degrees(folds[1] ? 90 : 0), anchor: UnitPoint(x: 0, y: 1.4))
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
    
    private func heartsDisplay(playerNumber: Int) -> some View {
        HStack(spacing: 0) {
            ForEach(0..<currentPlayers[playerNumber].lives, id: \.self) { _ in
                Image(systemName: "heart.fill")
                    .foregroundColor(.accentColor)
            }
        }
    }
    
    private func heartsDisplay(player: Player) -> some View {
        HStack(spacing: 0) {
            ForEach(0..<player.lives, id: \.self) { _ in
                Image(systemName: "heart.fill")
                    .foregroundColor(.accentColor)
            }
        }
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
                    VStack {}
                }
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
                    VStack {}
                }
            }
            
        }
    }
}
