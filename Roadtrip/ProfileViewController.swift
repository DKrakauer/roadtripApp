//
//  ProfileViewController.swift
//  Roadtrip
//
//  Created by David Krakauer on 2/12/16.
//  Copyright © 2016 David Krakauer. All rights reserved.
//
import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentVIew: UIView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        scrollView.contentSize.height = 700
        
    }
}
