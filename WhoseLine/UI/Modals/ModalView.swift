//
//  ModalView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 16/02/2024.
//

import SwiftUI

struct ModalView<Content: View>: View {
    @Binding var isShowing: Bool
    var height: CGFloat
    @ViewBuilder let content: Content
    @ViewBuilder let headerImage: Image
    
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
                VStack {
                    if isShowing {
                        logo
                        mainView
                    }
                }
                .padding()
                .frame(height: isShowing ? height : 0)
            }
            .ignoresSafeArea()
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(isShowing: .constant(true), height: 350) {
            VStack(spacing: 16) {
                Text("Scenes From a Hat")
                    .font(.system(size: 28, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("The rules are simple. Blahblahblah blhablhjhqskjdb asdjbasdkjasbf askjfbask jfbasfj")
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        } headerImage: {
            Image("MainLogo")
        }
    }
}

extension ModalView {
    private var mainView: some View {
        VStack {
            content
                .offset(y: 32)
            Spacer()
        }
        .frame(maxHeight: height)
        .padding(.vertical, isShowing ? 20 : 0)
        .padding(.horizontal, 28)
        .frame(maxWidth: .infinity)
        .background(Color.theme.background)
        .cornerRadius(20)
    }
    
    private var logo: some View {
        headerImage
            .resizable()
            .scaledToFit()
            .foregroundColor(.theme.accent)
            .frame(height: 60)
            .padding(16)
            .background(Color.theme.background)
            .cornerRadius(100)
            .offset(y: 50)
            .zIndex(1)
    }
}
