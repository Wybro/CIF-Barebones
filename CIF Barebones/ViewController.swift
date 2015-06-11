//
//  ViewController.swift
//  CIF Barebones
//
//  Created by Connor Wybranowski on 5/31/15.
//  Copyright (c) 2015 Wybro. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController!
    var pageTitles: NSArray!
    var pageDescriptions: NSArray!
    var pageImages: NSArray!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.pageTitles = NSArray(objects: "Welcome", "Location Settings", "Hours", "All Done!")
        self.pageImages = NSArray(objects: "Launch Icon", "Location Icon", "Clock Icon", "Done Icon")
        self.pageDescriptions = NSArray(objects: "Some congratulatory text about making the world a better place", "Your location is used to match you with nearby volunteer opportunities", "How many service hours do you need?", "That wasn't so bad!")
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("pageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        var startVC = self.viewControllerAtIndex(0) as pageContentViewController
        var viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as [AnyObject], direction: .Forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRectMake(0, 30, self.view.frame.width, self.view.frame.size.height - 60)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        
//        PFCloud.callFunctionInBackground("hello", withParameters: nil) {
//            (response: AnyObject?, error: NSError?) -> Void in
//            let responseString = response as? String
//            println(responseString)
//        }
        
    
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func viewControllerAtIndex(index: Int) -> pageContentViewController {
        if ((self.pageTitles.count == 0) || (index >= self.pageTitles.count)) {
            return pageContentViewController()
        }
        
        var vc: pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("pageContentViewController") as! pageContentViewController
        
        vc.imageFile = self.pageImages[index] as! String
        vc.titleText = self.pageTitles[index] as! String
        vc.pageDescription = self.pageDescriptions[index] as! String
        vc.pageIndex = index
        
        if (vc.titleText == "All Done!") {
            vc.endOfSequence = false
        }
        
        if (vc.titleText == "Hours") {
            vc.optionalHidden = false
        }
        
        if (vc.titleText == "Location Settings") {
            vc.locationSettingsHidden = false
        }
        
        if (vc.titleText == "Hours") {
            vc.serviceHoursSettingsHidden = false
        }
        
        return vc
    }
    
    
    // MARK: - Page View Controller Data Source
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var vc = viewController as! pageContentViewController
        var index = vc.pageIndex as Int
        
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        index--
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var vc = viewController as! pageContentViewController
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound) {
            return nil
        }
        
        index++
        
        if (index == self.pageTitles.count) {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageTitles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    

    
    

}

