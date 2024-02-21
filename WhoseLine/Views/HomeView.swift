//
//  HomeView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 13/02/2024.
//

import SwiftUI

struct HomeView: View {    
    var body: some View {
        MainMenuView()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(dev.playersVM)
    }
}
