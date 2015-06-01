//
//  eventViewController.swift
//  CIF Barebones
//
//  Created by Connor Wybranowski on 5/31/15.
//  Copyright (c) 2015 Wybro. All rights reserved.
//

import UIKit

class eventViewController: UIViewController {
    
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventBio: UITextView!
    @IBOutlet weak var eventRequirements: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signUp(sender: AnyObject) {
        self.resignFirstResponder()
        
    }

}
