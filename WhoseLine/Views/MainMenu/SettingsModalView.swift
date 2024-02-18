//
//  SettingsModalView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 18/02/2024.
//

import SwiftUI

struct SettingsModalView: View {
    @Binding var isShowing: Bool
    var body: some View {
        ModalView(isShowing: $isShowing, height: 350, content: {
            VStack {
                Text("Settings")
                    .font(.system(size: 28, weight: .bold))
                Divider()
                LanguagePickerView()
                Spacer()
                Button(action: {
                }, label: {
                    WideButtonView("Save")
                })
            }        }, headerImage: { Image(systemName: "gearshape.fill") })
    }
}

#Preview {
    SettingsModalView(isShowing: .constant(true))
}
