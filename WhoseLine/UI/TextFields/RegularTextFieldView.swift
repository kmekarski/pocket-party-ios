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
                    .foregroundColor(.theme.secondaryText))
                    .font(.system(size: 20))
                    .frame(height: 40)
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 16))
                    .foregroundColor(.theme.primaryText)
            }
        }
    }
}

struct RegularTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RegularTextFieldView(title: "Name:", text: .constant(""))
        }
        .padding()
    }
}
