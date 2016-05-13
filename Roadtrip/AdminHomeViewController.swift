//
//  AdminHomeViewController.swift
//  Roadtrip
//
//  Created by Robert Krakauer on 8/6/15.
//  Copyright (c) 2015 David Krakauer. All rights reserved.
//

import UIKit
import Parse


class AdminHomeViewController: UIViewController {
    
    @IBOutlet weak var WelcomeUser: UILabel!
    
    @IBAction func logOut(sender: AnyObject) {
        PFUser.logOut()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("OpenPageViewController")
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        if(PFUser.currentUser() == nil){
            print("Error: No User")
            
        }else{
            let currentUser = PFUser.currentUser()
            if currentUser != nil{
                WelcomeUser.text = currentUser?.objectForKey("realname") as? String
            }else{
                print("Error: User has vanished")
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func exitToAdminPage(segue:UIStoryboardSegue) {
        
    }
}
