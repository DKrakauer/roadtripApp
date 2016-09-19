//
//  TOUViewController.swift
//  Roadtrip
//
//  Created by David Krakauer on 6/6/16.
//  Copyright © 2016 David Krakauer. All rights reserved.
//

import UIKit

class TOUViewController: UIViewController {

    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize.height = 1550
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        scrollView.contentSize.height = contentView.frame.height
    }

    

}
