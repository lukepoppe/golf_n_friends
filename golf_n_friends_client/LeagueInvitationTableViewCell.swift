//
//  LegueInvitationTableViewCell.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 5/13/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import UIKit
import Parse

protocol LeagueInvitationTableViewCellDelegate {
    func didConfirmInvitation(cell: UITableViewCell)
}

class LeagueInvitationTableViewCell: UITableViewCell {
    
    var delegate : LeagueInvitationTableViewCellDelegate?
    
    var leagueInvitation : LeagueInvitation?

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func declinePressed(sender: AnyObject) {
        // Delete the invitation
        if let league = self.leagueInvitation {
            league.deleteInBackground()
        }
        self.delegate?.didConfirmInvitation(self)
    }
    @IBAction func acceptPressed(sender: AnyObject) {
        // Add the user to the legue
        if let league = self.leagueInvitation?.league,
            let members = league.members,
            let currentUser = PFUser.currentUser(){
            members.addObject(currentUser)
            league.saveInBackground()
        }
        
        // Delete the invitation
        if let league = self.leagueInvitation {
            league.deleteInBackground()
        }
        
        self.delegate?.didConfirmInvitation(self)
    }
}
