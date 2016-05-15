//
//  Legue.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 5/13/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import UIKit
import Parse

class League: PFObject, PFSubclassing {
    
    var leagueName : String? {
        set {
            if let value = newValue {
                self.setObject(value, forKey: "leagueName")
            }
        }
        get {
            return self.objectForKey("leagueName") as? String
        }
    }
    
    var members : PFRelation? {
        get {
            return self.relationForKey("members")
        }
    }

    static func parseClassName() -> String {
        return "League"
    }
}
