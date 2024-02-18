//
//  LanguagePickerView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 18/02/2024.
//

import SwiftUI

struct LanguagePickerView: View {
    @State private var selectedLanguageIndex = 0
    
    let languages = [("🇺🇸", "English"), ("🇪🇸", "Spanish")]
    
    var body: some View {
        HStack {
            Text("App language:")
                .font(.system(size: 16, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            Picker(selection: $selectedLanguageIndex) {
                ForEach(0..<languages.count, id: \.self) { index in
                    Text(self.languages[index].0)
                }
            } label: {
                Text("")
            }
            .pickerStyle(.segmented)
            
        }
    }
}

#Preview {
    ModalView(isShowing: .constant(true), height: 350) {
        SettingsModalView()
    } headerImage: {
        Image(systemName: "gearshape.fill")
    }
}

extension LanguagePickerView {
    func languageLabel(language: String) -> some View {
        HStack {
            Text(language)
            Text("language")
        }
    }
}
