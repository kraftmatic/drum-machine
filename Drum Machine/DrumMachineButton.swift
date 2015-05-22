//
//  DrumMachineButton.swift
//  Drum Machine
//
//  Created by Nicholas Kraftor on 12/8/14.
//  Copyright (c) 2014 Enterprise Holdings Inc. All rights reserved.
//

import UIKit

class DrumMachineButton: UIButton {
    
    var isActive: Bool

    required init(coder aDecoder: NSCoder) {
        isActive = false;
        super.init(coder: aDecoder)
    }


}
