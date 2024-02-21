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
            
            VStack {
                header
                Spacer()
                if playersVM.topPlayers.count >= 2 {
                    podium
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
            .environmentObject(dev.playersVMScenesFromAHat)
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
                    .shadow(color: .black.opacity(0.3), radius: 2)
                
                Text("\(place)")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(player.theme.textColor)
                    .padding()
            }
        }
    }
    
    private var podium: some View {
        let top3 = Array(playersVM.topPlayers.prefix(upTo: 3))
        return HStack(alignment: .bottom, spacing: 16) {
            if top3.count > 2 {
                podiumRectangle(player: top3[1], place: 2)
                podiumRectangle(player: top3[0], place: 1)
                podiumRectangle(player: top3[2], place: 3)
            }
            if top3.count == 2 {
                podiumRectangle(player: top3[0], place: 1)
                podiumRectangle(player: top3[1], place: 2)
            }
        }
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
        .padding(.top)
    }
}
