//
//  ModalView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 18/02/2024.
//

import SwiftUI

struct ModalView<Content: View>: View {
    @Binding var isShowing: Bool
    var title: String
    var showX: Bool = true
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack {
            ZStack {
                if isShowing {
                    Color.black
                        .frame(maxWidth: .infinity, alignment: .bottom)
                        .opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            isShowing = false
                        }
                }
                VStack(spacing: 0) {
                    if isShowing {
                        Text(title)
                            .font(.custom(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.theme.accent)
                            .cornerRadius(20, corners: [.topLeft, .topRight])
                        content
                            .padding(24)
                            .frame(maxWidth: .infinity)
                            .background(Color.theme.colorfulBackground)
                            .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                            .customShadow(.subtleDownShadow)
                    }
                }
                .frame(maxWidth: 330)
            }
            .ignoresSafeArea()
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(isShowing: .constant(true), title: "Title") {
            VStack(spacing: 24) {
                Text("The rules are simple. Blahblahblah blhablhjhqskjdb asdjbasdkjasbf askjfbask jfbasfj")
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom())

                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    WideButtonView("Button", colorScheme: .primary)
                })
            }
        }
    }
}

