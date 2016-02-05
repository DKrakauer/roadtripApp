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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! CustomPFTableViewCell!
        
        print("Loading Parse Database Files...")
        // Extract values from the PFObject to display in the table cell
        if let name = object?["Name"] as? String {
            cell?.nameTextLabel?.text = name
            print("Loading " + name)
        }
        if let author = object?["authorName"] as? String {
            cell?.authorTextLabel?.text = author
        }
        if let likes = object?["Likes"] as? Int {
            let stringVal = String(likes)
            cell?.numLikes.text = stringVal
        }
        if let descrip = object?["Description"] as? String {
            cell?.descriptionHolder = descrip
        }
        let initialThumbnail = UIImage(named: "Unloaded")
        cell.customFlag.image = initialThumbnail
        if let thumbnail = object?["imageCover"] as? PFFile {
            cell.customFlag.file = thumbnail
            cell.customFlag.loadInBackground()
            
            
        }
        print("Finished loading!")
        
        return cell
    }
    
    
    
    
    
    //Original prepareForSegue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toDetailScene") {
            
            
            //Hooking up places-holder values
            let viewController = segue.destinationViewController as! DetailViewController
            
            let cell = sender as! CustomPFTableViewCell
            
            
            viewController.tripName = cell.nameTextLabel.text!
            viewController.tripAuthor = cell.authorTextLabel.text!
            viewController.tripLikes = Int(cell.numLikes.text!)!
            viewController.tripDescrip = cell.descriptionHolder
            
        }
    }
}








