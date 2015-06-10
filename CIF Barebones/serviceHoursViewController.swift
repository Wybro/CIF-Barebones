//
//  serviceHoursViewController.swift
//  CIF Barebones
//
//  Created by Connor Wybranowski on 6/9/15.
//  Copyright (c) 2015 Wybro. All rights reserved.
//

import UIKit

class serviceHoursViewController: UIViewController {
    
    @IBOutlet weak var numberOfHoursTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var successCheckImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.numberOfHoursTextField.alpha = 0.0
        self.doneButton.alpha = 0.0
        self.successCheckImageView.alpha = 0.0
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
        
    }
    
    
    
    @IBAction func doneEnteringHours(sender: UIButton) {
        if numberOfHoursTextField.text.toInt() != nil {
            settingsMgr.setServiceHour(numberOfHoursTextField.text)
            
            self.numberOfHoursTextField.text = ""
            
            self.successCheckImageView.image = UIImage(named: "Success Circle Check Icon")
            iconFade()
            println("Success")
        }
        else {
            self.successCheckImageView.image = UIImage(named: "Error Circle Icon")
            iconFade()
            println("Please enter a number")
        }
        
    }
    
    func iconFade() {
        self.successCheckImageView.alpha = 1.0
        UIView.animateWithDuration(1.25, animations: { () -> Void in
            self.successCheckImageView.alpha = 0.0
        })
    }


}
