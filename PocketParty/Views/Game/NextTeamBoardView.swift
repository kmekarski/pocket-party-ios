//
//  NextTeamBoardView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 23/02/2024.
//

import SwiftUI

struct NextTeamBoardView: View {
    @EnvironmentObject var playersVM: GameViewModel
    var body: some View {
        ZStack {
            if playersVM.gameMode == .taboo && playersVM.isShowingNextTeamBoard {
                Color.theme.colorfulBackground.ignoresSafeArea()
                SpinningSpotlightView(speed: 10)
                VStack {
                    Text("Round \(playersVM.currentRoundIndex)/\(playersVM.settings.numberOfRounds)")
                        .padding(.top)
                    if let currentTeam = playersVM.currentTeam {
                        Spacer()
                        Text("Now playing:")
                            .font(.custom(size: 20, weight: .semibold))
                            .padding(.bottom)
                        VStack(spacing: 24) {
                            VStack(spacing: 8) {
                                Text(currentTeam.player1!.name + " " + currentTeam.player1!.theme.emoji)
                                    .font(.custom(size: 28, weight: .semibold))
                                Text("Speaker")
                                    .font(.custom(size: 20, weight: .regular))
                            }
                            VStack(spacing: 8) {
                                Text(currentTeam.player2!.name + " " + currentTeam.player2!.theme.emoji)
                                    .font(.custom(size: 28, weight: .semibold))
                                Text("Guesser")
                                    .font(.custom(size: 20, weight: .regular))
                            }
                        }
                        .padding()
                        .frame(width: 280)
                        .background(Material.regular)
                        .cornerRadius(12)
                        .customShadow(.subtleDownShadow)
                    }
                    Spacer()
                    Button(action: {
                        playersVM.nextTabooRound()
                    }, label: {
                        WideButtonView("Start", size: .big, colorScheme: .primary)
                    })
                }
                .font(.custom(size: 28, weight: .semibold))
                .foregroundColor(.theme.primaryText)
                .padding()
            }
        }
    }
}

struct NextTeamBoardView_Previews: PreviewProvider {
    static var previews: some View {
        NextTeamBoardView()
            .environmentObject(dev.playerVMs[.taboo]!)
    }
}
