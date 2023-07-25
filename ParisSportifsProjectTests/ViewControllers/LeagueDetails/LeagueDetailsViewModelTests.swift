//
//  LeagueDetailsViewModelTests.swift
//  ParisSportifsProjectTests
//
//  Created by Zakaria El Mouatassim on 25/07/2023.
//

import XCTest
@testable import ParisSportifsProject

final class LeagueDetailsViewModelTests: XCTestCase {

    var viewModel: LeagueDetailsViewModel!
    var view: LeagueDetailsViewModelDelegateMock!

    func testFetchLeagueTeams_SuccessfulRequest() {
        let expectation = XCTestExpectation(description: "Successful request expectation")
        let view = LeagueDetailsViewModelDelegateMock(expectation: expectation)
        viewModel = LeagueDetailsViewModel(delegate: view,
                                           leagueName: "French Ligue 1")

        // Call getLeagueTeams API
        viewModel.getLeagueTeams()

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)

        // Perform assertions to verify the expected behavior
        XCTAssertTrue(view.didStartRequestCalled)
        XCTAssertTrue(view.didReceiveSuccessCalled)
        XCTAssertNil(view.error)
        XCTAssertGreaterThan(view.teams!.teams.count, 0)
    }

    func testFetchLeagueTeams_FailedRequest() {
        let expectation = XCTestExpectation(description: "Failed request expectation")
        let view = LeagueDetailsViewModelDelegateMock(expectation: expectation)
        viewModel = LeagueDetailsViewModel(delegate: view,
                                           leagueName: "French Ligue 1",
                                           netWorkManager: MockNetworkManager())

        // Call getLeagueTeams API
        viewModel.getLeagueTeams()

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)

        // Perform assertions to verify the expected behavior
        XCTAssertTrue(view.didStartRequestCalled)
        XCTAssertTrue(view.didReceiveErrorCalled)
        XCTAssertNotNil(view.error)
        XCTAssertNil(view.teams)
    }
}
