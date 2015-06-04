//
//  myAccountViewController.swift
//  CIF Barebones
//
//  Created by Connor Wybranowski on 6/3/15.
//  Copyright (c) 2015 Wybro. All rights reserved.
//

import UIKit

class myAccountViewController: UIViewController {
    
    @IBOutlet weak var hoursVisual: hoursView!
    @IBOutlet weak var hoursLabel: UILabel!

    @IBAction func increment(sender: UIButton) {
//        UIView.animateWithDuration(1, delay: 0, options: .CurveLinear, animations: {
//            self.hoursVisual.counter++
//            }, completion: nil)
        if hoursVisual.counter < maxAmount {
            hoursVisual.counter++
            hoursLabel.text = String(hoursVisual.counter)
        }
    }

    @IBAction func decrement(sender: UIButton) {
//        UIView.animateWithDuration(1, delay: 0, options: .CurveLinear, animations: {
//            self.hoursVisual.counter--
//            }, completion: nil)
        if hoursVisual.counter > 0 {
            hoursVisual.counter--
            hoursLabel.text = String(hoursVisual.counter)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hoursLabel.text = String(hoursVisual.counter)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}