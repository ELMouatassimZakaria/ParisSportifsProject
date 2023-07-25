//
//  LeaguesViewController.swift
//  ParisSportifsProject
//
//  Created by Zakaria El Mouatassim on 24/07/2023.
//

import UIKit

class LeaguesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private let leagueCellIdentifier = "leagueCell"
    private var allLeagues: [League] = []
    private var filteredLeagues: [League] = []
    var viewModel: LeaguesViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.getAllLeagues()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "\(LeagueCustomCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: leagueCellIdentifier)
    }

    func filterLeagues(for searchText: String) {
        filteredLeagues = allLeagues.filter { league in
            return league.strLeague.localizedCaseInsensitiveContains(searchText)
        }
        tableView.reloadData()
    }
}

extension LeaguesViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLeagues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: leagueCellIdentifier, for: indexPath) as! LeagueCustomCell
        let league = filteredLeagues[indexPath.row]
        cell.setupCell(league: league)
        return cell
    }

    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let teams = filteredLeagues[indexPath.row]
        let detailLeague = LeagueDetailsViewController()
        detailLeague.viewModel = LeagueDetailsViewModel(delegate: detailLeague,
                                                        leagueName: teams.strLeague)
        presentingViewController?.navigationController?.pushViewController(detailLeague, animated: true)
    }
}

extension LeaguesViewController: LeaguesViewModelDelegate {
    func willMakeRequest() {}

    func didMakeSuccessfullRequest(result: [League]) {
        allLeagues = result
    }

    func didFinishRequestWithError(error: Error) {}
}
