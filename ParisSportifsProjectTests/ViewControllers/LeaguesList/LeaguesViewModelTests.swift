//
//  LeaguesViewModelTests.swift
//  ParisSportifsProjectTests
//
//  Created by Zakaria El Mouatassim on 25/07/2023.
//

import XCTest
@testable import ParisSportifsProject

final class LeaguesViewModelTests: XCTestCase {

    var viewModel: LeaguesViewModel!
    var view: LeaguesViewModelDelegateMock!

    func testFetchAllLeagues_SuccessfulRequest() {
        let expectation = XCTestExpectation(description: "Successful request expectation")
        let view = LeaguesViewModelDelegateMock(expectation: expectation)
        viewModel = LeaguesViewModel(delegate: view)

        // Call getAllLeagues API
        viewModel.getAllLeagues()

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)

        // Perform assertions to verify the expected behavior
        XCTAssertTrue(view.didStartRequestCalled)
        XCTAssertTrue(view.didReceiveSuccessCalled)
        XCTAssertNil(view.error)
        XCTAssertGreaterThan(view.leagues!.count, 0)
    }

    func testFetchAllLeagues_FailedRequest() {
        let expectation = XCTestExpectation(description: "Failed request expectation")
        view = LeaguesViewModelDelegateMock(expectation: expectation)
        viewModel = LeaguesViewModel(delegate: view, networkManager: MockNetworkManager())

        // Call getAllLeagues API
        viewModel.getAllLeagues()

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)

        // Perform assertions to verify the expected behavior
        XCTAssertTrue(view.didStartRequestCalled)
        XCTAssertTrue(view.didReceiveErrorCalled)
        XCTAssertNotNil(view.error)
        XCTAssertNil(view.leagues)
    }
}
