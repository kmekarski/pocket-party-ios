//
//  LanguagePickerView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 18/02/2024.
//

import SwiftUI

struct LanguagePickerView: View {
    @State private var selectedLanguageIndex = 0
    
    let languages = [("🇺🇸", "English"), ("🇪🇸", "Spanish"), ("🇫🇷", "French"), ("🇩🇪", "German"), ("🇨🇳", "Chinese"), ("🇯🇵", "Japanese")]

    var body: some View {
        HStack {
            Text("App language:")
                .font(.custom())
            Spacer()
            Picker(selection: $selectedLanguageIndex) {
                ForEach(0..<languages.count, id: \.self) { index in
                    languageLabel(index: index)
                }
            } label: {
                Text("")
            }
        }
    }
}

#Preview {
    SettingsModalView(isShowing: .constant(true))
}

extension LanguagePickerView {
    func languageLabel(index: Int) -> some View {
        Text("\(self.languages[index].0) \(self.languages[index].1)")
    }
}
