//
//  NotificationsTableViewController.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 5/13/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import UIKit
import Parse

class NotificationsTableViewController: UITableViewController, LeagueInvitationTableViewCellDelegate {
    
    var items = [LeagueInvitation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        guard let user = PFUser.currentUser() else {
            return
        }

        let query = PFQuery(className: LeagueInvitation.parseClassName())
        query.whereKey("leagueInvitationRecipient", equalTo: user)
        
         query.findObjectsInBackgroundWithBlock {(result:[PFObject]?,error:
            NSError?) -> Void in
            
            if let foundInvitations = result as? [LeagueInvitation]
            {
                for invite in foundInvitations {
                    try! invite.league?.fetchIfNeeded()
                }
                self.items = foundInvitations
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
                print("Loaded", foundInvitations)
                
            }
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LeagueInvitationTableViewCell", forIndexPath: indexPath) as! LeagueInvitationTableViewCell

        // Configure the cell...
        let invitation = self.items[indexPath.row]
        cell.leagueInvitation = invitation
        cell.delegate = self

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - LeagueInvitationTableViewCellDelegate
    
    func didConfirmInvitation(cell : UITableViewCell) {
        guard let indexPath = self.tableView.indexPathForCell(cell) else {
            return
        }
        
        self.items.removeAtIndex(indexPath.row)
        
        self.tableView.beginUpdates()
        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        self.tableView.endUpdates()
    }

}
