//
//  ContentViewController.swift
//  
//
//  Created by Robert Krakauer on 6/29/15.
//
//

import UIKit
import Parse

class ContentViewController: UITableViewController {
    
    
    var locations = [PFObject]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("got to veiwdidload")
        
        let query = PFQuery(className:"Location")
        query.orderByAscending("nameEnglish")
        query.limit = 5
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved David's entries")
                // Do something with the found objects
                if let objects = objects {
                    for index in 1...5{
                        self.locations[index] = objects[index]
                        
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
            print(self.locations.count)
        }
        
        
        
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
        
        let locationName = self.locations[indexPath.row]["Name"] as! String
        cell.textLabel?.text = locationName
        
        
        
        return cell
        
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
