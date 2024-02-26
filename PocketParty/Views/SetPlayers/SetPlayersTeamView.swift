//
//  SetPlayersTeamView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 22/02/2024.
//

import SwiftUI

struct SetPlayersTeamView: View {
    @EnvironmentObject var playersVM: GameViewModel
    @Binding var selectedPlayerInTeamIndex: Int?
    var team: Team
    var teamIndex: Int
    var onPlusTap: () -> ()
    var onXTap: () -> ()
    var body: some View {
        VStack {
            HStack {
                Text("TEAM \(teamIndex + 1)")
                Spacer()
                Button(action: {
                    playersVM.deleteTeam(id: team.id)
                }, label: {
                    Image(systemName: "xmark")
                })
            }
            .foregroundColor(.theme.secondaryText)
            .font(.custom(size: 16, weight: .semibold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.vertical, 8)
            VStack(spacing: 12) {
                if let player1 = team.player1 {
                    SetPlayersPlayerView(onXTap: { playersVM.deletePlayerInTeam(id: player1.id)
                    }, player: player1)
                } else {
                    emptyPlayer(playerInTeamIndex: 0)
                }
                if let player2 = team.player2 {
                    SetPlayersPlayerView(onXTap: { playersVM.deletePlayerInTeam(id: player2.id)
                    }, player: player2)
                } else {
                    emptyPlayer(playerInTeamIndex: 1)
                }
            }
        }
    }
}

struct SetPlayersTeamView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            VStack(spacing: 20) {
                SetPlayersTeamView(selectedPlayerInTeamIndex: .constant(0), team: dev.fullTeam, teamIndex: 0) {} onXTap: {}
                SetPlayersTeamView(selectedPlayerInTeamIndex: .constant(0), team: dev.halfEmptyTeam, teamIndex: 0) {} onXTap: {}
                SetPlayersTeamView(selectedPlayerInTeamIndex: .constant(0), team: dev.emptyTeam, teamIndex: 0) {} onXTap: {}
            }
            .padding()
            .environmentObject(dev.playersVM)
        }
    }
}

extension SetPlayersTeamView {
    private func emptyPlayer(playerInTeamIndex: Int) -> some View {
        HStack {
            Image(systemName: "plus")
            Text("Add player")
        }
        .onTapGesture {
            onPlusTap()
            selectedPlayerInTeamIndex = playerInTeamIndex
        }
        .font(.custom(size: 20, weight: .semibold))
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, style: StrokeStyle(lineWidth: 5, dash: [12]))
        )
        .padding(.horizontal, 5)
    }
}
