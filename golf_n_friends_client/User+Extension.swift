//
//  User+Extension.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 5/15/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import Foundation
import Parse

extension PFUser {
    var leagues : PFRelation? {
        get {
            return self.relationForKey("leagues")
        }
    }
}