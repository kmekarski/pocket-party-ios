//
//  GameView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 13/02/2024.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    @State var showInfo: Bool = false
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            VStack {
                header
                Spacer()
            }
            .padding()
            .padding(.horizontal)
            GameInfoModalView(isShowing: $showInfo)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(dev.homeVMGame)
    }
}

extension GameView {
    private var header: some View {
        HStack {
            Button {
                homeVM.endGame()
            } label: {
                IconButtonView("arrow.left")
            }
            Spacer()
            Button {
                showInfo.toggle()
            } label: {
                IconButtonView("info")
            }
        }
    }
}
