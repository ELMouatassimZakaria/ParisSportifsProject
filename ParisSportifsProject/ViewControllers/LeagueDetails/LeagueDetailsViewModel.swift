//
//  LeagueDetailsViewModel.swift
//  ParisSportifsProject
//
//  Created by Zakaria El Mouatassim on 24/07/2023.
//

import Foundation

protocol LeagueDetailsViewModelDelegate: AnyObject {
    func willMakeRequest()
    func didMakeSuccessfullRequest(result: Teams?)
    func didFinishRequestWithError(error: Error)
}

class LeagueDetailsViewModel {
    private weak var delegate: LeagueDetailsViewModelDelegate!
    private var leagueName: String = ""
    let netWorkManager: NetworkManager!

    init(delegate: LeagueDetailsViewModelDelegate? = nil, leagueName: String, netWorkManager: NetworkManager = NetworkManager.shared) {
        self.delegate = delegate
        self.leagueName = leagueName
        self.netWorkManager = netWorkManager
    }

    func getLeagueTeams() {
        delegate.willMakeRequest()
        netWorkManager.getTeamsByLeague(strLeague: leagueName,
                                        complitionHandler: { teams, error in
            DispatchQueue.main.async { [weak self] in
                if let error = error {
                    // If there is an error, call the delegate with the error.
                    self?.delegate.didFinishRequestWithError(error: error)
                } else {
                    // If is success, call the delegate with the success.
                    self?.delegate.didMakeSuccessfullRequest(result: teams)
                }
            }
        })
    }
}
