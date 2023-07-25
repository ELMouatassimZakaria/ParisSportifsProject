//
//  LeagueDetailsViewController.swift
//  ParisSportifsProject
//
//  Created by Zakaria El Mouatassim on 24/07/2023.
//

import UIKit
import Kingfisher

class LeagueDetailsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    private var teamsList: [Team] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    private let teamCellIdentifier = "teamCell"

    var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var viewModel: LeagueDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCollectionView()
        viewModel.getLeagueTeams()
    }

    private func setupCollectionView() {
        // Setting Delegete
        collectionView.delegate = self
        collectionView.dataSource = self

        //Setting 2 items in 1 row
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/2, height: 210)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout

        // Register Cell
        let nib = UINib(nibName: "\(TeamCollectionViewCell.self)", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: teamCellIdentifier)
    }

    private func displayErrorAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "Please try again !!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert , animated: true , completion: nil)
        }
    }
}

extension LeagueDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamsList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamCellIdentifier, for: indexPath) as! TeamCollectionViewCell
        cell.setupCell(team: teamsList[indexPath.row])
        return cell
    }
}

extension LeagueDetailsViewController: LeagueDetailsViewModelDelegate {
    func willMakeRequest() {
        spinner.startAnimating()
    }

    func didMakeSuccessfullRequest(result: Teams?) {
        // Sort the array in anti-alphabetical order
        let sortedTeams = result?.teams.sorted(by: { $0 > $1 }) ?? []
        let filteredTeams = sortedTeams.enumerated().compactMap { (index, team) -> Team? in
            // Show only 1 team out of 2
            return index % 2 == 0 ? team : nil
        }
        teamsList = filteredTeams

        DispatchQueue.main.async { [weak self] in
            self?.stopSpinner()
        }
    }

    func didFinishRequestWithError(error: Error) {
        displayErrorAlert()
    }

    private func stopSpinner() {
        spinner.stopAnimating()
    }
}
