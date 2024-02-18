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
    var showX: Bool = true
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
                .padding(.horizontal, 24)
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
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    WideButtonView("Button")
                })
            }
        } headerImage: {
            Image("MainLogo")
        }
    }
}

extension ModalView {
    private var mainView: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    isShowing.toggle()
                }, label: {
                    IconButtonView("xmark", size: .small)
                        .opacity(showX ? 1 : 0)
                })
            }
            content
                .offset(y: 16)
            Spacer()
        }
        .frame(maxHeight: height)
        .padding(.top, 20)
        .padding(.bottom, 28)
        .padding(.horizontal, 28)
        .frame(maxWidth: .infinity)
        .background(Color.theme.background)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 5)
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
