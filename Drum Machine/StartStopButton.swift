//
//  StartStopButton.swift
//  Drum Machine
//
//  Created by Nicholas Kraftor on 12/17/14.
//  Copyright (c) 2014 Enterprise Holdings Inc. All rights reserved.
//

import UIKit

class StartStopButton: UIButton {
    
    var hue: CGFloat = 0.5;
    var saturation: CGFloat = 0.5;
    var brightness: CGFloat = 0.5;
    
    override func drawRect(rect: CGRect) {
        var context: CGContextRef = UIGraphicsGetCurrentContext()
        var color: UIColor = UIColor.blueColor();
        CGContextSetFillColor(context, color.CIColor)
        
    }

}
