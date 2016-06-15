//
//  GameDetailViewController.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 6/2/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import UIKit
import Parse

class GameDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var scores = [Score]()
    var game : Game? {
        didSet {
            if let game = self.game {
                
                let query = game.scores?.query()
                query?.addAscendingOrder("member.username")
                query?.findObjectsInBackgroundWithBlock({ (objects, error) in
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        if let scores = objects as? [Score] {
                            self.scores = scores
                        }
                        var includesMyScore = false
                        for score in self.scores {
                            try! score.member?.fetch()
                            if let user = score.member {
                                if user.isMe() {
                                    includesMyScore = true
                                    break
                                }
                            }
                        }
                        if includesMyScore == false {
                            
                            let score = Score()
                            score.member = PFUser.currentUser()
                            do { try score.save() }catch{}
                            self.game?.scores?.addObject(score)
                            self.game?.saveInBackground()
                            self.scores.append(score)
                        }
                        self.tableView.reloadData()
                    })
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.scores.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let score = self.scores[indexPath.row]
        cell.textLabel?.text = score.member?.username
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let vc = segue.destinationViewController as? ReportScoreTableViewController {
            if let cell = sender as? UITableViewCell,
                indexPath = self.tableView.indexPathForCell(cell) {
                let score = self.scores[indexPath.row]
                vc.user = score.member
                vc.game = self.game
            }
        }
        
    }
}
