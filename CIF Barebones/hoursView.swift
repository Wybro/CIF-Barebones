//
//  hoursView.swift
//  CIF Barebones
//
//  Created by Connor Wybranowski on 6/3/15.
//  Copyright (c) 2015 Wybro. All rights reserved.
//

import UIKit

let maxAmount = 100
let π: CGFloat = CGFloat(M_PI)

@IBDesignable class hoursView: UIView {
    
    @IBInspectable var counter: Int = 0 {
        didSet {
            if counter <= maxAmount {
                setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable var outlineColor: UIColor = UIColor.blueColor()
    @IBInspectable var counterColor: UIColor = UIColor.orangeColor()
    
    override func drawRect(rect: CGRect) {
        
        // draw the arc - changes based on hours
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = max(bounds.width, bounds.height)
        let arcWidth: CGFloat = 35
        
        let startAngle: CGFloat = 2 * π / 3
        let endAngle: CGFloat = π / 3
        
        let angleDifference = 2 * π - startAngle + endAngle
        let arcLengthPerHour = angleDifference / CGFloat(maxAmount)
        let dynamicStartAngle: CGFloat = 2 * π / 3
        let dynamicEndAngle = arcLengthPerHour * CGFloat(counter) + dynamicStartAngle
        
        var path = UIBezierPath(arcCenter: center, radius: radius/2 - arcWidth/2, startAngle: dynamicStartAngle, endAngle: dynamicEndAngle, clockwise: true)
        
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
        // draw the outline - stays constant
        var outlinePath = UIBezierPath(arcCenter: center, radius: bounds.width/2 - 2.5, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        outlinePath.addArcWithCenter(center, radius: bounds.width/2 - arcWidth + 2.5, startAngle: endAngle, endAngle: startAngle, clockwise: false)
        outlinePath.closePath()
        outlineColor.setStroke()
        outlinePath.lineWidth = 5.0
        outlinePath.stroke()
        
        
    }
    
}
