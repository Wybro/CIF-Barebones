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
    
    @IBOutlet weak var acceptEntryButton: UIButton!
    @IBOutlet weak var cancelEntryButton: UIButton!
    @IBOutlet weak var zipCodeEntryField: UITextField!
    @IBOutlet weak var acceptButtonFromCenter: NSLayoutConstraint!
    @IBOutlet weak var cancelButtonFromCenter: NSLayoutConstraint!
    
    
    
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
        self.zipCodeButton.enabled = false
    }
    
    @IBAction func useZipCode(sender: UIButton) {
        settingsMgr.setLocationSettings(sender.currentTitle!)
        enterZipCodeMode()
    }
    
    func enterZipCodeMode() {
        buttonFadeOut(self.currentLocationButton)
        buttonFadeOut(self.zipCodeButton)
        enterZipCodeAnimation()
    }
    
    func exitZipCodeMode() {
        exitZipCodeAnimation()
        self.zipCodeEntryField.resignFirstResponder()
    }
    
    func enterZipCodeAnimation() {
        // Disable & Hide original UI objects
        self.currentLocationButton.enabled = false
        self.currentLocationButton.hidden = true
        self.zipCodeButton.hidden = true
        
        // Reveal ZIP Code entry UI objects
        self.acceptEntryButton.hidden = false
        self.cancelEntryButton.hidden = false
        self.zipCodeEntryField.hidden = false
        buttonFadeIn(self.acceptEntryButton)
        buttonFadeIn(self.cancelEntryButton)
        textFieldFadeIn(self.zipCodeEntryField)
        
        
        // Animation settings
        self.acceptButtonFromCenter.constant = 0
        self.cancelButtonFromCenter.constant = 0
        self.view.layoutIfNeeded()
        self.acceptButtonFromCenter.constant = -35
        self.cancelButtonFromCenter.constant = -35
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    func exitZipCodeAnimation() {
        // Animation settings
        self.acceptButtonFromCenter.constant = -35
        self.cancelButtonFromCenter.constant = -35
        self.view.layoutIfNeeded()
        self.acceptButtonFromCenter.constant = 0
        self.cancelButtonFromCenter.constant = 0
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
            self.view.layoutIfNeeded()
            }, completion: { (complete: Bool) in
                // Hide ZIP Code entry UI objects
                self.acceptEntryButton.hidden = true
                self.cancelEntryButton.hidden = true
                self.zipCodeEntryField.hidden = true
                
                // Enable & Reveal original UI objects
                self.currentLocationButton.hidden = false
                self.zipCodeButton.hidden = false
                self.currentLocationButton.enabled = true
                self.buttonFadeIn(self.currentLocationButton)
                self.buttonFadeIn(self.zipCodeButton)
                
        })

    }
    
    @IBAction func acceptZipCodeEntry(sender: UIButton) {
        self.nextPageButton.enabled = true
        println(self.zipCodeEntryField.text)
    }
    
    @IBAction func cancelZipCodeEntry(sender: UIButton) {
        exitZipCodeMode()
    }
    
    func buttonFadeIn(sender: UIButton) {
        sender.alpha = 0
//        UIView.animateWithDuration(1.0, animations: { () -> Void in
//            sender.alpha = 1.0
//        })
        
        UIView.animateWithDuration(0.4, delay: 0, options: nil, animations: { () -> Void in
            sender.alpha = 1.0
        }, completion: nil)
    }
    
    func buttonFadeOut(sender: UIButton) {
        sender.alpha = 1.0
//        UIView.animateWithDuration(1.0, animations: { () -> Void in
//            sender.alpha = 0
//        })
        UIView.animateWithDuration(0.4, delay: 0, options: nil, animations: { () -> Void in
            sender.alpha = 0
            }, completion: nil)
        
    }
    
    func textFieldFadeOut(sender: UITextField) {
        sender.alpha = 1.0
        UIView.animateWithDuration(0.4, delay: 0, options: nil, animations: { () -> Void in
            sender.alpha = 0
            }, completion: nil)
    }
    
    func textFieldFadeIn(sender: UITextField) {
        sender.alpha = 0
        UIView.animateWithDuration(0.4, delay: 0, options: nil, animations: { () -> Void in
            sender.alpha = 1.0
            }, completion: nil)
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
