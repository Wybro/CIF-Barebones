//
//  eventViewController.swift
//  CIF Barebones
//
//  Created by Connor Wybranowski on 5/31/15.
//  Copyright (c) 2015 Wybro. All rights reserved.
//

import UIKit
import Parse
import MapKit

class eventViewController: UIViewController {
    
    var selectedEventTitle: String?
    var selectedEventLocation: String?
    var selectedEventGeoPoint: PFGeoPoint?
    var selectedEventBio: String?
    var selectedEventRequirements: String?
    
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventBio: UITextView!
    @IBOutlet weak var eventRequirements: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.eventTitle.text = selectedEventTitle
        self.eventLocation.text = selectedEventLocation
        
        self.eventBio.text = selectedEventBio
        self.eventRequirements.text = selectedEventRequirements
        
        // PFGeoPoint Parse
        println(selectedEventGeoPoint)
        let geoCoder = CLGeocoder()
        var placeMark: AnyObject
        var error: NSError
        var location: CLLocation = CLLocation(latitude: (selectedEventGeoPoint?.latitude)!, longitude: (selectedEventGeoPoint?.longitude)!)
        geoCoder.reverseGeocodeLocation(location, completionHandler: {
            (placeMark, error) -> Void in
            if error != nil {
                println("Error: \(error.localizedDescription)")
                return
            }
            if placeMark.count > 0 {
                let pm = placeMark[0] as! CLPlacemark
                println("Name: " + pm.name)
                println("Street: " + pm.thoroughfare)
                println("City: " + pm.locality)
                println("State: " + pm.administrativeArea)
                println("Postal Code: " + pm.postalCode)
                
            }
            else {
                println("Error with data")
            }
        })
        
        
        //MKMapView 
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let newLocation = CLLocationCoordinate2D(latitude: (selectedEventGeoPoint?.latitude)!, longitude: (selectedEventGeoPoint?.longitude)!)
        let region = MKCoordinateRegion(center: newLocation, span: span)
        mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = newLocation
        mapView.addAnnotation(annotation)
        
        
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signUp(sender: AnyObject) {
        self.resignFirstResponder()
        
    }

    @IBAction func showActionSheet(sender: AnyObject) {
        let optionMenu = UIAlertController(title: "Share Options", message: nil, preferredStyle: .ActionSheet)
        
        let faceBookAction = UIAlertAction(title: "Facebook", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            println("Facebook option picked!")
        })
        
        let twitterAction = UIAlertAction(title: "Twitter", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            println("Twitter option picked!")
        })
        
        let mailAction = UIAlertAction(title: "Mail", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            println("Mail option picked!")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            println("Cancelled")
        })
        
        optionMenu.addAction(faceBookAction)
        optionMenu.addAction(twitterAction)
        optionMenu.addAction(mailAction)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
        
        
    }
}
