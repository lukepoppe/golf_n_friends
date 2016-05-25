//
//  HoleScoreTableViewCell.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 5/25/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import UIKit

class HoleScoreTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWithHoleScore(holeScore: HoleScore) {
        if let score = holeScore.score {
            self.textField.text = "\(score)"
        } else {
            self.textField.text = ""
        }
        self.descriptionLabel.text = "Hole #\(holeScore.number!)"
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 50), dispatch_get_main_queue()) {
            self.textField.tag = holeScore.order!
        }
    }

}
