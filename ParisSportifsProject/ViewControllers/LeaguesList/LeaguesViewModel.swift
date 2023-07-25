//
//  LeaguesListViewModel.swift
//  ParisSportifsProject
//
//  Created by Zakaria El Mouatassim on 24/07/2023.
//

import Foundation

protocol LeaguesViewModelDelegate: AnyObject {
    func willMakeRequest()
    func didMakeSuccessfullRequest(result: [League])
    func didFinishRequestWithError(error: Error)
}

class LeaguesViewModel {
    private weak var delegate: LeaguesViewModelDelegate!
    let netWorkManager: NetworkManager!

    init(delegate: LeaguesViewModelDelegate? = nil, networkManager: NetworkManager = NetworkManager.shared) {
        self.delegate = delegate
        self.netWorkManager = networkManager
    }

    func getAllLeagues() {
        delegate.willMakeRequest()
        netWorkManager.getAllLeagues { result, error in
            DispatchQueue.main.async { [weak self] in
                if let error = error {
                    // If there is an error, call the delegate with the error.
                    self?.delegate.didFinishRequestWithError(error: error)
                } else {
                    // If is success, call the delegate with the success.
                    self?.delegate.didMakeSuccessfullRequest(result: result?.leagues ?? [])
                }
            }
        }
    }
}
