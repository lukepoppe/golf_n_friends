//
//  UserSearch.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 5/9/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import UIKit
import Parse

class UserSearch: UIViewController,UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var myTable: UITableView!

    
    var users = [PFUser]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return users.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let userCell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) as! SearchUsersTableViewCell
        
        let userObject: PFUser = users[indexPath.row]
        
        userCell.textLabel!.text = userObject.objectForKey("username") as? String
        
        userCell.user = userObject
        
        return userCell
        
    }
    
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        print("Row Tapped: \(indexPath.row)")
//        print(users[indexPath.row])
      
        
    }


    
    func loadUsers(){
        
        
        let userQuery = PFQuery(className: "_User")
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
        print("hello")
        
        //        print(user)
        //        print(user!.objectId)
    
        
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

}