//
//  CustomPFTableViewCell.swift
//  Roadtrip
//
//  Created by Robert Krakauer on 7/27/15.
//  Copyright (c) 2015 David Krakauer. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class CustomPFTableViewCell: PFTableViewCell {
    
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var authorTextLabel: UILabel!
    @IBOutlet weak var numLikes: UILabel!
    @IBOutlet weak var customFlag: PFImageView!
    
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}