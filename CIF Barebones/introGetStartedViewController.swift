//
//  introGetStartedViewController.swift
//  CIF Barebones
//
//  Created by Connor Wybranowski on 6/6/15.
//  Copyright (c) 2015 Wybro. All rights reserved.
//

import UIKit

class introGetStartedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func createProfile(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func restartProfile(sender: UIButton) {
        let alertViewController: UIAlertController = UIAlertController(title: "Restart Profile", message: "Are you sure you want to start over?", preferredStyle: .Alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
        }
        let restartAction: UIAlertAction = UIAlertAction(title: "Restart", style: .Destructive) { (action) -> Void in
            settingsMgr.clearSettings()
            self.performSegueWithIdentifier("restartProfile", sender: self)
        }
        alertViewController.addAction(cancelAction)
        alertViewController.addAction(restartAction)
        
        self.presentViewController(alertViewController, animated: true, completion: nil)
        
    }

}
