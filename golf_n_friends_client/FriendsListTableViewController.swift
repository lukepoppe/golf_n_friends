//
//  FriendsListTableViewController.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 5/12/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import UIKit

class FriendsListTableViewController: UITableViewController {
        
    @IBOutlet weak var myTable: UITableView!
    
    
        var fruits = ["Apple", "Pineapple", "Orange", "Blackberry", "Banana", "Pear", "Kiwi", "Strawberry", "Mango", "Walnut", "Apricot", "Tomato", "Almond", "Date", "Melon", "Water Melon", "Lemon", "Coconut", "Fig", "Passionfruit", "Star Fruit", "Clementin", "Citron", "Cherry", "Cranberry"]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            print("FollowListViewController loaded")
            
            
            // Do any additional setup after loading the view.
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return fruits.count
            
        }
        
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
            let userCell = myTable.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath)
            // Fetch Fruit
            let fruit = fruits[indexPath.row]
            
            // Configure Cell
            userCell.textLabel?.text = fruit
            
            return userCell
        }
        
        override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
            
            print("Row Tapped: \(indexPath.row)")
            //        print(users[indexPath.row])
            
            
        }
        
        
}
