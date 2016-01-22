//
//  HomeViewController.swift
//  Roadtrip
//
//  Created by Robert Krakauer on 6/8/15.
//  Copyright (c) 2015 David Krakauer. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController {

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


        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func exitToHomeSceneViewController(segue:UIStoryboardSegue) {
        
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
