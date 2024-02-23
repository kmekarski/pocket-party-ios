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
    @State var cardGoingOut: Bool = false
    @State var truthOrDarePickedState: TruthOrDarePickedState = .notPicked
    @State var showSkipAnswerButtons: Bool = false
    var body: some View {
        ZStack {
            if let gameMode = playersVM.gameMode {
                background
                VStack {
                    header
                    Spacer()
                    question
                    if gameMode.hasPoints {
                        pointsDisplay
                    }
                    
                    switch gameMode {
                    case .scenesFromAHat, .truthOrDare:
                        Spacer()
                    case .taboo:
                        tabooButtons
                    }
                }
            }
            GameInfoModalView(isShowing: $showInfo, title: gameMode.title, description: gameMode.rulesDescription)
            
            NextTeamBoardView()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear() {
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
    
    private var teams: [Team] {
        playersVM.teams
    }
    
    private var currentTeam: Team? {
        playersVM.currentTeam
    }
    
    private var playersQueue: [Player] {
        playersVM.playersQueue
    }
    
    private var gameMode: GameMode {
        playersVM.gameMode ?? .truthOrDare
    }
    
    private func setNewFoldDirection() {
        switch foldDirection {
        case .left:
            foldDirection = .right
        case .right:
            foldDirection = .left
        }
    }
    
    private func playerTitle(player: Player, playerNumber: Int) -> some View {
        VStack(spacing: 6) {
            switch gameMode {
            case .scenesFromAHat, .taboo:
                Text(player.name)
                    .foregroundColor(player.theme.textColor)
                    .font(.system(size: 24, weight: .semibold))
            case .truthOrDare:
                Text(player.name + " " + player.theme.emoji)
                    .foregroundColor(player.theme.textColor)
                    .font(.system(size: 28, weight: .semibold))
            }
            switch gameMode {
            case .scenesFromAHat, .truthOrDare:
                heartsDisplay(player: player)
                    .font(.system(size: 26, weight: .semibold))
            case .taboo:
                Text(playerNumber == 0 ? "Speaker" : "Guesser")
                    .foregroundColor(player.theme.textColor)
                    .font(.system(size: 20, weight: .regular))
            }
        }
        .offset(y: 30)
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
                            setNewFoldDirection()
                            playersVM.nextQuestion()
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
                }
                    .padding(.bottom)
            )
            
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
                .padding(.bottom)
            )
        case .taboo:
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
                    playerTitle(player: player, playerNumber: playerNumber)
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
    
    private func playerCard(player: Player, playerNumber: Int) -> some View {
        ZStack {
            player.theme.color.ignoresSafeArea()
            VStack {
                playerTitle(player: player, playerNumber: playerNumber)
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
    
    private var background: some View {
        ZStack {
            if let gameMode = playersVM.gameMode {
                switch gameMode {
                case .truthOrDare:
                    ZStack {
                        if currentPlayers.count > 0 {
                            ForEach(playersQueue.reversed()) { player in
                                playerCard(playerId: player.id, playerNumber: 0)
                            }
                            playerCard(playerId: currentPlayers[0].id, playerNumber: 0)
                                .foldTransition(active: folds[0], direction: foldDirection)
                        }
                    }
                    
                case .scenesFromAHat:
                    HStack(spacing: 0) {
                        ZStack {
                            if currentPlayers.count >= 2 {
                                currentPlayers[1].theme.color.ignoresSafeArea()
                                ForEach(playersQueue.reversed()) { player in
                                    playerCard(playerId: player.id, playerNumber: 0)
                                }
                                playerCard(playerId: currentPlayers[0].id, playerNumber: 0)
                                    .foldTransition(active: folds[0], direction: .left)
                            }
                        }
                        ZStack {
                            if currentPlayers.count >= 2 {
                                currentPlayers[0].theme.color.ignoresSafeArea()
                                ForEach(playersQueue.reversed()) { player in
                                    playerCard(playerId: player.id, playerNumber: 1)
                                }
                                playerCard(playerId: currentPlayers[1].id, playerNumber: 1)
                                    .foldTransition(active: folds[1], direction: .right)
                            }
                        }
                    }
                case .taboo:
                    HStack(spacing: 0) {
                        if let player1 = currentTeam?.player1,
                           let player2 = currentTeam?.player2 {
                            ZStack {
                                player1.theme.color.ignoresSafeArea()
                                playerCard(player: player1, playerNumber: 0)
                            }
                            ZStack {
                                player2.theme.color.ignoresSafeArea()
                                playerCard(player: player2, playerNumber: 1)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var header: some View {
        HStack(alignment: .top) {
            Button {
                playersVM.goToMainMenu()
            } label: {
                IconButtonView("xmark")
            }
            Spacer()
            if gameMode == .taboo {
                timer
            }
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
                        .foldTransition(active: folds[0], direction: foldDirection)
                case .dare:
                    Text(playersVM.currentTruthOrDareQuestion.dare)
                        .font(.system(size: 24,weight: .semibold))
                        .gameQuestionCard(.top)
                        .foldTransition(active: folds[0], direction: foldDirection)
                }
            case .taboo:
                AnyView(
                    ZStack {
                        let nextQuestionIndex = playersVM.currentQuestionIndex + 1
                        if nextQuestionIndex < playersVM.tabooQuestions.count {
                            let nextTabooQuestion = playersVM.tabooQuestions[nextQuestionIndex]
                            tabooCard(question: nextTabooQuestion)
                        }
                        tabooCard(question: playersVM.currentTabooQuestion)
                    }
                )
            }
        }
    }
    
    private func truthOrDareCard() -> some View {
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
    }
    
    private func tabooCard(question: TabooQuestion) -> some View {
        let isGoing = playersVM.currentTabooQuestion.wordToGuess == question.wordToGuess && cardGoingOut
        return VStack{
            Text(question.wordToGuess.uppercased())
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(Color.theme.accent)
                .cornerRadius(8)
            VStack(spacing: 12) {
                ForEach(question.forbiddenWords, id: \.self) { word in
                    Text(word.uppercased())
                        .font(.system(size: 20, weight: .regular))
                }
            }
            .frame(maxHeight: .infinity)
        }
        .padding(.top)
        .gameQuestionCard(.verticalTop)
        .offset(x: CGFloat(isGoing ? foldDirection.rawValue * 500 : 0), y: isGoing ? 10 : 0)
        .rotationEffect(.degrees(CGFloat(isGoing ? foldDirection.rawValue * 20 : 0)))
    }
    
    private var questionsStack: some View {
        switch(gameMode) {
        case .scenesFromAHat:
            return AnyView(ZStack{})
        case .truthOrDare:
            return AnyView(ZStack {
                ForEach(0..<playersVM.truthOrDareQuestions.count - playersVM.currentQuestionIndex, id: \.self) { index in
                    Rectangle()
                        .gameQuestionCard(.background)
                        .rotationEffect(Angle(degrees: log2(Double(index)) + 2))
                        .offset(x: 1)
                }
            })
        case .taboo:
            return AnyView(ZStack {
                ForEach(0..<playersVM.tabooQuestions.count - playersVM.currentQuestionIndex, id: \.self) { index in
                    Rectangle()
                        .gameQuestionCard(.verticalBackground)
                        .rotationEffect(Angle(degrees: log2(Double(index)) + 2))
                        .offset(y: 4)
                }
            })
        }
    }
    
    private var timer: some View {
        Text((playersVM.settings.timeOfRound - playersVM.timeElapsed).asClockString())
            .foregroundColor(.white)
            .font(.system(size: 22, weight: .semibold))
            .padding()
            .frame(width: 90)
            .background(Color.theme.accent)
            .cornerRadius(12)
            .frame(maxWidth: .infinity)
            .offset(x: -5)
            .customShadow(.subtleDownShadow)
    }
    
    private var pointsDisplay: some View {
        VStack {
            if let currentTeam = currentTeam {
                Text("Points: \(currentTeam.points)")
                    .foregroundColor(.white)
                    .font(.system(size: 22, weight: .semibold))
                    .padding()
                    .frame(width: 120)
                    .background(Color.theme.accent)
                    .cornerRadius(12)
                    .padding(40)
                    .customShadow(.subtleDownShadow)
            }
        }
    }
    
    private var tabooButtons: some View {
        HStack(spacing: 48) {
            Button(action: {
                foldDirection = .left
                swipeCard()
                if let currentTeam = currentTeam {
                    playersVM.givePointToTeam(teamId: currentTeam.id)
                }
            }, label: {
                WideButtonView("Correct", size: .big, colorScheme: .primary)
            })
            Button(action: {
                foldDirection = .right
                swipeCard()
            }, label: {
                WideButtonView("Skip", size: .big, colorScheme: .secondary)
            })
        }
        .padding(.horizontal, 24)
        .padding(.bottom)
    }
    
    private func swipeCard() {
        withAnimation(.easeIn) {
            cardGoingOut = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            cardGoingOut = false
            playersVM.nextQuestion()
        }
    }
}
