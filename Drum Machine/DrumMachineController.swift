//
//  DrumMachineController.swift
//  Drum Machine
//
//  Created by Nicholas Kraftor on 12/8/14.
//  Copyright (c) 2014 Enterprise Holdings Inc. All rights reserved.
//

import UIKit

class DrumMachineController: UIViewController {

    @IBAction func isClicked(sender: DrumMachineButton) {
        
        if sender.isActive == false {
            sender.setImage(UIImage(named: "led-on-15.png"), forState: UIControlState.Normal)
            sender.isActive = true
        } else {
            sender.setImage(UIImage(named: "led-off-15.png"), forState: UIControlState.Normal)
            sender.isActive = false
        }
        
    }
}
