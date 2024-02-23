//
//  GameOverView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 19/02/2024.
//

import SwiftUI

struct GameOverView: View {
    @EnvironmentObject var playersVM: PlayersViewModel
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            SpinningSpotlightView(speed: 10)
                .offset(y: 60)
            VStack(spacing: 24) {
                header
                Spacer()
                if playersVM.playersWithPlaces.count >= 2 {
                    podium
                    playersList
                }
                buttonsSection
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView()
            .environmentObject(dev.playersVMAfterGame)
    }
}

extension GameOverView {
    private var header: some View {
        Text("Game over!")
            .viewTitle()
    }
    
    private func podiumRectangle(player: Player, place: Int) -> some View {
        var height: CGFloat {
            switch(place) {
            case 1: return 200
            case 2: return 150
            case 3: return 120
            default: return 50
            }
        }
        return VStack {
            Text(player.name + " " + player.theme.emoji)
                .font(.system(size: 20, weight: .semibold))
            ZStack(alignment: .top) {
                Rectangle()
                    .foregroundColor(player.theme.color)
                    .frame(maxWidth: 120)
                    .frame(height: height)
                    .cornerRadius(12)
                    .customShadow(.subtleBorderShadow)
                
                Text("\(place)")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(player.theme.textColor)
                    .padding()
            }
        }
    }
    
    private var podium: some View {
        let topPlayers = playersVM.playersWithPlaces
        return HStack(alignment: .bottom, spacing: 16) {
            ForEach(0..<min(3, topPlayers.count), id: \.self) { index in
                podiumRectangle(player: topPlayers[index].player, place: topPlayers[index].place)
            }
        }
    }
    
    private var playersList: some View {
        VStack(spacing: 6) {
            ForEach(playersVM.playersWithPlaces) { playerWithPlace in
                let player = playerWithPlace.player
                HStack(spacing: 24) {
                    Text("\(playerWithPlace.place).")
                        .font(.system(size: 20, weight: .semibold))
                        .frame(width: 24, alignment: .trailing)
                    Text(player.name + " " + player.theme.emoji)
                        .font(.system(size: 20, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing)
                    HStack(spacing: 0) {
                        ForEach(0..<playersVM.settings.numberOfLives, id: \.self) { index in
                            Image(systemName: "heart.fill")
                                .font(.system(size: 20))
                                .foregroundColor(player.lives > playersVM.settings.numberOfLives - 1 - index ? .theme.accent : .gray)
                        }
                    }
                    .frame(width: 50)
                }
                .padding(.trailing)
                .frame(maxWidth: 330)
            }
        }
        .padding()
        .background(Material.thick)
        .cornerRadius(12)
    }
    
    private var buttonsSection: some View {
        VStack(spacing: 16) {
            Button(action: {
                playersVM.goToMainMenu()
            }, label: {
                WideButtonView("Choose different mode", size: .big, colorScheme: .primary)
            })
            Button(action: {
                playersVM.startGame()
                playersVM.goBack()
            }, label: {
                WideButtonView("Play again", size: .big, colorScheme: .primary)
            })
            Button(action: {
                playersVM.goBack()
                playersVM.goBack()
            }, label: {
                WideButtonView("Edit players", size: .big, colorScheme: .primary)
            })
        }
    }
}
