//
//  LeagueDetailsViewModelDelegateMock.swift
//  ParisSportifsProjectTests
//
//  Created by Zakaria El Mouatassim on 25/07/2023.
//

import Foundation
import XCTest
@testable import ParisSportifsProject

class LeagueDetailsViewModelDelegateMock: LeagueDetailsViewModelDelegate {
    var didStartRequestCalled = false
    var didReceiveErrorCalled = false
    var didReceiveSuccessCalled = false

    var teams: Teams?
    var error: Error?
    let expectation: XCTestExpectation

    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }

    func willMakeRequest() {
        didStartRequestCalled = true
    }

    func didMakeSuccessfullRequest(result: Teams?) {
        teams = result
        expectation.fulfill()
        didReceiveSuccessCalled = true
    }

    func didFinishRequestWithError(error: Error) {
        self.error = error
        expectation.fulfill()
        didReceiveErrorCalled = true
    }
}
