//
//  LegueInvitation.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 5/13/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import UIKit
import Parse

class LeagueInvitation: PFObject, PFSubclassing {
    
    var league : League?
    var leagueCreator : PFUser?
    var leagueInvitationRecipient : PFUser?

    static func parseClassName() -> String {
        return "LeagueInvitation"
    }
}
