//
//  ReportScoreTableViewController.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 5/25/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import UIKit
import Parse

let maximumNumberOfHoleScores = 18

class ReportScoreTableViewController: UITableViewController, UITextFieldDelegate {
<<<<<<< Updated upstream

    @IBAction func submitScoreBtnAction(sender: AnyObject) {
        var totalScore = 0
        for holeScore in self.holeScores {
            if let score = holeScore.score {
                totalScore += score
            }
        }
        self.score?.totalScore = totalScore
        self.score?.submitted = true
        self.score?.saveInBackground()
        
        print("submitScoreBtnAction fired")
        navigationController?.popViewControllerAnimated(true)
    }
=======
>>>>>>> Stashed changes
    
    var game : Game?
    var user : PFUser?
    
    var holeScores = [HoleScore]()
    var score : Score? {
        didSet {
            if let score = self.score {
                
                let query = score.holeScores?.query()
                query?.addAscendingOrder("order")
                query?.findObjectsInBackgroundWithBlock({ (objects, error) in
                    dispatch_async(dispatch_get_main_queue(), {
                        var needPrompt = false
                        
                        if let holeScores = objects as? [HoleScore] {
                            self.holeScores = holeScores
                            self.tableView.reloadData()
                            
                            if self.holeScores.count < 18 && self.shouldBeAbleToEditTheScore() {
                                self.addNewHoleScore()
                            }
                        } else {
                            // Prompt the user for first hole number
                            needPrompt = true
                        }
                        if objects?.count == 0 {
                            needPrompt = true
                        }
                        if needPrompt == true {
                            self.promptForFirstHoleNumber()
                        }
                    })
                })
            }
        }
    }
    
    func shouldBeAbleToEditTheScore() -> Bool {
        
        return self.score?.submitted == false && self.score!.member!.isMe() == true
    }
    
    
    var firstHoleNumber : Int! {
        didSet {
            let holeScore = HoleScore()
            holeScore.number = firstHoleNumber
            holeScore.order = 0
            self.holeScores.append(holeScore)
            self.tableView.reloadData()
        }
    }
    var firstHoleNumberTextField : UITextField!
    
    func promptForFirstHoleNumber() {
        let alert = UIAlertController(title: "First Hole", message: "Please put in your first hole number", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.keyboardType = .NumberPad
            self.firstHoleNumberTextField = textField
            
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) in
            
            guard let text = self.firstHoleNumberTextField.text, holeNumber = Int(text) else {
                self.cancelScoreInput(action)
                return
            }
            if holeNumber < 19 && holeNumber > 0 {
                // Valid Range
                self.firstHoleNumber = holeNumber
            } else {
                self.cancelScoreInput(action)
            }
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: self.cancelScoreInput))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func cancelScoreInput(action: UIAlertAction) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
<<<<<<< Updated upstream
        let query = PFQuery(className: Score.parseClassName())
        
        query.whereKey("member", equalTo: PFUser.currentUser()!)
        query.whereKey("league", equalTo: self.league!)
        query.whereKey("submitted", equalTo: false)
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if error != nil {
                return
            }
            
            if let score = objects?.last as? Score {
                self.score = score
            } else {
                let score = Score()
                score.member = PFUser.currentUser()
                score.league = self.league
                score.submitted = false
                do { try score.save() }catch{}
                self.score = score
=======
        if self.score == nil {
            let user = self.user ?? PFUser.currentUser()!
            NetworkService.sharedInstance.getScoreForGame(self.game!, user: user) { (optScore) in
                
                if let score = optScore {
                    self.score = score
                } else {
                    let score = Score()
                    score.member = user
                    do { try score.save() }catch{}
                    self.game?.scores?.addObject(score)
                    self.game?.saveInBackground()
                    self.score = score
                }
>>>>>>> Stashed changes
            }
        }
    }
    
    
    @IBAction func submitScoreAction(sender: AnyObject) {
        self.score?.submitted = true
        self.score?.saveInBackgroundWithBlock({ (success, error) in
            if success {
                self.navigationController?.popViewControllerAnimated(true)
            }
        })
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.holeScores.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("textFieldCell", forIndexPath: indexPath) as! HoleScoreTableViewCell

        // Configure the cell...
        let holeScore = self.holeScores[indexPath.row]
        cell.configureWithHoleScore(holeScore)
        
        if self.shouldBeAbleToEditTheScore() {
            cell.textField.userInteractionEnabled = false
        } else {
            if self.isLastHoleScore(holeScore) {
                cell.textField.becomeFirstResponder()
            }
        }

        return cell
    }
    
    func isLastHoleScore(holeScore: HoleScore) -> Bool {
        return holeScore.order! + 1 == self.holeScores.count
    }
    
  

    // MARK: - UITextFieldDelegate
    
    func addNewHoleScore() -> HoleScore? {
        guard let holeScore = self.holeScores.last, holeOrder = holeScore.order else {
            return nil
        }
        
        let addedHoleScore = HoleScore()
        addedHoleScore.order = holeOrder + 1
        
        if holeScore.number! == 18 {
            // The next one will be 1
            addedHoleScore.number = 1
        } else {
            addedHoleScore.number = holeScore.number! + 1
        }
        self.holeScores.append(addedHoleScore)
        
        
        self.tableView.beginUpdates()
        let indexPath = NSIndexPath(forRow: addedHoleScore.order!, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Top)
        self.tableView.endUpdates()
        
        return addedHoleScore
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        // Input validation
        guard let text = textField.text, score = Int(text) else {
            if let text = textField.text{
                if Int(text) == nil && text.characters.count > 0 {
                    let alert = UIAlertController(title: "Wrong score format", message: "Please type a number", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
            
            textField.text = ""
            return
        }
        let holeOrder = textField.tag
        
        let holeScore = self.holeScores[holeOrder]
        holeScore.score = score
        holeScore.saveInBackgroundWithBlock { (success, error) in
            self.score?.holeScores?.addObject(holeScore)
            self.score?.saveInBackground()
        }
        
        // If this is the last hole
        if self.isLastHoleScore(holeScore) && self.holeScores.count < 18  {
            
            addNewHoleScore()!
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
