//
//  SettingsModalView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 18/02/2024.
//

import SwiftUI

struct SettingsModalView: View {
    var body: some View {
        Text("Settings")
            .font(.system(size: 28, weight: .bold))
            .padding(.bottom)
        LanguagePickerView()
    }
}

#Preview {
    ModalView(isShowing: .constant(true), height: 350) {
        SettingsModalView()
    } headerImage: {
        Image(systemName: "gearshape.fill")
    }

}
