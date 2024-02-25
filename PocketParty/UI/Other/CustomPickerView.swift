//
//  CustomPickerView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 22/02/2024.
//

import SwiftUI

struct CustomPickerView: View {
    var collection: [String]
    @Binding var selectedItem: String?
    @State var selectedIndex: Int?
    var itemSize: CGFloat = 40
    var highlightWidth: CGFloat = 40
    var highlightHeight: CGFloat = 48

    var body: some View {
        ZStack {
            if selectedIndex != nil {
                Rectangle()
                    .foregroundStyle(Material.thin)
                    .frame(width: highlightWidth, height: highlightHeight)
                    .cornerRadius(10)
                    .offset(x: highlightOffset)
                    .customShadow(.subtleMiddleShadow)
            }
            HStack(spacing: 0) {
                ForEach(0..<collection.count, id: \.self) { index in
                    Text(collection[index])
                        .font(.custom(size: 24))
                        .frame(minWidth: itemSize)
                        .onTapGesture {
                            withAnimation(.linear(duration: 0.2)) {
                                selectedIndex = index
                                selectedItem = collection[index]
                            }
                        }
                }
            }
            .frame(height: 30)
        }
        .onAppear() {
            selectedIndex = collection.firstIndex(where: { el in
                el == selectedItem
            })
        }
    }
}

#Preview("Emojis") {
    let allEmojis = PlayerTheme.allCases.map { theme in
        theme.emoji
    }
    return ZStack {
        Color.theme.background.ignoresSafeArea()
        CustomPickerView(collection: allEmojis, selectedItem: .constant(allEmojis[1]))
    }
}

#Preview("Numbers") {
    let collection = ["20", "30", "40"]
    return ZStack {
        Color.theme.background.ignoresSafeArea()
        CustomPickerView(collection: collection, selectedItem: .constant("1"))
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
