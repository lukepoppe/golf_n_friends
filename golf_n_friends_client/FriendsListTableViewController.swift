//
//  FriendsListTableViewController.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 5/12/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import UIKit
import Parse


class FriendsListTableViewController: UITableViewController {
        var users = [PFUser]()
    
    var currentUser = PFUser.currentUser()
        
    @IBOutlet weak var myTable: UITableView!
    

        
        override func viewDidLoad() {
            super.viewDidLoad()
            loadFollowing()

        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return users.count
            
        }
        
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
            let userCell = myTable.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath)

            let userObject: PFUser = users[indexPath.row]
            
            userCell.textLabel!.text = userObject.objectForKey("username") as? String
            
            return userCell
            }
        
        override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
            
            print("Row Tapped: \(indexPath.row)")
            //        print(users[indexPath.row])
            
            
        }
    
    func loadFollowing(){
    
        let user = PFUser.currentUser()
        let relation = user!.relationForKey("followings")
        relation.query().findObjectsInBackgroundWithBlock {
                    (result: [PFObject]?, error: NSError?) -> Void in
            if error != nil {
                print("Error")
            } else if let foundUsers = result as? [PFUser]
            {
                self.users = foundUsers
                self.myTable.reloadData()
                
            }
                    
        }
    }

    
    
}



