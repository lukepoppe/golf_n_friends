//
//  LeagueDetailViewController.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 5/25/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import UIKit
import Parse

class LeagueDetailViewController:  UIViewController,

    UITableViewDelegate,
    UITableViewDataSource {
    
    enum Filter: Int {
        case Members = 0
        case Leaderboard
    }
    
    // MARK: Properties
    
    var league : League?
    var users = [[PFUser](), [PFUser]()]
    var data: [PFUser] { return users[filter.rawValue] }
    var filter: Filter {
        return Filter(rawValue: segmentedControl.selectedSegmentIndex)!
    }
    
    var fruits = ["Apple", "Orange", "Banana"]
    
    // MARK: Outlets
    
    @IBOutlet weak var myTable: UITableView! {
        didSet {
            myTable.delegate = self
            myTable.dataSource = self
        }
    }
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
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
        myTable.reloadData()
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch filter {
        case .Members, .Leaderboard:
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
            vc.league = self.league
        }
    }
    

}
