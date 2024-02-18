//
//  IconButtonView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 16/02/2024.
//

import SwiftUI

enum IconButtonSize: CGFloat {
    case big = 28
    case small = 16
}

struct IconButtonView: View {
    var icon: String
    var size: IconButtonSize = .big
    
    init(_ icon: String) {
        self.icon = icon
    }
    
    init(_ icon: String, size: IconButtonSize) {
        self.icon = icon
        self.size = size
    }
    var body: some View {
        Image(systemName: icon)
        .font(.system(size: size.rawValue))    }
}

struct IconButtonView_Previews: PreviewProvider {
    static var previews: some View {
        IconButtonView("gearshape")
    }
}
