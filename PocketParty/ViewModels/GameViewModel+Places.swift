//
//  GameViewModel+Places.swift
//  PocketParty
//
//  Created by Klaudiusz Mękarski on 26/02/2024.
//

import Foundation

extension GameViewModel {
    func calculatePlayersPlaces() {
        var allPlayers: [Player] = []
        allPlayers.append(contentsOf: removedPlayers)
        allPlayers.append(contentsOf: players)
        allPlayers.sort { lhs, rhs in
            return lhs.lives > rhs.lives  // most lives first
        }
        var place = 0
        for (index, player) in allPlayers.enumerated() {
            if index == 0 || allPlayers[index - 1].lives > player.lives{
                place += 1
            }
            let playerWithPlace = PlayerWithPlace(player: player, place: place)
            playersWithPlaces.append(playerWithPlace)
        }
    }
    
    func calculateTeamsPlaces() {
        var allTeams: [Team] = []
        allTeams.append(contentsOf: teams)
        allTeams.sort { lhs, rhs in
            return lhs.points > rhs.points  // most points first
        }
        var place = 0
        for (index, team) in allTeams.enumerated() {
            if index == 0 || allTeams[index - 1].points > team.points{
                place += 1
            }
            let teamWithPlace = TeamWithPlace(team: team, place: place)
            teamsWithPlaces.append(teamWithPlace)
        }
    }
}
