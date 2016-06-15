//
//  PFUser+Me.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 6/2/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import Foundation
import Parse

extension PFUser {
    func isMe() -> Bool {
        return self.objectId == PFUser.currentUser()?.objectId
    }
}
