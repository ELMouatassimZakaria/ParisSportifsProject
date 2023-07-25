//
//  Teams.swift
//  ParisSportifsProject
//
//  Created by Zakaria El Mouatassim on 24/07/2023.
//

import Foundation

struct Teams: Codable {
    let teams: [Team]
}

struct Team: Codable, Comparable {
    let idTeam, strTeam, strTeamBadge: String

    static func < (lhs: Team, rhs: Team) -> Bool {
        return lhs.idTeam > rhs.idTeam
    }
}
