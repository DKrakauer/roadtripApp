//
//  DetailViewController.swift
//  Roadtrip
//
//  Created by Robert Krakauer on 7/27/15.
//  Copyright (c) 2015 David Krakauer. All rights reserved.
//

import UIKit
import Parse


class DetailViewController: UIViewController {

    //IBOutlets
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var descrip: UITextView!
    @IBOutlet weak var scroll: UIScrollView!

    
    //Place-Holder Variables
    var tripName = ""
    var tripAuthor = ""
    var tripLikes = 0
    var tripDescrip = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scroll.contentSize.height = 1000
        
        //Hooking up Place-Holders
        name.text = tripName
        likes.text = String(tripLikes)
        author.text = tripAuthor
        descrip.text = tripDescrip
        
        //Design correction
        descrip.textColor = UIColor.whiteColor()
        
    }
}
