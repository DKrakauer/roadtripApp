//
//  OpenPageViewController.swift
//  Roadtrip
//
//  Created by Robert Krakauer on 6/8/15.
//  Copyright (c) 2015 David Krakauer. All rights reserved.
//

import UIKit
import Parse

class OpenPageViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //check to see if they have already logged in
        let currentUser = PFUser.currentUser()
        if currentUser != nil {
            //They have already signed in. Move to Home Page
            if let isAdmin = PFUser.currentUser()?.objectForKey("adminPower") as? Int {
                if isAdmin == 1 {
                    performSegueWithIdentifier("alreadyAdmin", sender: AnyObject?())
                }else{
                    print("Moving to log in view controller")
                    performSegueWithIdentifier("alreadyLoggedIn", sender: AnyObject?())
                }
            }
            
            
        } else {
            //Let them press the log in button
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func exitToOpenPageViewController(segue:UIStoryboardSegue) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
