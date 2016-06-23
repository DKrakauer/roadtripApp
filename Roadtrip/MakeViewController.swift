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

class MakeViewController: UIViewController,
            UIImagePickerControllerDelegate,
            UINavigationControllerDelegate{

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var nameBox: UITextField!
    @IBOutlet weak var authorBox: UITextField!
    @IBOutlet weak var addreBox: UITextField!
    
    @IBOutlet weak var articBox: UITextView!
    
    var tempThumbnail = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize.height = 1014
    }

    @IBAction func saveArticle(sender: AnyObject) {
        let userNewArticle = PFObject(className: "Location")
        userNewArticle["Name"] = nameBox.text
        userNewArticle["authorName"] = authorBox.text
        userNewArticle["Description"] = articBox.text
        userNewArticle["adminApproved"] = false
        userNewArticle["Likes"] = 0
        
        let image = imageUtil.cropToSquare(image: tempThumbnail)
        let imageData = UIImageJPEGRepresentation(image, 0.05)
        let imageFile = PFFile(name:"image.jpg", data:imageData!)
        userNewArticle["imageCover"] = imageFile
        
        
        
        userNewArticle.saveInBackgroundWithBlock {(success: Bool, error: NSError?) -> Void in
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "toSetLocation"){
            let vc = segue.destinationViewController as! SetLocationViewController
            vc.addressField = addreBox.text!
        }
    }
    
    
    //Everything below here is for image selection
    //photo picker file
   @IBAction func selectUser(sender: AnyObject) {
        let photoPicker = UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.sourceType = .PhotoLibrary
        
        self.presentViewController(photoPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        tempThumbnail = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    
    @IBAction func exitToMakeTripSceneViewController(segue:UIStoryboardSegue) {
        
    }

    
      
    //End of image selection

}
