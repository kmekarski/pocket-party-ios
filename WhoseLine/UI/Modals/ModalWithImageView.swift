//
//  ModalView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 16/02/2024.
//

import SwiftUI

struct ModalWithImageView<Content: View>: View {
    @Binding var isShowing: Bool
    var height: CGFloat
    var showX: Bool = true
    @ViewBuilder let content: Content
    var headerImage: Image?
    
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
                        if headerImage != nil {
                            logo
                        }
                        mainView
                    }
                }
                .frame(maxWidth: 330)
                .frame(height: isShowing ? height : 0)
            }
            .ignoresSafeArea()
        }
    }
}

struct ModalWithImageView_Previews: PreviewProvider {
    static var previews: some View {
        ModalWithImageView(isShowing: .constant(true), height: 400, content:  {
            VStack {
                Text("Scenes From a Hat")
                    .font(.system(size: 28, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("The rules are simple. Blahblahblah blhablhjhqskjdb asdjbasdkjasbf askjfbask jfbasfj")
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    WideButtonView("Button", colorScheme: .primary)
                })
            }
        }, headerImage: Image("MainLogo"))
    }
}

extension ModalWithImageView {
    private var mainView: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    isShowing.toggle()
                }, label: {
                    IconButtonView("xmark", size: .small)
                        .fontWeight(.semibold)
                        .opacity(showX ? 1 : 0)
                })
            }
            content
                .offset(y: 4)
            Spacer()
        }
        .frame(maxHeight: height)
        .padding(.top, 20)
        .padding(.bottom, 16)
        .padding(.horizontal, 28)
        .frame(maxWidth: .infinity)
        .background(Color.theme.background)
        .cornerRadius(20)
        .customShadow(.subtleDownShadow)
    }
    
    private var logo: some View {
        headerImage!
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
