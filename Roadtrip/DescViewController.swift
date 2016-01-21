//
//  DescViewController.swift
//  Roadtrip
//
//  Created by Robert Krakauer on 6/29/15.
//  Copyright (c) 2015 David Krakauer. All rights reserved.
//

import UIKit

class DescViewController: UIViewController {
    
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var descLabel: UITextView!
    
    
    
    
    
    
    
    

    @IBAction func exitPage(sender: AnyObject) {
        if let navController = self.navigationController {
            navController.popViewControllerAnimated(true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
