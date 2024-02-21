//
//  GameView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 13/02/2024.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var playersVM: PlayersViewModel
    @State var showInfo: Bool = false
    @State var folds: [Bool] = [false, false]
    @State var foldDirection: FoldDirection = .left
    @State var truthOrDarePickedState: TruthOrDarePickedState = .notPicked
    @State var showSkipAnswerButtons: Bool = false
    var body: some View {
        ZStack {
            if let gameMode = playersVM.gameMode,
               currentPlayers.count >= gameMode.playersOnScreen {
                background
                VStack {
                    header
                    Spacer()
                    question
                    Spacer()
                }
            }
            GameInfoModalView(isShowing: $showInfo, title: gameMode.title, description: gameMode.rulesDescription)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear() {
            print("game starts")
            playersVM.startGame()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(GameMode.allCases, id: \.self) { mode in
            GameView()
                .environmentObject(dev.playerVMs[mode]!)
                .previewDisplayName(mode.title)
        }
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
        switch foldDirection {
        case .left:
            foldDirection = .right
        case .right:
            foldDirection = .left
        }
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
        case .truthOrDare:
                return AnyView(
                    HStack(spacing: 16) {
                        if currentPlayers.contains(where: { currentPlayer in
                            currentPlayer.id == player.id
                        }) && showSkipAnswerButtons {
                            Button(action: {
                                truthOrDarePickedState = .notPicked
                                playersVM.nextQuestion()
                                setNewFoldDirection()
                                withAnimation(.easeIn(duration: 0.5)) {
                                    folds[0] = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    playersVM.nextPlayer(playerNumber: 0)
                                    folds[0] = false
                                    showSkipAnswerButtons = false
                                }
                            }, label: {
                                WideButtonView(truthOrDarePickedState == .truth ? "Answer" : "Complete", size: .big, colorScheme: .primary)
                            })
                            Button(action: {
                                truthOrDarePickedState = .notPicked
                                playersVM.nextQuestion()
                                setNewFoldDirection()
                                withAnimation(.easeIn(duration: 0.5)) {
                                    folds[0] = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    playersVM.decreasePlayerLives(playerNumber: 0)
                                    playersVM.nextPlayer(playerNumber: 0)
                                    folds[0] = false
                                    showSkipAnswerButtons = false

                                }
                            }, label: {
                                WideButtonView("Skip", size: .big, colorScheme: .primary)
                            })
                        }
                    })
            
        case .scenesFromAHat:
            return AnyView(
                Button(action: {
                    if playersQueue.isEmpty {
                        playersVM.nextPlayer(playerNumber: playerNumber)
                        return
                    }
                    withAnimation(.easeIn(duration: 0.5)) {
                        folds[playerNumber] = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        playersVM.decreasePlayerLives(playerNumber: playerNumber)
                        playersVM.nextPlayer(playerNumber: playerNumber)
                        folds[playerNumber] = false
                    }
                }, label: {
                    WideButtonView("\(player.name) out!", size: .big, colorScheme: .primary)
                })
            )
        case .neverHaveIEver:
            return AnyView(VStack{})
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
                case .truthOrDare:
                    ZStack {
                        ForEach(playersQueue.reversed()) { player in
                            playerCard(playerId: player.id, playerNumber: 0)
                        }
                        playerCard(playerId: currentPlayers[0].id, playerNumber: 0)
                            .foldTransition(active: folds[0], direction: foldDirection)
                    }
                    
                case .scenesFromAHat:
                    HStack(spacing: 0) {
                        ZStack {
                            if currentPlayers.count >= 2 {
                                currentPlayers[1].theme.color.ignoresSafeArea()
                            }
                            ForEach(playersQueue.reversed()) { player in
                                playerCard(playerId: player.id, playerNumber: 0)
                            }
                            playerCard(playerId: currentPlayers[0].id, playerNumber: 0)
                                .foldTransition(active: folds[0], direction: .left)
                        }
                        ZStack {
                            if currentPlayers.count >= 1 {
                                currentPlayers[0].theme.color.ignoresSafeArea()
                            }
                            ForEach(playersQueue.reversed()) { player in
                                playerCard(playerId: player.id, playerNumber: 1)
                            }
                            playerCard(playerId: currentPlayers[1].id, playerNumber: 1)
                                .foldTransition(active: folds[1], direction: .right)
                        }
                    }
                case .neverHaveIEver:
                    Color.theme.background.ignoresSafeArea()
                }
            }
        }
    }
    
    private var header: some View {
        HStack {
            Button {
                playersVM.goToMainMenu()
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
    
    private func truthOrDatePickButton(result: TruthOrDarePickResult) -> some View {
        Button(action: {
            truthOrDarePickedState = TruthOrDarePickedState(rawValue: result.rawValue)!
            showSkipAnswerButtons = true
        }, label: {
            Text(result.rawValue)
                .font(.system(size: 24, weight: .bold))
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .customShadow(.subtleDownShadow)
        })
    }
    
    private var question: some View {
        ZStack {
            questionsStack
            switch(gameMode) {
            case .scenesFromAHat:
                AnyView(VStack{
                    Text(playersVM.currentQuestion)
                        .font(.system(size: 24,weight: .semibold))
                }
                    .gameQuestionCard(.top)
                )
            case .truthOrDare:
                    switch truthOrDarePickedState {
                    case .notPicked:
                        VStack {
                            Text("\(playersVM.currentQuestionIndex+1) / \(playersVM.truthOrDareQuestions.count)")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                            HStack(spacing: 10) {
                                truthOrDatePickButton(result: .truth)
                                Text("or")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, weight: .bold))
                                truthOrDatePickButton(result: .dare)
                            }
                            .frame(maxHeight: .infinity)
                        }
                        .gameQuestionCard(.flippedTop)

                    case .truth:
                        Text(playersVM.currentTruthOrDareQuestion.truth)
                            .font(.system(size: 24,weight: .semibold))
                            .gameQuestionCard(.top)
                    case .dare:
                        Text(playersVM.currentTruthOrDareQuestion.dare)
                            .font(.system(size: 24,weight: .semibold))
                            .gameQuestionCard(.top)
                    }
            case .neverHaveIEver:
                AnyView(
                    VStack{
                        Text("\(playersVM.currentQuestionIndex+1) / \(playersVM.questions.count)")
                            .font(.system(size: 16, weight: .bold))
                        Text(playersVM.currentQuestion)
                            .font(.system(size: 24,weight: .semibold))
                            .frame(maxHeight: .infinity)
                    }
                        .gameQuestionCard(.top)
                )
            }
        }
    }
    
    private var questionsStack: some View {
        switch(gameMode) {
        case .scenesFromAHat:
            return AnyView(ZStack{})
        case .neverHaveIEver:
            return AnyView(ZStack {
                ForEach(playersVM.currentQuestionIndex..<playersVM.questions.count, id: \.self) { index in
                    Rectangle()
                        .gameQuestionCard(.backgroundDark)
                        .rotationEffect(Angle(degrees: log2(Double(index)) + 2))
                        .offset(x: 1)
                }
            })
        case .truthOrDare:
            return AnyView(ZStack {
                ForEach(0..<playersVM.truthOrDareQuestions.count - playersVM.currentQuestionIndex, id: \.self) { index in
                    Rectangle()
                        .gameQuestionCard(.backgroundDark)
                        .rotationEffect(Angle(degrees: log2(Double(index)) + 2))
                        .offset(x: 1)
                }
            })
        }
    }
}
