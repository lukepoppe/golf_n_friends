//
//  LeagueTableViewCell.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 5/15/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    var league : League? {
        didSet {
            if let league = self.league {
                self.titleLabel.text = league.leagueName
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
