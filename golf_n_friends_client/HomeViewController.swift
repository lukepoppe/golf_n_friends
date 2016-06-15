//
//  HomeViewController.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 5/15/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UITableViewController {

    @IBOutlet weak var navBar: UINavigationItem!
    
    var items = [League]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadContent()
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.loadContent()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.items.count
    }
    
    
    
    func loadContent(){
        dispatch_async(dispatch_get_main_queue()) { 
            
        guard let user = PFUser.currentUser(),
            let leagues = user.leagues
            else {
            return
        }
            let query = leagues.query()
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if let fetchedLeagues = objects as? [League] {
                self.items = fetchedLeagues
                dispatch_async(dispatch_get_main_queue(), { 
                    self.tableView.reloadData()
                })
            }
            }
        }
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LeagueTableViewCell", forIndexPath: indexPath) as! LeagueTableViewCell

        // Configure the cell...
        cell.league = self.items[indexPath.row]

        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let vc = segue.destinationViewController as? LeagueDetailViewController,
            cell = sender as? UITableViewCell,
            indexPath = self.tableView.indexPathForCell(cell) {
            vc.league = self.items[indexPath.row]
        }
    }
    

}
