 //
//  SignUpViewController.swift
//  Roadtrip
//
//  Created by Robert Krakauer on 6/15/15.
//  Copyright (c) 2015 David Krakauer. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, UITextFieldDelegate {
    //defining IBOutlets for IB elements
    @IBOutlet weak var alertLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordTextField2: UITextField!
    
    @IBOutlet weak var getNewsLetter: UISwitch!
    
    @IBOutlet weak var scrollView: UIScrollView!

    @IBAction func signUpButton(sender: AnyObject) {
       //Login with parse
        if(passwordTextField.text == passwordTextField2.text){
            //defining varibles for the info they entered(even if blank)
            let desiredName = usernameTextField.text
            let desiredEmail = emailTextField.text
            let desiredPass = passwordTextField.text
            
            let wantsLetters = getNewsLetter.on
            
            
            if(desiredName != "" && desiredEmail != "" && desiredPass != ""){
                //Passwords match and all fields have info
                
                //adding new user to parse
                let newUser = PFUser()
                newUser.username = desiredName
                newUser.password = desiredPass
                newUser.email = desiredName
                newUser.setObject(desiredEmail!, forKey:"realname")
                newUser.setObject(wantsLetters, forKey:"getLetters")
                newUser.setObject(0,forKey:"adminPower")
                
                //Registering that user in Parse
                newUser.signUpInBackgroundWithBlock {
                    (succeeded: Bool, error: NSError?) -> Void in
                    if error == nil {
                        dispatch_async(dispatch_get_main_queue()) {
                            PFUser.logOut()
                        self.performSegueWithIdentifier("accountConfirm", sender: self)
                        }
                    }else{
                        if let message: AnyObject = error!.userInfo["error"] {
                            print(message)
                        }				
                    }
                }
            }else{
                //alert message for no info
                alertLabel.text = "Please fill in all fields!"
            }
        }else{
            //alert message for not matching passwords
            alertLabel.text = "Please make sure the passwords match!"
        }
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool { // called when 'return' key pressed. return NO to ignore.
        textField.resignFirstResponder()
        return true;
    }
    
    
    //autogenerated stuff(will move up if edited)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.passwordTextField2.delegate = self
        self.emailTextField.delegate = self
        
        // Do any additional setup after loading the view.
        scrollView.contentSize.height = 569
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exitToSignUpViewController(segue:UIStoryboardSegue) {
    }
    
    override func viewDidAppear(animated: Bool) {
        scrollView.contentSize.height = 569
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
