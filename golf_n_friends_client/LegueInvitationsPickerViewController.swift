//
//  LegueInvitationsPickerViewController.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 5/13/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import UIKit
import Parse

protocol LegueInvitationsPickerVCDelegate {
    func didPickUsers(users : [PFUser])
}

class LegueInvitationsPickerViewController: UserSearch {
    
    var delegate : LegueInvitationsPickerVCDelegate?

    @IBAction func inviteSelectedPressed(sender: AnyObject) {
        var selectedUsers = [PFUser]()
        if let indexPathsForSelectedRows = self.myTable.indexPathsForSelectedRows {
            for indexPath in indexPathsForSelectedRows {
                selectedUsers.append(self.users[indexPath.row])
            }
        }
        delegate?.didPickUsers(selectedUsers)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDelegate
    
    

}
