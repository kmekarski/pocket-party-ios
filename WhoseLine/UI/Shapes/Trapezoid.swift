//
//  Trapezoid.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 20/02/2024.
//

import Foundation
import SwiftUI

struct Trapezoid: Shape {
    var slope: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.width
        let height = rect.height

        path.move(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: width * (1 - slope), y: 0))
        path.addLine(to: CGPoint(x: width * slope, y: 0))
        path.closeSubpath()

        return path
    }
}
