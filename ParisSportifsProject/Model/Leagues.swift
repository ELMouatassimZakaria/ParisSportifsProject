//
//  Leagues.swift
//  ParisSportifsProject
//
//  Created by Zakaria El Mouatassim on 24/07/2023.
//

import Foundation

struct Leagues: Codable {
    let leagues: [League]
}

struct League: Codable {
    let idLeague, strLeague, strSport: String
    let strLeagueAlternate: String?
}
