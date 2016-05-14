//
//  UserInviteTableViewCell.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 5/13/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import UIKit

class UserInviteTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            self.backgroundColor = UIColor.lightGrayColor()
        } else {
            self.backgroundColor = UIColor.whiteColor()
        }
    }

}
