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
        ModalView(isShowing: $isShowing, title: title) {
            VStack {
                Text(description)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button(action: {
                    isShowing.toggle()
                }, label: {
                    WideButtonView("OK", colorScheme: .primary)
                })
                .padding(.top, 8)
            }
        }
    }
}

#Preview {
    GameInfoModalView(isShowing: .constant(true), title: "Never have I Ever", description: "The rules are simple. Blahblahblah blhablhjhqskjdb asdjbasdkjasbf askjfbask jfbasfj")
}
