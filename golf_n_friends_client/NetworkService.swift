//
//  NetworkService.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 6/2/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import UIKit
import Parse

class NetworkService: NSObject {

    static let sharedInstance = NetworkService()
    
    func getScoreForGame(game: Game, user: PFUser, completion: (score: Score?)->Void) {
        
        let query = PFQuery(className: Score.parseClassName())
        
        query.whereKey("member", equalTo: user)
        query.whereKey("game", equalTo: game)
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if error != nil {
                return
            }
            
            let score = objects?.last as? Score
            completion(score: score)
        }
    }
}
