//
//  TeamCollectionViewCell.swift
//  ParisSportifsProject
//
//  Created by Zakaria El Mouatassim on 24/07/2023.
//

import UIKit
import Kingfisher

class TeamCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(team: Team) {
        let imageUrl = URL(string: team.strTeamBadge)
        teamLogo.kf.setImage(with: imageUrl,
                                  placeholder: UIImage(named: "default_team.png"))
        teamName.text = team.strTeam
    }

}
