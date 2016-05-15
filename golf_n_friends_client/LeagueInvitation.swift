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
    
    
    var leagueCreator : PFUser? {
        set {
            if let value = newValue {
                self.setObject(value, forKey: "leagueCreator")
            }
        }
        get {
            return self.objectForKey("leagueCreator") as? PFUser
        }
    }
    
    
    var leagueInvitationRecipient : PFUser? {
        set {
            if let value = newValue {
                self.setObject(value, forKey: "leagueInvitationRecipient")
            }
        }
        get {
            return self.objectForKey("leagueInvitationRecipient") as? PFUser
        }
    }
    
    var league : League? {
        set {
            if let value = newValue {
                self.setObject(value, forKey: "league")
            }
        }
        get {
            return self.objectForKey("league") as? League
        }
    }
    
    
    
    static func parseClassName() -> String {
        return "LeagueInvitation"
    }
}
