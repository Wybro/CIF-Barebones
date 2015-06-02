//
//  exploreViewController.swift
//  CIF Barebones
//
//  Created by Connor Wybranowski on 5/31/15.
//  Copyright (c) 2015 Wybro. All rights reserved.
//

import UIKit
import Parse

class exploreViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var eventsList: UITableView!
    var eventData: NSMutableArray! = NSMutableArray()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        var findEvents: PFQuery = PFQuery(className: "Events")
        findEvents.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                for event: AnyObject in objects! {
                    let eventTitle = event["title"] as! String
                    let eventLocation = event["location"] as! String
                    let eventGeoPoint = event["geoPoint"] as! PFGeoPoint
                    let eventBio = event["bio"] as! String
                    let eventReqs = event["requirements"] as! String
//                    let newEvent: Event = Event(eventTitle: eventTitle, eventLocation: eventLocation, eventBio: eventBio, eventReq: eventReqs)
                    let newEvent: Event = Event(eventTitle: eventTitle, eventLocation: eventLocation, geoLocation: eventGeoPoint, eventBio: eventBio, eventReq: eventReqs)
                    
                    if !self.eventData.containsObject(newEvent){
                        self.eventData.addObject(newEvent)
                    }
                    
                }
                self.eventsList.reloadData()
            }
            else {
                println(error)
            }
        }
    }
    
      
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventData.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! eventTableViewCell
        cell.titleOfEvent.text = (eventData[indexPath.row] as! Event).getTitle()
        cell.locationOfEvent.text = (eventData[indexPath.row] as! Event).getLocation()
        return cell
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "eventMoreInfo" {
            var indexPath: NSIndexPath = self.eventsList.indexPathForSelectedRow()!
            var selectedEvent: Event = self.eventData[indexPath.row] as! Event
            var destViewController = segue.destinationViewController as! eventViewController
            destViewController.selectedEventTitle = selectedEvent.getTitle()
            destViewController.selectedEventLocation = selectedEvent.getLocation()
            destViewController.selectedEventGeoPoint = selectedEvent.getGeoPoint()
            destViewController.selectedEventBio = selectedEvent.getBio()
            destViewController.selectedEventRequirements = selectedEvent.getRequirements()
        }
    
    
    }
    
    
}
