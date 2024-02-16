//
//  IconButtonView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 16/02/2024.
//

import SwiftUI

struct IconButtonView: View {
    var icon: String
    init(_ icon: String) {
        self.icon = icon
    }
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 28))    }
}

struct IconButtonView_Previews: PreviewProvider {
    static var previews: some View {
        IconButtonView("gearshape")
    }
}
