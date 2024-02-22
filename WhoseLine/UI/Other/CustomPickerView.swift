//
//  CustomPickerView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 22/02/2024.
//

import SwiftUI

struct CustomPickerView: View {
    var collection: [String]
    @Binding var selectedIndex: Int?
    var itemSize: CGFloat = 40
    var highlightSize: CGFloat = 48

    var body: some View {
        ZStack {
            if selectedIndex != nil {
                Rectangle()
                    .foregroundColor(.white.opacity(0.3))
                    .frame(width: highlightSize, height: highlightSize)
                    .cornerRadius(10)
                    .offset(x: highlightOffset)
            }
            HStack(spacing: 0) {
                ForEach(0..<collection.count, id: \.self) { index in
                    Text(collection[index])
                        .font(.system(size: selectedIndex == index ? 36 : 24))
                        .frame(minWidth: itemSize)
                        .onTapGesture {
                            withAnimation(.linear(duration: 0.2)) {
                                selectedIndex = index
                            }
                        }
                }
            }
            .frame(height: 30)
            .padding()
        }
    }
}

#Preview("Emojis") {
    let allEmojis = PlayerTheme.allCases.map { theme in
        theme.emoji
    }
    return ZStack {
        Color.theme.background.ignoresSafeArea()
        CustomPickerView(collection: allEmojis, selectedIndex: .constant(1))
    }
}

#Preview("Numbers") {
    let collection = ["1", "2", "3"]
    return ZStack {
        Color.theme.background.ignoresSafeArea()
        CustomPickerView(collection: collection, selectedIndex: .constant(1))
    }
}

extension CustomPickerView {
    
    private var halfCollectionCount: Double {
        return Double(-collection.count + 1) / 2
    }
    private var itemOffset: CGFloat {
        return CGFloat((halfCollectionCount) * itemSize)
    }
    
    private var highlightOffset: CGFloat {
        if let index = selectedIndex {
            return itemOffset + CGFloat(index) * itemSize
        }
        return 0
    }
}
