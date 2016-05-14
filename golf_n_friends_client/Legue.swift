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
    
    var leagueName : String?
    var members : PFRelation?

    static func parseClassName() -> String {
        return "League"
    }
}
