//
//  Color.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 13/02/2024.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let colorfulBackground = Color("ColorfulBackgroundColor")
    let secondaryBackground = Color("SecondaryBackgroundColor")
    let primaryText = Color("PrimaryTextColor")
    let secondaryText = Color.secondary
    let logoRed = Color("LogoRedColor")
    let logoYellow = Color("LogoYellowColor")
    let logoBlue = Color("LogoBlueColor")
}
