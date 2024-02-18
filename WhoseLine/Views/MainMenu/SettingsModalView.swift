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
        ModalWithImageView(isShowing: $isShowing, height: 330, content: {
            VStack {
                Text("Settings")
                    .font(.system(size: 24, weight: .semibold))
                Divider()
                LanguagePickerView()
                Spacer()
                Button(action: {
                }, label: {
                    WideButtonView("Save")
                })
            }
        }, headerImage: Image("MainLogo"))
    }
}

#Preview {
    SettingsModalView(isShowing: .constant(true))
}
