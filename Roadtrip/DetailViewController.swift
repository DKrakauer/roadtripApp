//
//  DetailViewController.swift
//  Roadtrip
//
//  Created by Robert Krakauer on 7/27/15.
//  Copyright (c) 2015 David Krakauer. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class DetailViewController: UIViewController {

    //IBOutlets
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var descrip: UITextView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var profilePicture: PFImageView!

    
    //Place-Holder Variables
    var tripName = ""
    var tripAuthor = ""
    var tripLikes = 0
    var tripDescrip = ""
    var ObjectIDLocat = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scroll.contentSize.height = 1000
        
        //Hooking up Place-Holders
        name.text = tripName
        likes.text = String(tripLikes)
        author.text = tripAuthor
        descrip.text = tripDescrip
        
        
        //Image editing
        profilePicture.image = cropPictureToCircle("tempAvatar")
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "toMapView"){
            print(self.ObjectIDLocat)
            let vc1 = segue.destinationViewController as! MapsViewController
            vc1.objectIDlocat = self.ObjectIDLocat
            
            
        }
        
    }
    
    
    
    func cropPictureToCircle(image : String) -> UIImage {
        
        let userPinImg : UIImage = UIImage(named: "EmptyPic")!
        UIGraphicsBeginImageContextWithOptions(userPinImg.size, false, 0.0);
        
        userPinImg.drawInRect(CGRect(origin: CGPointZero, size: userPinImg.size))
        
        let roundRect : CGRect = CGRectMake(2, 2, userPinImg.size.width-4, userPinImg.size.width-4)
        
        let myUserImgView = UIImageView(frame: roundRect)
        myUserImgView.image = UIImage(named: image)
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
    
    @IBAction func exitToDetailSceneViewController(segue:UIStoryboardSegue) {
        
    }
}
