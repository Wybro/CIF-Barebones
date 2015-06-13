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
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        return refreshControl
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadData()
        
        self.eventsList.addSubview(self.refreshControl)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.eventsList.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        self.eventData.removeAllObjects()
        self.eventsList.reloadData()
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
                    let eventLocationCoords: CLLocation = CLLocation(latitude: eventGeoPoint.latitude, longitude: eventGeoPoint.longitude)
                    
                    let newEvent: Event = Event(eventTitle: eventTitle, eventLocation: eventLocation, geoLocation: eventGeoPoint, coords: eventLocationCoords, eventBio: eventBio, eventReq: eventReqs)
                    
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
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        loadData()
        refreshControl.endRefreshing()
    }
    
    func findDistance(userLocation: CLLocation, eventLocation: CLLocation) -> String {
        var distanceFromLocation = userLocation.distanceFromLocation(eventLocation)
        // Meters to miles conversion
        var distanceInMiles = distanceFromLocation / 1609.34
        // Determine best number to display
        if distanceInMiles < 100 {
            var displayDistance = String.localizedStringWithFormat("%.2f", distanceInMiles)
            return displayDistance
        }
        else {
            var displayDistance = Int(floor(distanceFromLocation / 1609.34))
            return displayDistance.description
        }

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventData.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! eventTableViewCell
        
        var selectedEvent: Event = self.eventData[indexPath.row] as! Event
        
        cell.titleOfEvent.text = selectedEvent.getTitle()
        cell.locationOfEvent.text = selectedEvent.getLocation()
        cell.distanceFromLocation.text = findDistance(settingsMgr.getCurrentLocationValue(), eventLocation: selectedEvent.getLocationCoordinates())
        
        return cell
    }

    // Consider passing the selected event to destVC and handling assignments there
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "eventMoreInfo" {
            var indexPath: NSIndexPath = self.eventsList.indexPathForSelectedRow()!
            var selectedEvent: Event = self.eventData[indexPath.row] as! Event
            var destViewController = segue.destinationViewController as! eventViewController
            destViewController.selectedEventTitle = selectedEvent.getTitle()
            destViewController.selectedEventLocation = selectedEvent.getLocation()
            destViewController.selectedEventGeoPoint = selectedEvent.getGeoPoint()
            destViewController.selectedEventDistanceAway = findDistance(settingsMgr.currentLocation, eventLocation: selectedEvent.getLocationCoordinates())
            destViewController.selectedEventBio = selectedEvent.getBio()
            destViewController.selectedEventRequirements = selectedEvent.getRequirements()
        }
    }
    
    
}
