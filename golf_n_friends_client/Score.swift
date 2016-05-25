//
//  Score.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 5/25/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import UIKit
import Parse

class Score: PFObject, PFSubclassing {
    
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
    
    var member : PFUser? {
        set {
            if let value = newValue {
                self.setObject(value, forKey: "member")
            }
        }
        get {
            return self.objectForKey("member") as? PFUser
        }
    }
    
    var holeScores : PFRelation? {
        get {
            return self.relationForKey("holeScores")
        }
    }
    
    
    static func parseClassName() -> String {
        return "Score"
    }
}
