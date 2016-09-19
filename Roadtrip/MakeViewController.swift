//
//  MakeViewController.swift
//  Roadtrip
//
//  Created by David Krakauer on 4/8/16.
//  Copyright © 2016 David Krakauer. All rights reserved.
//

import UIKit
import Parse
import ParseUI

import SVProgressHUD


class MakeViewController: UIViewController,
            UIImagePickerControllerDelegate,
            UINavigationControllerDelegate,
            CLLocationManagerDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameBox: UITextField!
    @IBOutlet weak var addreBox: UITextField!
    @IBOutlet weak var imageBox: UIImageView!
    @IBOutlet weak var addSwitch: UISwitch!
    @IBOutlet weak var currSwitch: UISwitch!
    @IBOutlet weak var articBox: UITextView!
    var tempThumbnail = UIImage()
    var lat : Double = 0.1
    var long : Double = 0.1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize.height = 1014
    }
    
    @IBAction func switchChanged(sender: AnyObject) {
        //Fetching and setting latitude&longitude
        
        if (addSwitch.on){
            if(addreBox.text != nil){
            SVProgressHUD.show()
            print("adddress switch is on!")
            let g = CLGeocoder()
            g.geocodeAddressString(addreBox.text!, completionHandler: {(placemarks, error) -> Void in
                if((error) != nil){
                    print("Error", error)
                }
                if let placemark = placemarks?.first {
                    let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                    self.lat = coordinates.latitude
                    self.long = coordinates.longitude
                    
                }
            })
            SVProgressHUD.dismiss()
            }
        } else if (currSwitch.on && !addSwitch.on) {
            SVProgressHUD.show()
            print("current location switch is on!")
            let locatMan = CLLocationManager()
            locatMan.requestWhenInUseAuthorization()
            
            var currentLocation = CLLocation()
            
            if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways){
                currentLocation = locatMan.location!
                
                self.lat = currentLocation.coordinate.latitude
                self.long = currentLocation.coordinate.longitude
            }
            SVProgressHUD.dismiss()
        }
        
    }
    @IBAction func saveArticle(sender: AnyObject) {
        //add stuff to check fields
        //Creating trip and checking for thumbnail image
        print("Submitting new Trip for approval")
        if UIImageJPEGRepresentation(tempThumbnail, 0.05) != nil {
        let userNewArticle = PFObject(className: "Location")
        
        //Setting name
        userNewArticle["Name"] = nameBox.text
        print("Name - ")
            print(nameBox.text)
            print()
            
        //Setting author name
        let currentUser = PFUser.currentUser()
        let name1 = currentUser!.objectForKey("realname")
        userNewArticle["authorName"] = name1
        print("Author - ")
            print(name1)
            print()
        if currentUser!.objectForKey("userPic") != nil {
            let authPic = currentUser!.objectForKey("userPic")
            userNewArticle["authorPic"] = authPic
        }
        
            
        
            
            
                //Setting lat&long
        userNewArticle["lat"] = self.lat
        print("Latitude - ")
            print(self.lat)
        userNewArticle["long"] = self.long
        print("Longitude - ")
            print(self.long)
            print()
        
        //Setting description
        userNewArticle["Description"] = articBox.text
        print("Description - ")
            print(articBox.text)
            print()

        //Setting admin approval to false (needs to be approved first)
        userNewArticle["adminApproved"] = false
        print("Admin approval set to waiting for approval")
            
        //Setting likes count to default 0
        userNewArticle["Likes"] = 0
        print("Like count set to 0")
            
        //Converting and setting thumbnail image
        let imageData = UIImageJPEGRepresentation(tempThumbnail, 0.05)
        let imageFile = PFFile(name:"image.jpg", data:imageData!)
        userNewArticle["imageCover"] = imageFile
        print("Thumbnail image fetched")
            print("Thumbnail image uploaded")
            print()
            
        //Saving and submitting article
        print("Trip completed, now uploading...")
            userNewArticle.saveInBackgroundWithBlock {(success: Bool, error: NSError?) -> Void in
            }
        print("uploaded")
        } else {
            print("Failed to fetch Thumbnail image")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "toSetLocation"){
            let vc = segue.destinationViewController as! SetLocationViewController
            vc.addressField = addreBox.text!
        }
    }
    
   @IBAction func selectUser(sender: AnyObject) {
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
        imagePicker.allowsEditing = true
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image2: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        let image1 : UIImage = imageUtil.cropToSquare(image: image2, posX: 0, posY: 0, width: 304, height: 209)
        tempThumbnail = image1
        imageBox.image = image1
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    @IBAction func switched(sender: UISwitch!) {
        if (sender == addSwitch) {
            if(addSwitch.on){
                currSwitch.on = false
            }else{
                currSwitch.on = true
            }
        }else if (sender == currSwitch){
            if(currSwitch.on){
                addSwitch.on = false
            }else{
                addSwitch.on = true
            }
        }
    }
    
    @IBAction func exitToMakeTripSceneViewController(segue:UIStoryboardSegue) {
        
    }

    
      
    //End of image selection

}
