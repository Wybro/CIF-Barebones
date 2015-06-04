//
//  savedEventViewController.swift
//  CIF Barebones
//
//  Created by Connor Wybranowski on 6/4/15.
//  Copyright (c) 2015 Wybro. All rights reserved.
//

import UIKit

class savedEventViewController: UIViewController {
    
    var selectedEventTitle: String?
    var selectedEventLocation: String?
    var selectedEventType: String?
    
    @IBOutlet weak var remindersLabel: UILabel!
    @IBOutlet weak var remindersSwitch: UISwitch!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.eventTitle.text = selectedEventTitle
        self.eventLocation.text = selectedEventLocation
        if (selectedEventType != "Upcoming"){
            self.remindersLabel.hidden = true
            self.remindersSwitch.hidden = true
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func showCalendarActionSheet(sender: AnyObject) {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        let createEventAction = UIAlertAction(title: "Create Event", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            println("Create event option picked!")
        })
        
        let showInCalendarAction = UIAlertAction(title: "Show in Calendar", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            println("Show in Calendar option picked!")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            println("Cancelled")
        })
        
        optionMenu.addAction(createEventAction)
        optionMenu.addAction(showInCalendarAction)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
        
    }
    


}
