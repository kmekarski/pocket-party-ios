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
            if let currentPlayer = playersVM.currentPlayer {
                currentPlayer.theme.color.ignoresSafeArea()
                VStack {
                    header
                        .padding(.bottom)
                    HStack(spacing: 16) {
                        Text(currentPlayer.name)
                        Text(currentPlayer.theme.emoji)
                    }
                    .foregroundColor(currentPlayer.theme.textColor)
                    .font(.system(size: 36, weight: .semibold))
                    Spacer()
                    Button(action: {
                        playersVM.nextPlayer()
                    }, label: {
                        WideButtonView("Wrong!", size: .big, colorScheme: .primary)
                    })
                }
                .padding()
                .padding(.horizontal)
                GameInfoModalView(isShowing: $showInfo)
            }
        }
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(dev.homeVM)
            .environmentObject(dev.playersVMGame)
    }
}

extension GameView {
    private var header: some View {
        HStack {
            Button {
                homeVM.goToMainMenu()
            } label: {
                if let currentPlayer = playersVM.currentPlayer {
                    IconButtonView("xmark", color: currentPlayer.theme.textColor)
                }
            }
            Spacer()
            Button {
                showInfo.toggle()
            } label: {
                if let currentPlayer = playersVM.currentPlayer {
                    IconButtonView("info", color: currentPlayer.theme.textColor)
                }
            }
        }
    }
}
