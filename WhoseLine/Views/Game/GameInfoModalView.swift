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
        ModalWithImageView(isShowing: $isShowing, height: 400, showX: false, headerImage: Image("MainLogo")) {
            VStack {
                Text("Scenes From a Hat")
                    .font(.system(size: 24, weight: .semibold))
                Divider()
                Text("The rules are simple. Blahblahblah blhablhjhqskjdb asdjbasdkjasbf askjfbask jfbasfj")
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Button(action: {
                    isShowing.toggle()
                }, label: {
                    WideButtonView("OK", colorScheme: .primary)
                })
            }
        }
    }
}

#Preview {
    GameInfoModalView(isShowing: .constant(true))
}
