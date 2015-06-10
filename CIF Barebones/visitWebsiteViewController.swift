//
//  visitWebsiteViewController.swift
//  CIF Barebones
//
//  Created by Connor Wybranowski on 6/9/15.
//  Copyright (c) 2015 Wybro. All rights reserved.
//

import UIKit

class visitWebsiteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openURL(sender: UIButton) {
        let urlString = NSURL(string: "http://www.volunteermatch.org")!
        UIApplication.sharedApplication().openURL(urlString)
    }

}
