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

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var descrip: UILabel!
    
    var currentObject : PFObject?
    
    var tripName = ""
    var tripAuthor = ""
    var tripLikes = 0
    var tripDescrip = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = tripName
        likes.text = String(tripLikes)
        author.text = tripAuthor
        descrip.text = tripDescrip
        
        //Description?
        
    }

   
}
