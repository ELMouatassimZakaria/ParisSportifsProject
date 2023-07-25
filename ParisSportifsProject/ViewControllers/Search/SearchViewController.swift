//
//  SearchViewController.swift
//  ParisSportifsProject
//
//  Created by Zakaria El Mouatassim on 24/07/2023.
//

import UIKit

class SearchViewController: UIViewController {
    var searchController: UISearchController!
    var leaguesVC: LeaguesViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }

    private func setupSearchBar() {
        title = "Search League"
        leaguesVC = LeaguesViewController()
        leaguesVC.viewModel = LeaguesViewModel(delegate: leaguesVC)

        searchController = UISearchController(searchResultsController: leaguesVC)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false

        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension SearchViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        let vc =  searchController.searchResultsController as? LeaguesViewController
        vc?.title = text
        if text.count > 3 {
            vc?.filterLeagues(for: text)
        }
    }
}
