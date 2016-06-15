//
//  ViewController.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 5/3/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import UIKit
//import Alamofire
import Parse



class ViewController: UIViewController {

    @IBOutlet weak var UsernameTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet var LoginInBtnAction: UIView!
    
    
    @IBOutlet weak var userName: UILabel!

    
    override func viewDidLoad() {
      
        super.viewDidLoad()
//        userName.font = UIFont(name:"didot", size: 20)
//        for family in UIFont.familyNames() {
//            print("\(family)")
//            
//            for name in UIFont.fontNamesForFamilyName(family) {
//                print("   \(name)")
//            }
//        }
        
    }
    
    
    
    
    @IBAction func LoginBtnAction(sender: AnyObject) {
        Login()
    }
    
    
    
    
    
    func Login(){
        var user = PFUser()
        user.username = UsernameTF.text
        user.password = PasswordTF.text
        user.email = EmailTF.text
        
        
        PFUser.logInWithUsernameInBackground( UsernameTF.text!, password: PasswordTF.text!, block: {
            
            (User : PFUser?, Error : NSError?) -> Void in
            
            if Error == nil{
                dispatch_async(dispatch_get_main_queue()){
                    self.performSegueWithIdentifier("showMainVC", sender: nil)
                    
                }
            }
            else {
                NSLog("Wrong!")
            }
        })

    }

    @IBAction func SignUpBtnAction(sender: AnyObject) {
        SignUp()
    }
    
   

    
    
    
    
    func SignUp(){
        var user = PFUser()
        user.username = UsernameTF.text
        user.password = PasswordTF.text
        user.email = EmailTF.text
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

