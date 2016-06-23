//
//  LogInViewController.swift
//  Roadtrip
//
//  Created by Robert Krakauer on 6/8/15.
//  Copyright (c) 2015 David Krakauer. All rights reserved.
//

import UIKit
import AudioToolbox
import Parse

class LogInViewController: UIViewController {
    
    //AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var alertLabel: UILabel!
    
    @IBAction func loginButtonPress(sender: AnyObject) {
        print("Logging in user...")
        if (emailField.text != "" && passField.text != "") {
            print("Fields are filled")
            print("Begining login")
        PFUser.logInWithUsernameInBackground(emailField.text!,password:passField.text!) {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    // Yes, User Exists
                    print("Checking if user is an admin")
                    let user = PFUser.currentUser()
                    if user?["emailVerified"] as? Bool == true {
                        if let isAdmin = PFUser.currentUser()?.objectForKey("adminPower") as? Int {
                            if isAdmin == 1 {
                                print("User is an admin")
                                print("Logging in as admin")
                                self.performSegueWithIdentifier("toAdminPage", sender: self)
                                print("Finished logging in")
                            }else{
                                print("User is not an admin")
                                print("Logging in as non-admin")
                                self.performSegueWithIdentifier("toHomePage", sender: self)
                                print("Finished logging in")
                            }
                        }
                    }else{
                        self.alertLabel.text = "Please verify your email before logging in!"
                        PFUser.logOut()
                    }
                    
                    
                } else {
                    print("No User with that username and password")
                    // No, User Doesn't Exist
                    self.alertLabel.text = "Either the username or password is incorrect!"
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                }
            }
        }else{
            //Either of the fields is empty, notify user
            alertLabel.text = "Please fill in all fields!"
        }
    }

    @IBAction func exitToLoginViewController(segue:UIStoryboardSegue) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
