//
//  pageContentViewController.swift
//  CIF Barebones
//
//  Created by Connor Wybranowski on 6/4/15.
//  Copyright (c) 2015 Wybro. All rights reserved.
//

import UIKit

class pageContentViewController: UIViewController {
    
    @IBOutlet weak var CIFImageView: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var introTextLabel: UILabel!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var optionalImage: UIImageView!
    
    @IBOutlet weak var useUserLocationButton: UIButton!
    @IBOutlet weak var userZipCodeButton: UIButton!
    
    @IBOutlet weak var serviceHoursTextField: UITextField!
    @IBOutlet weak var serviceHoursDoneButton: UIButton!
    
    var pageIndex: Int!
    var titleText: String!
    var pageDescription: String!
    var imageFile: String!
    var endOfSequence: Bool = true
    var optionalHidden: Bool = true
    
    var locationSettingsHidden: Bool = true
    
    var serviceHoursSettingsHidden: Bool = true
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.CIFImageView.image = UIImage(named: self.imageFile)
        self.welcomeLabel.text = self.titleText
        self.introTextLabel.text = self.pageDescription
        self.getStartedButton.hidden = self.endOfSequence
        self.optionalImage.hidden = self.optionalHidden
        
        self.useUserLocationButton.hidden = self.locationSettingsHidden
        self.userZipCodeButton.hidden = self.locationSettingsHidden
        
        self.serviceHoursTextField.hidden = self.serviceHoursSettingsHidden
        self.serviceHoursDoneButton.hidden = self.serviceHoursSettingsHidden


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewDidAppear(animated: Bool) {
//        UIView.animateWithDuration(1.0, animations: { () -> Void in
//            self.welcomeLabel.alpha = 1.0
//        })
//        UIView.animateWithDuration(1.0, animations: { () -> Void in
//            self.introTextLabel.alpha = 1.0
//        })
//    }
    
    @IBAction func getStarted(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func useUserLocation(sender: UIButton) {
        settingsMgr.setLocationSettings(sender.currentTitle!)
    }
    
    
    @IBAction func useZipCode(sender: UIButton) {
        settingsMgr.setLocationSettings(sender.currentTitle!)
    }
    
    @IBAction func setServiceHours(sender: UIButton) {
        settingsMgr.setServiceHour(serviceHoursTextField.text)
    }
    
    



}
