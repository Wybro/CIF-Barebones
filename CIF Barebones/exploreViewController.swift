//
//  exploreViewController.swift
//  CIF Barebones
//
//  Created by Connor Wybranowski on 5/31/15.
//  Copyright (c) 2015 Wybro. All rights reserved.
//

import UIKit

class exploreViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var eventsList: UITableView!
    var eventData: NSMutableArray! = NSMutableArray()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
      
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventData.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! eventTableViewCell
        cell.titleOfEvent.text = (eventData[indexPath.row] as! Event).getTitle()
        cell.locationOfEvent.text = (eventData[indexPath.row] as! Event).getLocation()
        return cell
    }

    
    
}
