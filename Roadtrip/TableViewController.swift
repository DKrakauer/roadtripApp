//
//  TableViewController.swift
//  Roadtrip
//
//  Created by Robert Krakauer on 7/2/15.
//  Copyright (c) 2015 David Krakauer. All rights reserved.
//
import UIKit
import Parse
import ParseUI

class TableViewController: PFQueryTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
    }
    
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        // Configure the PFQueryTableView
        self.parseClassName = "Location"
        self.textKey = "Name"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = true
        self.objectsPerPage = 5

    }
    
    
    
    
    
    
    
    
    
    
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: "Location")
        query.orderByAscending("Name")
        return query
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> CustomPFTableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! CustomPFTableViewCell!
        
        print("Loading Parse Database Files...")
        // Extract values from the PFObject to display in the table cell
        if let name = object?["Name"] as? String {
            cell?.nameTextLabel?.text = name
        }
        if let author = object?["authorName"] as? String {
            cell?.authorTextLabel?.text = author
        }
        if let likes = object?["Likes"] as? Int {
            var stringVal = String(likes)
            cell?.numLikes.text = stringVal
        }
        var initialThumbnail = UIImage(named: "Unloaded")
        cell.customFlag.image = initialThumbnail
        if let thumbnail = object?["imageCover"] as? PFFile {
            cell.customFlag.file = thumbnail
            cell.customFlag.loadInBackground()
            
            
        }
        print("Finished!")
        
        return cell
    }
    
    
    
    
    //Original prepareForSegue
   /* override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using [segue destinationViewController].
        var detailScene = segue.destinationViewController as! DetailViewController
        
        // Pass the selected object to the destination view controller.
        if let indexPath = self.tableView.indexPathForSelectedRow! {
            let row = Int(indexPath.row)
            detailScene.currentObject = (objects?[row] as! PFObject)
        }
    }*/
}







