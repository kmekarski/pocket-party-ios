//
//  TeamWithPlace.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 22/02/2024.
//

import Foundation

struct TeamWithPlace: Identifiable {
    var id: String
    var team: Team
    var place: Int
    
    init(team: Team, place: Int) {
        self.id = team.id
        self.team = team
        self.place = place
    }
}
