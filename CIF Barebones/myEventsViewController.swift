//
//  myEventsViewController.swift
//  CIF Barebones
//
//  Created by Connor Wybranowski on 6/4/15.
//  Copyright (c) 2015 Wybro. All rights reserved.
//

import UIKit
import Parse

class myEventsViewController: UIViewController, UITableViewDataSource {
    
    var eventTypes = ["Upcoming", "Past"]
    var upcomingEventData: NSMutableArray! = NSMutableArray()
    var pastEventData: NSMutableArray! = NSMutableArray()
//    var userEventData: NSArray = [pastEventData]
    
    @IBOutlet weak var myEventsTableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserEventData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadUserEventData() {
        // Testing only : No user created, using generic data
        var findUserEvents: PFQuery = PFQuery(className: "userEvents")
        findUserEvents.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                for event: AnyObject in objects! {
                    if event["type"] as! String == "Upcoming" {
                        if !self.upcomingEventData.containsObject(event) {
                            self.upcomingEventData.addObject(event)
                        }
                    
                    }
                    else {
                        if !self.pastEventData.containsObject(event) {
                            self.pastEventData.addObject(event)
                        }
                    }
                
                }
                self.myEventsTableView.reloadData()
                println(self.upcomingEventData)
                println(self.pastEventData)
            }
            else {
                println(error)
            }
        
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let userEventData: NSArray = [upcomingEventData, pastEventData]
        return userEventData[section].count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let userEventData: NSArray = [upcomingEventData, pastEventData]
        let cell = tableView.dequeueReusableCellWithIdentifier("myEventCell", forIndexPath: indexPath) as! eventTableViewCell
        let eventType: NSMutableArray = userEventData[indexPath.section] as! NSMutableArray
        let event: PFObject = eventType[indexPath.row] as! PFObject
        cell.titleOfEvent.text = event["title"] as? String
        cell.locationOfEvent.text = event["location"] as? String
        return cell
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return eventTypes.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let eventType = eventTypes[section]
        return eventType
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "userEventMoreInfo" {
            let userEventData: NSArray = [upcomingEventData, pastEventData]
            var indexPath: NSIndexPath = self.myEventsTableView.indexPathForSelectedRow()!
            var selectedEventType: NSMutableArray = userEventData[indexPath.section] as! NSMutableArray
            var selectedEvent: PFObject = selectedEventType[indexPath.row] as! PFObject
            var destViewController = segue.destinationViewController as! savedEventViewController
            
            destViewController.selectedEventTitle = selectedEvent["title"] as? String
            destViewController.selectedEventLocation = selectedEvent["location"] as? String
            destViewController.selectedEventType = selectedEvent["type"] as? String
            
        }
    }

    
    


}
