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
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var moreInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.numberOfHoursTextField.alpha = 0.0
        self.doneButton.alpha = 0.0
        self.moreInfoLabel.alpha = 0.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            self.numberOfHoursTextField.alpha = 1.0
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.25, options: .CurveEaseOut, animations: { () -> Void in
            self.doneButton.alpha = 1.0
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.50, options: .CurveEaseOut, animations: { () -> Void in
            self.moreInfoLabel.alpha = 1.0
            }, completion: nil)
    }
    
    
    
    @IBAction func doneEnteringHours(sender: UIButton) {
        if numberOfHoursTextField.text.toInt() != nil {
            settingsMgr.setServiceHour(numberOfHoursTextField.text)
            maxAmount = numberOfHoursTextField.text.toInt()!
            println("Success")
        }
        else {
            println("Please enter a number")
        }
        
    }
    


}
