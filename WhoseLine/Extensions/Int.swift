//
//  Int.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 22/02/2024.
//

import Foundation

extension Int {
    func asClockString() -> String {
        return "\(self/60):\(self % 60 >= 10 ? "" : "0")\(self % 60)"
    }
    
    func asPointsString() -> String {
        return "\(self)" + " " + "\(self == 1 ? "point" : "points")"
    }
}
