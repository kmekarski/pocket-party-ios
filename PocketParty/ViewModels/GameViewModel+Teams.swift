//
//  GameViewModel+Teams.swift
//  PocketParty
//
//  Created by Klaudiusz Mękarski on 26/02/2024.
//

import Foundation

extension GameViewModel {
    func addTeam() {
        tempTeams.append(Team(id: UUID().uuidString))
    }
    
    func deleteTeam(id: String) {
        tempTeams.removeAll { team in
            team.id == id
        }
    }
    
    func addPlayerInTeam(teamIndex: Int, playerInTeamIndex: Int, name: String, theme: PlayerTheme) {
        let newPlayer = Player(id: UUID().uuidString, name: name, theme: theme, lives: 3)
        if playerInTeamIndex == 0 {
            tempTeams[teamIndex].player1 = newPlayer
        }
        if playerInTeamIndex == 1 {
            tempTeams[teamIndex].player2 = newPlayer
        }
    }
    
    func deletePlayerInTeam(id: String) {
        for (index, team) in tempTeams.enumerated() {
            if team.player1?.id == id {
                tempTeams[index].player1 = nil
                break
            }
            if team.player2?.id == id {
                tempTeams[index].player2 = nil
                break
            }
        }
    }
    
    func nextTeam() {
        if gameMode == .taboo {
            currentSubRoundIndex += 1
            if currentSubRoundIndex > tempTeams.count {
                currentRoundIndex += 1
                currentSubRoundIndex = 1
            }
            if currentRoundIndex > settings.numberOfRounds {
                endGame()
            }
        }
        
        if let firstInQueue = teamsQueue.first, gameIsOn {
            teamsQueue.append(currentTeam!)
            currentTeam = firstInQueue
            currentTeam!.swapPlayers()
            teamsQueue.remove(at: 0)
        }
    }
    
    func givePointToTeam(teamId: String) {
        if let index = teams.firstIndex(where: { team in
            teamId == team.id
        }), currentTeam != nil {
            teams[index].givePoints(1)
            currentTeam!.givePoints(1)
        }
    }
    
    func setUpTeams() {
        if tempTeams.count > 0 {
            teams = tempTeams
            teams.shuffle()
            currentTeam = teams.first!
            teamsQueue = Array(teams.suffix(from: 1))
            isShowingNextTeamBoard = true
        }
    }
    
    func resetTeams() {
        teams = []
        currentTeam = nil
        teamsWithPlaces = []
    }
}
