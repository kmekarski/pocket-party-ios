//
//  GameOverView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 19/02/2024.
//

import SwiftUI

struct GameOverView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    @EnvironmentObject var playersVM: PlayersViewModel
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            VStack {
                if let winner = playersVM.currentPlayers.first {
                    Text("Game is over!")
                    Text("Winner: " + winner.name)
                    Button(action: {
                        playersVM.resetPlayers()
                        homeVM.goToMainMenu()
                    }, label: {
                        Text("Main menu")
                    })
                }
            }
        }
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView()
            .environmentObject(dev.homeVM)
            .environmentObject(dev.playersVMScenesFromAHat)
    }
}
