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
            PFUser.logInWithUsernameInBackground(emailField.text!, password:passField.text!) {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    // Yes, User Exists
                    let isAdmin = PFUser.currentUser()?.objectForKey("adminPower")
                    print(isAdmin)
                        if(isAdmin as! Bool){
                        print("got through the if")
                        self.performSegueWithIdentifier("toAdminPage", sender: self)
                    }else{
                        print("what!")
                    self.performSegueWithIdentifier("toHomePage", sender: self)
                    }
                } else {
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
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
