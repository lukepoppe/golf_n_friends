//
//  LeagueDetailViewController.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 5/25/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import UIKit
import Parse

<<<<<<< Updated upstream
class LeagueDetailViewController:  UIViewController,

    UITableViewDelegate,
    UITableViewDataSource {
    
    enum Filter: Int {
        case Members = 0
        case Leaderboard
        case NewsFeed
        
    }
    
    // MARK: Properties
    
    var league : League?
    var users = [[PFUser](), [PFUser](), [PFUser]()]
    var data: [PFUser] { return users[filter.rawValue] }
    var filter: Filter {
        return Filter(rawValue: segmentedControl.selectedSegmentIndex)!
    }
    
=======
class LeagueDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, GameViewControllerDelegate {

    var games = [Game]()
    var league : League? {
        didSet {
            if let league = self.league {
                
                let query = league.games?.query()
                query?.addAscendingOrder("order")
                query?.findObjectsInBackgroundWithBlock({ (objects, error) in
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        if let games = objects as? [Game] {
                            self.games = games
                        }
                        self.tableView.reloadData()
                    })
                })
            }
        }
    }
    
    
>>>>>>> Stashed changes
    
    // MARK: Outlets
    
    @IBOutlet weak var myTable: UITableView! {
        didSet {
            myTable.delegate = self
            myTable.dataSource = self
        }
    }
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMembers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Requests
    
    func loadMembers() {
        let thisLeague = league?.members?.query()
        thisLeague?.findObjectsInBackgroundWithBlock({ (result: [PFObject]?, error: NSError?) -> Void in
            if error != nil {
                print("Error")
            } else if let foundUsers = result as? [PFUser]
            {
                self.users[0] = foundUsers
                self.myTable.reloadData()
                
                print(foundUsers)
            }
        })
    }
    
    // MARK: Actions
    
    @IBAction func segmentChanged(segmentedControl: UISegmentedControl) {
<<<<<<< Updated upstream
        myTable.reloadData()
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
=======
//        switch segmentedControl.selectedSegmentIndex {
//        case 0: // Games
//            
//        case 1: // Leaderboard
//            
//        case 2: // Members
//            
//        default:
//            <#code#>
//        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0: // Games
            return self.games.count + 1
        case 1: // Leaderboard
            return 0
        case 2: // Members
            return 0
        default:
            return 0
        }

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("gameCell", forIndexPath: indexPath)
        
        if indexPath.row == self.games.count {
            // Add new Game
            cell.textLabel?.text = "+ Add New Game"
        } else {
            let game = self.games[indexPath.row]
            cell.textLabel?.text = game.title
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == self.games.count {
            self.performSegueWithIdentifier("showGameVC", sender: indexPath)
        } else {
            self.performSegueWithIdentifier("showGameDetailVC", sender: indexPath)
        }
>>>>>>> Stashed changes
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch filter {
        case .Members, .Leaderboard, .NewsFeed:
            let cell = myTable.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath)
            cell.textLabel?.text = data[indexPath.row].username
            return cell
        }
        
        
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let vc = segue.destinationViewController as? ReportScoreTableViewController {
            if let indexPath = sender as? NSIndexPath {
                vc.game = self.games[indexPath.row]
            }
        }
        
        if let vc = segue.destinationViewController as? GameViewController {
            let game = Game()
            game.order = self.games.count
            game.league = self.league
            vc.game = game
            
            vc.delegate = self
        }
        
        if let vc = segue.destinationViewController as? GameDetailViewController {
            if let indexPath = sender as? NSIndexPath {
                vc.game = self.games[indexPath.row]
            }
        }
    }
    
    
    // MARK: - GameViewControllerDelegate
    
    func didCreateGame(game: Game) {
        // Save the game to the Parse
        game.saveInBackgroundWithBlock { (success, error) in
            if success {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 50), dispatch_get_main_queue()) {
                    self.league?.games?.addObject(game)
                    self.league?.saveInBackground()
                }
            }
        }
        
        self.games.append(game)
        
        self.tableView.beginUpdates()
        let indexPath = NSIndexPath(forRow: game.order!, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Top)
        self.tableView.endUpdates()
        
        
        self.navigationController?.popViewControllerAnimated(false)
        self.performSegueWithIdentifier("showReportScore", sender: indexPath)
    }

}
