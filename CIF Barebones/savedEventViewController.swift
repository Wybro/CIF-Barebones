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
    


}
