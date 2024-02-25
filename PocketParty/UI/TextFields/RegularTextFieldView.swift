//
//  RegularTextField.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 18/02/2024.
//

import SwiftUI

struct RegularTextFieldView: View {
    
    var title: String
    @Binding var text: String
    var invalid: Bool = false
    
    var body: some View {
        ZStack(alignment: .trailing) {
            VStack(spacing: 2) {
                TextField("", text: $text, prompt: Text(title)
                    .foregroundColor(.theme.secondaryText)
                    .font(.custom(size: 20, weight: .regular)))
                    .font(.custom(size: 20, weight: .regular))
                    .frame(height: 40)
                    .padding(EdgeInsets(top: 5, leading: 24, bottom: 5, trailing: 24))
                    .foregroundColor(.theme.primaryText)
                    .background(Color.theme.secondaryBackground)
                    .cornerRadius(10)
                    .customShadow(.subtlerDownShadow)
            }
        }
    }
}

struct RegularTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            VStack {
                RegularTextFieldView(title: "Name:", text: .constant(""))
            }
            .padding()
        }
    }
}
