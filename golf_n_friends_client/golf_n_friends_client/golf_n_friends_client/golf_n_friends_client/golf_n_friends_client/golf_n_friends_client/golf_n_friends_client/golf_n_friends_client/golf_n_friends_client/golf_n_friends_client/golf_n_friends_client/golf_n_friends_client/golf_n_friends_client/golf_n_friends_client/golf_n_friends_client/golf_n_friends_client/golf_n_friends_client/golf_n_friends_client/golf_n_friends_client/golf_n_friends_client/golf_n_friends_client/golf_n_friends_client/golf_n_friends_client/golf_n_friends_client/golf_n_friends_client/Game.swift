//
//  completedScores.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 6/2/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import Foundation
import Parse

class Game: PFObject, PFSubclassing {
    
    var order : Int? {
        set {
            if let value = newValue {
                self.setObject(value, forKey: "order")
            }
        }
        get {
            return self.objectForKey("order") as? Int
        }
    }
    
    var title : String? {
        set {
            if let value = newValue {
                self.setObject(value, forKey: "title")
            }
        }
        get {
            return self.objectForKey("title") as? String
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
    
    var scores : PFRelation? {
        get {
            return self.relationForKey("scores")
        }
    }
    
    
    static func parseClassName() -> String {
        return "Game"
    }
}