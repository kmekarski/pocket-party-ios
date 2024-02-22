//
//  SetPlayersTeamView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 22/02/2024.
//

import SwiftUI

struct SetPlayersTeamView: View {
    @EnvironmentObject var playersVM: PlayersViewModel
    var team: Team
    var teamIndex: Int
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
            .font(.system(size: 16, weight: .semibold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.vertical, 8)
            VStack(spacing: 12) {
                if let player1 = team.player1 {
                    SetPlayersPlayerView(player: player1)
                } else {
                    emptyPlayer
                }
                if let player2 = team.player2 {
                    SetPlayersPlayerView(player: player2)
                } else {
                    emptyPlayer
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
                SetPlayersTeamView(team: dev.fullTeam, teamIndex: 0)
                SetPlayersTeamView(team: dev.halfEmptyTeam, teamIndex: 1)
                SetPlayersTeamView(team: dev.emptyTeam, teamIndex: 2)
            }
            .padding()
            .environmentObject(dev.playersVM)
        }
    }
}

extension SetPlayersTeamView {
    private var emptyPlayer: some View {
        HStack {
            Image(systemName: "plus")
            Text("Add player")
        }
        .font(.system(size: 20, weight: .semibold))
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, style: StrokeStyle(lineWidth: 5, dash: [12]))
        )
        .padding(.horizontal, 5)
    }
}
