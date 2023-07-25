//
//  MockNetworkManager.swift
//  ParisSportifsProjectTests
//
//  Created by Zakaria El Mouatassim on 25/07/2023.
//

import Foundation

@testable import ParisSportifsProject

class MockNetworkManager: NetworkManager {
    override func getAllLeagues(complitionHandler completion: @escaping (Leagues?, Error?) -> Void) {
        let error = NSError(domain: "com.fetchAllLeagues.networkError", code: 123, userInfo: nil)
        completion(nil, error)
    }

    override func getTeamsByLeague(strLeague: String, complitionHandler: @escaping (Teams?, Error?) -> Void) {
        let error = NSError(domain: "com.fetchLeagueTeam.networkError", code: 123, userInfo: nil)
        complitionHandler(nil, error)
    }
}
