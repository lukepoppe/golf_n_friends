//
//  HoleScore.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 5/25/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import UIKit
import Parse

class HoleScore: PFObject, PFSubclassing {
    
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
    
    var number : Int? {
        set {
            if let value = newValue {
                self.setObject(value, forKey: "number")
            }
        }
        get {
            return self.objectForKey("number") as? Int
        }
    }
    
    var score : Int? {
        set {
            if let value = newValue {
                self.setObject(value, forKey: "score")
            }
        }
        get {
            return self.objectForKey("score") as? Int
        }
    }
    
    static func parseClassName() -> String {
        return "HoleScore"
    }
}
