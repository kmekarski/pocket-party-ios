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
    var height: CGFloat
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
                VStack {
                    if isShowing {
                        mainView
                    }
                }
                .padding(.horizontal)
                .frame(height: isShowing ? height : 0)
            }
            .ignoresSafeArea()
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ModalWithImageView(isShowing: .constant(true), height: 400, headerImage: Image("MainLogo")) {
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
            }
            ModalView(isShowing: .constant(true), title: "Title", height: 220) {
                VStack {
                    Text("The rules are simple. Blahblahblah blhablhjhqskjdb asdjbasdkjasbf askjfbask jfbasfj")
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        WideButtonView("Button", colorScheme: .primary)
                    })
                }
            }
        }
        
    }
}

extension ModalView {
    private var mainView: some View {
        VStack {
            HStack {
                IconButtonView("xmark", size: .small)
                    .fontWeight(.semibold)
                    .opacity(0)
                Spacer()
                Text(title)
                    .font(.system(size: 24, weight: .semibold))
                Spacer()
                Button(action: {
                    isShowing.toggle()
                }, label: {
                    IconButtonView("xmark", size: .small)
                        .fontWeight(.semibold)
                        .opacity(showX ? 1 : 0)
                })
            }
            .padding(.bottom, 8)
            content
        }
        .frame(maxHeight: height)
        .padding(.top, 20)
        .padding(.bottom, 20)
        .padding(.horizontal, 28)
        .frame(maxWidth: .infinity)
        .background(Color.theme.background)
        .cornerRadius(20)
        .subtleShadow()
    }
}
