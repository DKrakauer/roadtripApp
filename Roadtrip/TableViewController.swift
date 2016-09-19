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

class TableViewController:UITableViewController, UISearchBarDelegate,
    UISearchDisplayDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    var searchActive : Bool = false
    var data:[PFObject]!
    var filtered:[PFObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        self.navigationController?.navigationBarHidden = false
        
        search()
        
    }
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    func search(searchText: String? = nil){
        let query = PFQuery(className: "Location")
        query.whereKey("adminApproved", equalTo: true)
        if(searchText != nil){
            query.whereKey("Name", containsString: searchText)
        }
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            self.data = results as [PFObject]!
            self.tableView.reloadData()
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.data != nil){
            return self.data.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let obj = self.data[indexPath.row]
        
        let cell2 = tableView.dequeueReusableCellWithIdentifier("Cell2") as! CustomPFTableViewCell!
        
        
        
        if let author = obj["authorName"] as? String {
            cell2?.authorTextLabel?.text = author
        }
        if let name = obj["Name"] as? String {
            cell2?.nameTextLabel?.text = name
        }
        if let likes = obj["Likes"] as? Int {
            cell2?.numLikes?.text = String(likes)
        }
        if let thumbnail = obj["imageCover"] as? PFFile {
            cell2.customFlag.file = thumbnail
            cell2.customFlag.loadInBackground()
        }
        if let thumbnail = obj["authorPic"] as? PFFile {
            cell2.authorSlot.file = thumbnail
            cell2.authorSlot.loadInBackground()
        }
        
        if let descrip = obj["Description"] as? String {
            cell2.descriptionHolder = descrip
        }
        if let tripID = obj.objectId {
            cell2.tripIDholder = tripID
        }
        
        
        //cell.authorLabel!.text = obj[""]
        
        return cell2
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toDetailScene") {
            
            
            //Hooking up places-holder values
            let viewController = segue.destinationViewController as! DetailViewController
            
            let cell = sender as! CustomPFTableViewCell
            
            viewController.profilePicture.file = cell.authorSlot.file
            viewController.tripName = cell.nameTextLabel.text!
            viewController.tripAuthor = cell.authorTextLabel.text!
            viewController.ObjectIDLocat = cell.tripIDholder
            if let text = cell.numLikes.text {
                if let textInt = Int(text) {
                    viewController.tripLikes = textInt
                } else {
                    viewController.tripLikes = 0
                }
            } else {
                viewController.tripLikes = 0
            }
            viewController.tripDescrip = cell.descriptionHolder
            
        }
    }
    
    
    
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        search(searchText)
    }
    
    @IBAction func exitToFeedSceneViewController(segue:UIStoryboardSegue) {
        
    }
}








