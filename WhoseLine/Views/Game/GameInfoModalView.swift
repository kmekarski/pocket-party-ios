//
//  GameInfoModalView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 18/02/2024.
//

import SwiftUI

struct GameInfoModalView: View {
    @Binding var isShowing: Bool
    var body: some View {
        ModalView(isShowing: $isShowing, height: 400, showX: false) {
            VStack {
                Text("Scenes From a Hat")
                    .font(.system(size: 28, weight: .bold))
                Divider()
                Text("The rules are simple. Blahblahblah blhablhjhqskjdb asdjbasdkjasbf askjfbask jfbasfj")
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Button(action: {
                    isShowing.toggle()
                }, label: {
                    WideButtonView("OK")
                })
            }
        } headerImage: {
            Image("MainLogo")
        }
    }
}

#Preview {
    GameInfoModalView(isShowing: .constant(true))
}
