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
                buttons
            }
        }, headerImage: Image("MainLogo"))
    }
}

#Preview {
    SettingsModalView(isShowing: .constant(true))
}

extension SettingsModalView {
    private var buttons: some View {
        HStack(spacing: 16) {
            Button(action: {
                isShowing = false
            }, label: {
                WideButtonView("Cancel", colorScheme: .secondary)
            })
            Button(action: {
                isShowing = false
            }, label: {
                WideButtonView("Save", colorScheme: .primary)
        })
        }
    }
}
