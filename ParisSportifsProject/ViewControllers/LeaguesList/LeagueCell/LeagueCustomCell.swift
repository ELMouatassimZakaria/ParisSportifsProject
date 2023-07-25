//
//  LeagueCustomCell.swift
//  ParisSportifsProject
//
//  Created by Zakaria El Mouatassim on 24/07/2023.
//

import UIKit

class LeagueCustomCell: UITableViewCell {
    @IBOutlet weak var leagueName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(league: League) {
        leagueName.text = league.strLeague
        accessoryType = .disclosureIndicator
    }
}
