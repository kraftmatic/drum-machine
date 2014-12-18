//
//  MetronomeBackground.swift
//  Drum Machine
//
//  Created by Nicholas Kraftor on 12/17/14.
//  Copyright (c) 2014 Enterprise Holdings Inc. All rights reserved.
//

import UIKit

class MetronomeBackground: UIView {
    
    
    
    override func drawRect(rect: CGRect) {
        var currentContext = UIGraphicsGetCurrentContext()
        CGContextSaveGState(currentContext)
        var colorSpace = CGColorSpaceCreateDeviceRGB()
        
        var startColor = UIColor.blueColor()
        var startColorSemi = startColor.colorWithAlphaComponent(0.8)
        var startColorComponents = CGColorGetComponents(startColorSemi.CGColor)
        var endcolor = UIColor.cyanColor()
        var endColorSemi = endcolor.colorWithAlphaComponent(0.8)
        var endColorComponents = CGColorGetComponents(endColorSemi.CGColor)
        
        var colorComponents = [startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]]
        
        var locations: [CGFloat] = [0.0 , 1.0]
        
        var gradient = CGGradientCreateWithColorComponents(colorSpace, &colorComponents, &locations, 2)
        
        var startPoint = CGPointMake(self.bounds.width, 0)
        var endPoint = CGPointMake(self.bounds.width, self.bounds.height)
        
        CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0)
        CGContextRestoreGState(currentContext)
        
    }

}
