//
//  locationSettingsViewController.swift
//  CIF Barebones
//
//  Created by Connor Wybranowski on 6/9/15.
//  Copyright (c) 2015 Wybro. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class locationSettingsViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {

    //MARK: UI Elements
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var zipCodeButton: UIButton!
    
    @IBOutlet weak var acceptEntryButton: UIButton!
    @IBOutlet weak var cancelEntryButton: UIButton!
    @IBOutlet weak var zipCodeEntryField: UITextField!
    @IBOutlet weak var acceptButtonFromCenter: NSLayoutConstraint!
    @IBOutlet weak var cancelButtonFromCenter: NSLayoutConstraint!
    
    @IBOutlet weak var zipCodeAddressLabel: UILabel!
    @IBOutlet weak var successCheckImageView: UIImageView!
    
    @IBOutlet weak var geocodeActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var currentLocationCurrentSettingImage: UIImageView!
    @IBOutlet weak var zipCodeCurrentSettingImage: UIImageView!
    
    @IBOutlet weak var currentZipCodeLabel: UILabel!
    @IBOutlet weak var editZipCodeButton: UIButton!
    
    let locationManager = CLLocationManager()
    
    //MARK: View & Misc Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.currentLocationButton.alpha = 0.0
        self.zipCodeButton.alpha = 0.0
        
        self.successCheckImageView.alpha = 0
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.iconFadeIn(self.checkCurrentLocationSetting())
        
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            self.currentLocationButton.alpha = 1.0
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.25, options: .CurveEaseOut, animations: { () -> Void in
            self.zipCodeButton.alpha = 1.0
            }, completion: { (complete: Bool) in
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
    }
    
    // Text Field Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func checkCurrentLocationSetting() -> UIImageView {
        // Using current location
        if settingsMgr.getLocationSettings() == "currentLocation" {
            self.currentLocationCurrentSettingImage.hidden = false
            if self.currentLocationButton.enabled {
                self.currentLocationButton.enabled = false
            }
            self.zipCodeButton.enabled = true
            self.zipCodeCurrentSettingImage.hidden = true
            
            self.currentZipCodeLabel.hidden = true
            self.editZipCodeButton.hidden = true
            return self.currentLocationCurrentSettingImage
        }
        // Using ZIP Code
        else {
            self.zipCodeCurrentSettingImage.hidden = false
            self.currentLocationCurrentSettingImage.hidden = true
            if self.zipCodeButton.enabled {
               self.zipCodeButton.enabled = false
            }
            self.currentLocationButton.enabled = true
            self.currentZipCodeLabel.text = "Current: " + settingsMgr.getZipCodeValue()
            self.currentZipCodeLabel.hidden = false
            self.editZipCodeButton.hidden = false
            return self.zipCodeCurrentSettingImage
        }
    }

    
    //MARK: UI Buttons
    @IBAction func useCurrentLocation(sender: UIButton) {
//        settingsMgr.setLocationSettings("currentLocation")
//        iconFadeIn(checkCurrentLocationSetting())
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.zipCodeButton.enabled = false
    }
    
    @IBAction func useZipCode(sender: UIButton) {
//        settingsMgr.setLocationSettings("zipCode")
//        iconFadeIn(checkCurrentLocationSetting())
        enterZipCodeMode()
    }
    
    func enterZipCodeMode() {
        // Disable & Hide original UI objects
        buttonFadeOut(self.currentLocationButton)
        buttonFadeOut(self.zipCodeButton)
        self.currentLocationButton.enabled = false
        
        iconFadeOut(checkCurrentLocationSetting())
        self.currentZipCodeLabel.hidden = true
        self.editZipCodeButton.hidden = true
        
        enterZipCodeAnimation()
    }
    
    func exitZipCodeMode() {
        self.zipCodeAddressLabel.hidden = true
        exitZipCodeAnimation()
        self.zipCodeEntryField.resignFirstResponder()
    }
    
    @IBAction func acceptZipCodeEntry(sender: UIButton) {
        // check to ensure not empty and only five numbers
        if (self.zipCodeEntryField.text != "" && self.zipCodeEntryField.text.toInt() != nil && count(self.zipCodeEntryField.text) == 5) {
            self.successCheckImageView.image = UIImage(named: "Success Circle Check Icon")
            self.geocodeActivityIndicator.startAnimating()
            lookUpZipCode(self.zipCodeEntryField.text)
        }
        else {
            self.successCheckImageView.image = UIImage(named: "Error Circle Icon")
            iconFadeOut(self.successCheckImageView)
        }
    }
    
    @IBAction func cancelZipCodeEntry(sender: UIButton) {
        self.zipCodeEntryField.text = ""
        exitZipCodeMode()
    }
    
    @IBAction func editZipCode(sender: UIButton) {
        enterZipCodeMode()
    }
    
    
    // MARK: Animation Methods
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
            }, completion: { (complete: Bool) in
                self.zipCodeEntryField.becomeFirstResponder()
        })
        
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
                
                self.iconFadeIn(self.checkCurrentLocationSetting())
        })
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
    
    func iconFadeIn(image: UIImageView) {
        image.alpha = 0.0
        UIView.animateWithDuration(1.25, animations: { () -> Void in
            image.alpha = 1.0
        })
    }
    
    func iconFadeOut(image: UIImageView) {
        image.alpha = 1.0
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            image.alpha = 0.0
        })
    }
    
    //MARK: Location Methods
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            if error != nil {
                println("Error: " + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as! CLPlacemark
                self.displayLocationInfo(pm)
                // Set user's current location
                let currentLocation: CLLocation = pm.location
                settingsMgr.setCurrentLocationValue(currentLocation)
                // Only change settings if no error
                settingsMgr.setLocationSettings("currentLocation")
                self.iconFadeIn(self.checkCurrentLocationSetting())
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
        
        
        let fixSettingsAlert: UIAlertController = UIAlertController(title: "Fix Location Settings", message: "To use your current location, please change your location settings for CIF", preferredStyle: .Alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let settingsAction: UIAlertAction = UIAlertAction(title: "Settings", style: .Default) { (action) -> Void in
            UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
        }
        
        fixSettingsAlert.addAction(cancelAction)
        fixSettingsAlert.addAction(settingsAction)
        
        self.presentViewController(fixSettingsAlert, animated: true, completion: nil)
        
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
            // Search was successful & has results
            if placeMark.count > 0 {
                let pm = placeMark[0] as! CLPlacemark
                println("Name: " + pm.name)
                println("City: " + pm.locality)
                println("State: " + pm.administrativeArea)
                println("Postal Code: " + pm.postalCode)
                
                // Get current location - latitude & longitude
                let currentLocation: CLLocation = pm.location
                // Set user's current location
                settingsMgr.setCurrentLocationValue(currentLocation)
                
                addressString = pm.locality + ", " + pm.administrativeArea
                
                self.geocodeActivityIndicator.stopAnimating()
                
                self.zipCodeAddressLabel.hidden = false
                self.zipCodeAddressLabel.text = addressString
                settingsMgr.setZipCodeValue(code)
                self.iconFadeOut(self.successCheckImageView)
                
                // Only change settings if no error
                settingsMgr.setLocationSettings("zipCode")
                
            }
            else {
                println("Error with data")
                return
            }
        })
    }


}
