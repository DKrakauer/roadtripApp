//
//  imageUtil.swift
//  Roadtrip
//
//  Created by David Krakauer on 5/13/16.
//  Copyright © 2016 David Krakauer. All rights reserved.
//

import UIKit

class imageUtil: NSObject {
    
    static func cropToSquare(image originalImage: UIImage) -> UIImage {
        // Create a copy of the image without the imageOrientation property so it is in its native orientation (landscape)
        let contextImage: UIImage = UIImage(CGImage: originalImage.CGImage!)
        
        // Get the size of the contextImage
        
        let posX: CGFloat = 500
        let posY: CGFloat = 500
        let width: CGFloat = 298
        let height: CGFloat = 193
        
        // Check to see which length is the longest and create the offset based on that length, then set the width and height of our rect
        
        
        let rect: CGRect = CGRectMake(posX, posY, width, height)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImageRef = CGImageCreateWithImageInRect(contextImage.CGImage, rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(CGImage: imageRef, scale: originalImage.scale, orientation: originalImage.imageOrientation)
        
        return image
    }
    
    static func cropPictureToCircle(image : UIImage) -> UIImage {
        
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