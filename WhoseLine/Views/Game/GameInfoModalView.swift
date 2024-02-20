//
//  GameInfoModalView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 18/02/2024.
//

import SwiftUI

struct GameInfoModalView: View {
    @Binding var isShowing: Bool
    var title: String
    var description: String
    var body: some View {
        ModalWithImageView(isShowing: $isShowing, height: 400, showX: false, content:  {
            VStack {
                Text(title)
                    .font(.system(size: 24, weight: .semibold))
                Divider()
                Text(description)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Button(action: {
                    isShowing.toggle()
                }, label: {
                    WideButtonView("OK", colorScheme: .primary)
                })
            }
        }, headerImage: Image("MainLogo"))
    }
}

#Preview {
    GameInfoModalView(isShowing: .constant(true), title: "Never have I Ever", description: "The rules are simple. Blahblahblah blhablhjhqskjdb asdjbasdkjasbf askjfbask jfbasfj")
}
