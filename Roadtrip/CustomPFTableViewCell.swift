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


class CustomPFTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var authorTextLabel: UILabel!
    @IBOutlet weak var numLikes: UILabel!
    @IBOutlet weak var authorSlot: PFImageView!
    @IBOutlet weak var customFlag: PFImageView!
    
    var descriptionHolder = ""
    var tripIDholder = ""
    
    func viewDidLoad() {
        
        
        
    }
    

}
