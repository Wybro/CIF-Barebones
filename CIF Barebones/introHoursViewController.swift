//
//  introHoursViewController.swift
//  CIF Barebones
//
//  Created by Connor Wybranowski on 6/6/15.
//  Copyright (c) 2015 Wybro. All rights reserved.
//

import UIKit

class introHoursViewController: UIViewController {
    
    @IBOutlet weak var numberOfHoursTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func doneEnteringHours(sender: UIButton) {
        if numberOfHoursTextField.text.toInt() != nil {
            println("Success")
        }
        else {
            println("Please enter a number")
        }
        
    }
    


}
