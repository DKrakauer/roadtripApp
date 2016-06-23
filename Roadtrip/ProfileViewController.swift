//
//  ProfileViewController.swift
//  Roadtrip
//
//  Created by David Krakauer on 2/12/16.
//  Copyright © 2016 David Krakauer. All rights reserved.
//
import UIKit
import Parse
import ParseUI

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentVIew: UIView!
    
    @IBOutlet weak var nameBox: UITextField!
    @IBOutlet weak var Textviews: UITextView!
    @IBOutlet weak var emailBox: UITextField!
    @IBOutlet weak var passBox: UITextField!
    
    @IBOutlet weak var cityBox: UITextField!
    @IBOutlet weak var picSlot: PFImageView!

    
    var userpic = UIImage()

    override func viewDidLoad(){
        super.viewDidLoad()
        
        let currentUser = PFUser.currentUser()
        if currentUser != nil{
            nameBox.text = currentUser?.objectForKey("realname") as? String
            cityBox.text = currentUser?.objectForKey("cityName") as? String
            Textviews.text = currentUser?.objectForKey("about") as? String
        }
        Textviews.delegate = self
        scrollView.contentSize.height = 700
    }
    
    override func viewDidAppear(animated: Bool) {
        let currentUser = PFUser.currentUser()
        if currentUser != nil{
            if let name = currentUser!.objectForKey("realname ") as? String {
                nameBox.text = name
            }
            if let about = currentUser!.objectForKey("about") as? String {
                Textviews.text = about
            }
            if let city = currentUser!.objectForKey("cityName") as? String {
                cityBox.text = city
            }
            if let user = currentUser!.objectForKey("username") as? String {
                emailBox.text = user
            }
            if let user = currentUser!.objectForKey("password") as? String {
                passBox.text = user
            }
            picSlot.image = UIImage(named: "Unloaded")
            if let thumbnail = currentUser?.objectForKey("userPic") as? PFFile {
                picSlot.file = thumbnail
                picSlot.loadInBackground()
            }
        }
    }
    
    @IBAction func finishedEditing(sender: AnyObject) {
        let currentUser = PFUser.currentUser()
        currentUser?.saveInBackground()
    }

    @IBAction func editingEnded(sender: AnyObject) {
        let currentUser = PFUser.currentUser()
        if(sender as? UITextField == cityBox){
            if currentUser != nil {
                PFUser.currentUser()?.setObject(cityBox
                    .text!, forKey: "cityName")
            }
        }
        if(sender as? UITextField == nameBox){
            if currentUser != nil {
                currentUser?.setObject(nameBox.text!, forKey: "realname")
            }
        }
        if(sender as? UITextField == emailBox){
            let alertController = UIAlertController(title: "Warning", message:
                "Are you sure you would like to change your email?", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "No", style: .Default, handler: { (action: UIAlertAction!) in
                self.emailBox.text = currentUser?.objectForKey("username") as? String
            }))
            alertController.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
                currentUser?.setObject(self.emailBox.text!, forKey: "username")
            }))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        if(sender as? UITextField == passBox){
            let alertController = UIAlertController(title: "Warning", message:
                "Are you sure you would like to change your password?", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "No", style: .Default, handler: { (action: UIAlertAction!) in
                self.passBox.text = currentUser?.objectForKey("password") as? String
            }))
            alertController.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
                currentUser?.setObject(self.passBox.text!, forKey: "password")
            }))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    if(text == "\n") {
        let currentUser = PFUser.currentUser()
        textView.resignFirstResponder()
        if currentUser != nil {
            currentUser?.setObject(Textviews.text, forKey: "about")
        }
    return false
    }
    return true
    }
    
    @IBAction func DismissKeyboard(sender: AnyObject) {
        self.resignFirstResponder()
    }
    
    @IBAction func selectUser(sender: AnyObject) {
        let photoPicker = UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.sourceType = .PhotoLibrary
        
        self.presentViewController(photoPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = cropPictureToCircle(info[UIImagePickerControllerOriginalImage] as! UIImage)
        
        let imageData = UIImageJPEGRepresentation(image, 0.05)
        let imageFile = PFFile(name:"image.jpg", data:imageData!)

        let currentUser = PFUser.currentUser()
        if currentUser != nil {
            PFUser.currentUser()?.setObject(imageFile!, forKey: "userPic")
        }
        
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func cropPictureToCircle(image : UIImage) -> UIImage {
        let userPinImg : UIImage = UIImage(named: "EmptyPic")!
        UIGraphicsBeginImageContextWithOptions(userPinImg.size, false, 0.0);
        userPinImg.drawInRect(CGRect(origin: CGPointZero, size: userPinImg.size))
        let roundRect : CGRect = CGRectMake(2, 2, userPinImg.size.width-4, userPinImg.size.width-4)
        let myUserImgView = UIImageView(frame: roundRect)
        myUserImgView.image = image
        //        myUserImgView.backgroundColor = UIColor.blackColor()
        //        myUserImgView.layer.borderColor = UIColor.whiteColor().CGColor
        //        myUserImgView.layer.borderWidth = 0.5
        let layer: CALayer = myUserImgView.layer
        layer.masksToBounds = true
        layer.cornerRadius = myUserImgView.frame.size.width/2
        UIGraphicsBeginImageContextWithOptions(myUserImgView.bounds.size, myUserImgView.opaque, 0.0)
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        roundedImage.drawInRect(roundRect)
        
        let resultImg : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resultImg
    }
}
