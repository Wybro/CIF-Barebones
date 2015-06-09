//
//  introLocationSettingsViewController.swift
//  CIF Barebones
//
//  Created by Connor Wybranowski on 6/6/15.
//  Copyright (c) 2015 Wybro. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class introLocationSettingsViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var zipCodeButton: UIButton!
    @IBOutlet weak var moreInfoLabel: UILabel!
    
    @IBOutlet weak var nextPageButton: UIBarButtonItem!
    
    @IBOutlet weak var acceptEntryButton: UIButton!
    @IBOutlet weak var cancelEntryButton: UIButton!
    @IBOutlet weak var zipCodeEntryField: UITextField!
    @IBOutlet weak var acceptButtonFromCenter: NSLayoutConstraint!
    @IBOutlet weak var cancelButtonFromCenter: NSLayoutConstraint!
    
    @IBOutlet weak var zipCodeAddressLabel: UILabel!
    @IBOutlet weak var successCheckImageView: UIImageView!
    
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.currentLocationButton.alpha = 0.0
        self.zipCodeButton.alpha = 0.0
        self.moreInfoLabel.alpha = 0.0
        self.nextPageButton.enabled = false
        
        self.successCheckImageView.alpha = 0
        
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
        self.zipCodeButton.enabled = false
    }
    
    @IBAction func useZipCode(sender: UIButton) {
        settingsMgr.setLocationSettings(sender.currentTitle!)
        enterZipCodeMode()
    }
    
    func enterZipCodeMode() {
        // Disable & Hide original UI objects
        buttonFadeOut(self.currentLocationButton)
        buttonFadeOut(self.zipCodeButton)
        self.currentLocationButton.enabled = false
        
        enterZipCodeAnimation()
    }
    
    func exitZipCodeMode() {
        self.zipCodeAddressLabel.hidden = true
        exitZipCodeAnimation()
        self.zipCodeEntryField.resignFirstResponder()
    }
    
    func enterZipCodeAnimation() {        
        // Animation settings
        self.acceptButtonFromCenter.constant = 0
        self.cancelButtonFromCenter.constant = 0
        self.view.layoutIfNeeded()
        self.acceptButtonFromCenter.constant = -35
        self.cancelButtonFromCenter.constant = -35
        
        self.acceptEntryButton.alpha = 0
        self.cancelEntryButton.alpha = 0
        self.zipCodeEntryField.alpha = 0
        self.acceptEntryButton.hidden = false
        self.cancelEntryButton.hidden = false
        self.zipCodeEntryField.hidden = false
        
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
            self.view.layoutIfNeeded()
            
            self.acceptEntryButton.alpha = 1
            self.cancelEntryButton.alpha = 1
            self.zipCodeEntryField.alpha = 1
        }, completion: nil)
        
    }
    
    func exitZipCodeAnimation() {
        // Animation settings
        self.acceptButtonFromCenter.constant = -35
        self.cancelButtonFromCenter.constant = -35
        self.view.layoutIfNeeded()
        self.acceptButtonFromCenter.constant = 0
        self.cancelButtonFromCenter.constant = 0
        
        self.acceptEntryButton.alpha = 1
        self.cancelEntryButton.alpha = 1
        self.zipCodeEntryField.alpha = 1
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
            self.view.layoutIfNeeded()
            
            self.acceptEntryButton.alpha = 0
            self.cancelEntryButton.alpha = 0
            self.zipCodeEntryField.alpha = 0
            }, completion: { (complete: Bool) in
                // Hide ZIP Code entry UI objects
                self.acceptEntryButton.hidden = true
                self.cancelEntryButton.hidden = true
                self.zipCodeEntryField.hidden = true
                
                // Enable & Reveal original UI objects
                self.currentLocationButton.enabled = true
                self.buttonFadeIn(self.currentLocationButton)
                self.buttonFadeIn(self.zipCodeButton)
        })
    }
    
    @IBAction func acceptZipCodeEntry(sender: UIButton) {
        self.nextPageButton.enabled = true
        println(self.zipCodeEntryField.text)
        // check to ensure not empty and only five numbers
        if (self.zipCodeEntryField.text != "" && self.zipCodeEntryField.text.toInt() != nil && count(self.zipCodeEntryField.text) == 5) {
            self.successCheckImageView.image = UIImage(named: "Success Circle Check Icon")
            lookUpZipCode(self.zipCodeEntryField.text)
        }
        else {
            self.successCheckImageView.image = UIImage(named: "Error Circle Icon")
            iconFade()
        }

    }
    
    @IBAction func cancelZipCodeEntry(sender: UIButton) {
        self.zipCodeEntryField.text = ""
        exitZipCodeMode()
    }
    
    func buttonFadeIn(sender: UIButton) {
        sender.alpha = 0
        sender.hidden = false
        UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: { () -> Void in
            sender.alpha = 1.0
        }, completion: nil)
    }
    
    func buttonFadeOut(sender: UIButton) {
        sender.alpha = 1.0
        UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: { () -> Void in
            sender.alpha = 0
            }, completion: { (finished: Bool) in
                sender.hidden = finished
        })
    }
    
    func textFieldFadeIn(sender: UITextField) {
        sender.alpha = 0
        sender.hidden = false
        UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: { () -> Void in
            sender.alpha = 1.0
            }, completion: nil)
    }
    
    func textFieldFadeOut(sender: UITextField) {
        sender.alpha = 1.0
        UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: { () -> Void in
            sender.alpha = 0
            }, completion: { (finished: Bool) in
                sender.hidden = finished
        })
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
    
    func lookUpZipCode(code: String) {
        let geoCoder = CLGeocoder()
        var placeMark: AnyObject
        var error: NSError
        var addressString: String = ""
        geoCoder.geocodeAddressString(code, completionHandler: { (placeMark, error) -> Void in
            if error != nil {
                println("Error: \(error.localizedDescription)")
                return
            }
            if placeMark.count > 0 {
                let pm = placeMark[0] as! CLPlacemark
                println("Name: " + pm.name)
                println("City: " + pm.locality)
                println("State: " + pm.administrativeArea)
                println("Postal Code: " + pm.postalCode)
                
                addressString = pm.locality + ", " + pm.administrativeArea
                self.zipCodeAddressLabel.hidden = false
                self.zipCodeAddressLabel.text = addressString
                self.iconFade()
            }
            else {
                println("Error with data")
                return
            }
        })
    }
    
    func iconFade() {
        self.successCheckImageView.alpha = 1.0
        UIView.animateWithDuration(1.25, animations: { () -> Void in
            self.successCheckImageView.alpha = 0.0
        })
    }

}
