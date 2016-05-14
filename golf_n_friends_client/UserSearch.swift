//
//  UserSearch.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 5/9/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import UIKit
import Parse

class UserSearch: UIViewController,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var myTable: UITableView!

    @IBOutlet weak var searchBar: UISearchBar!
    
    var users = [PFUser]()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        loadUsers()
        
        print(users)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return users.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let userCell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) 
        
        let userObject: PFUser = users[indexPath.row]
        
        userCell.textLabel!.text = userObject.objectForKey("username") as? String
        

        
        return userCell
        
    }
    
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        print("Row Tapped: \(indexPath.row)")
//        print(users[indexPath.row])
      
        
    }


    
    func loadUsers(){
        
        
        var userQuery = PFQuery(className: "_User")
        if let searchQuery = self.searchBar.text {
            let userQuery1 = PFQuery(className: "_User")
            userQuery1.whereKey("username", matchesRegex: "(?i)\(searchQuery)")
            let userQuery2 = PFQuery(className: "_User")
            userQuery2.whereKey("firstName", matchesRegex: "(?i)\(searchQuery)")
            let userQuery3 = PFQuery(className: "_User")
            userQuery3.whereKey("lastName", matchesRegex: "(?i)\(searchQuery)")
            
            userQuery = PFQuery.orQueryWithSubqueries([userQuery1, userQuery2, userQuery3])
        }
        
        
        userQuery.findObjectsInBackgroundWithBlock{(result:[PFObject]?,error:
            NSError?) -> Void in
            
            if let foundUsers = result as? [PFUser]
            {
                self.users = foundUsers
                self.myTable.reloadData()
            }
        }
    }
    
  
    // MARK: Actions
    
    @IBAction func followUserAction(sender: AnyObject) {

    
        
        let center = myTable.convertPoint(sender.center, fromView:sender.superview)
        let indexPath = myTable.indexPathForRowAtPoint(center)
        let follower = users[indexPath!.row]
        
        let user = PFUser.currentUser()
        let followings = user!.relationForKey("followings")
        followings.addObject(follower)
        
        user!.saveInBackgroundWithBlock { (succeeded: Bool, error: NSError?) in
                if succeeded {
                    print("add follower succeeded")
                } else {
                    print(error?.localizedDescription)
                }
        }
        
    }
    
    // MARK: UISearchBarDelegate
    
    var searchTimer = NSTimer()
    var searchOperationQueue = NSOperationQueue()
    
    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
//        let finalText = (searchBar.text as? NSString)?.stringByReplacingCharactersInRange(range, withString: text)
        
        self.searchTimer.invalidate()
        self.searchTimer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(UserSearch.searchTimerFired), userInfo: nil, repeats: false)
        
        return true
    }
    
    func searchTimerFired() {
        self.searchOperationQueue.cancelAllOperations()
        
        self.searchOperationQueue.addOperationWithBlock {
            self.loadUsers()
        }
    }

}