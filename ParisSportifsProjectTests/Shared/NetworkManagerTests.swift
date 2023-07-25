//
//  NetworkManagerTests.swift
//  ParisSportifsProjectTests
//
//  Created by Zakaria El Mouatassim on 25/07/2023.
//

import XCTest
@testable import ParisSportifsProject

final class NetworkManagerTests: XCTestCase {

    func testFetchAllLeagues() {
        let expectation = XCTestExpectation(description: "Fetch all leagues API")
        NetworkManager.shared.getAllLeagues(complitionHandler: { result, error in
            guard let leagues = result else {
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertEqual(leagues.leagues.count, 996)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchTeamsByLeague() {
        let expectation = XCTestExpectation(description: "Fetch Frensh ligue 1 teams API")
        NetworkManager.shared.getTeamsByLeague(strLeague: "French Ligue 1", complitionHandler: { result, error in
            guard let teams = result else {
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssertEqual(teams.teams.count, 18)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5.0)
     }
}
