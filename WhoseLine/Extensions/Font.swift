//
//  Font.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 23/02/2024.
//

import Foundation
import SwiftUI

public enum CustomFontWeight {
    case regular
    case semibold
    case bold
}

extension Font {
    public static func custom(size: CGFloat = 16, weight: CustomFontWeight = .regular) -> Font {
        switch weight {
        case .regular:
            return Font.custom("ShantellSans-Regular", size: size)
        case .semibold:
            return Font.custom("ShantellSans-SemiBold", size: size)
        case .bold:
            return Font.custom("ShantellSans-Bold", size: size)
        }
    }
}
