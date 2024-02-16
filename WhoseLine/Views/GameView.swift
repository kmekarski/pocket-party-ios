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
            if homeVM.appState == .game {
                ZStack {
                    Color.theme.background.ignoresSafeArea()
                    VStack {
                        header
                        Spacer()
                    }
                    .padding()
                    .padding(.horizontal)
                    ModalView(isShowing: $showInfo, height: 350) {
                        infoModalContent
                    } headerImage: {
                        Image("MainLogo")
                    }
                }
                .transition(.move(edge: .bottom))
            }
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
    
    private var infoModalContent: some View {
        VStack(spacing: 16) {
            Text("Scenes From a Hat")
                .font(.system(size: 28, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .center)
            Text("The rules are simple. Blahblahblah blhablhjhqskjdb asdjbasdkjasbf askjfbask jfbasfj")
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
