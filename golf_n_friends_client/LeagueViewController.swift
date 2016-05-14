//
//  LeagueViewController.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 5/13/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import UIKit
import Parse



class LeagueViewController: UITableViewController, LegueInvitationsPickerVCDelegate {
    @IBOutlet weak var leagueName: UITextField!
    @IBOutlet weak var invitedPeoplesNamesLabel: UILabel!
    
    var selectedUsers = [PFUser]()

    @IBAction func createLeagueAction(sender: AnyObject) {
        CreateLeague()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func CreateLeague(){
        let league = League()
        league.leagueName = leagueName.text

        
        league.saveInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
                self.sendInvitations(league)
            }
        }
        
    }
    
    func sendInvitations(league : League) {
        guard let currentUser = PFUser.currentUser() else {
            return
        }
        
        for user in self.selectedUsers {
            let invitation = LeagueInvitation()
            invitation.league = league
            invitation.leagueInvitationRecipient = user
            invitation.leagueCreator = currentUser
            invitation.saveInBackground()
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let vc = segue.destinationViewController as? LegueInvitationsPickerViewController {
            vc.delegate = self
        }
    }
    
    
    
    // MARK: - LegueInvitationsPickerVCDelegate
    
    
    func didPickUsers(users : [PFUser]) {
        self.selectedUsers = users
        let usersArray = NSMutableArray(array: users)
        let userNames = usersArray.mutableArrayValueForKeyPath("username")
        self.invitedPeoplesNamesLabel.text = userNames.componentsJoinedByString(", ")
        
        self.navigationController?.popToViewController(self, animated: true)
    }

}
