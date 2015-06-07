//
//  introLocationSettingsViewController.swift
//  CIF Barebones
//
//  Created by Connor Wybranowski on 6/6/15.
//  Copyright (c) 2015 Wybro. All rights reserved.
//

import UIKit
import CoreLocation

class introLocationSettingsViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var zipCodeButton: UIButton!
    @IBOutlet weak var moreInfoLabel: UILabel!
    
    @IBOutlet weak var nextPageButton: UIBarButtonItem!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.currentLocationButton.alpha = 0.0
        self.zipCodeButton.alpha = 0.0
        self.moreInfoLabel.alpha = 0.0
        self.nextPageButton.enabled = false
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            self.currentLocationButton.alpha = 1.0
        }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.25, options: .CurveEaseOut, animations: { () -> Void in
            self.zipCodeButton.alpha = 1.0
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.50, options: .CurveEaseOut, animations: { () -> Void in
            self.moreInfoLabel.alpha = 1.0
            }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func useCurrentLocation(sender: UIButton) {
        settingsMgr.setLocationSettings(sender.currentTitle!)
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.nextPageButton.enabled = true
    }
    
    @IBAction func useZipCode(sender: UIButton) {
        settingsMgr.setLocationSettings(sender.currentTitle!)
        self.nextPageButton.enabled = true
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            if error != nil {
                println("Error: " + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as! CLPlacemark
                self.displayLocationInfo(pm)
            }
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
        self.locationManager.stopUpdatingLocation()
        println(placemark.locality)
        println(placemark.postalCode)
        println(placemark.administrativeArea)
        println(placemark.country)
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: " + error.localizedDescription)
    }
    
    

}
