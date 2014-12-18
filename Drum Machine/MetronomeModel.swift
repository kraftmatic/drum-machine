//
//  MetronomeModel.swift
//  Drum Machine
//
//  Created by Nicholas Kraftor on 12/6/14.
//  Copyright (c) 2014 Enterprise Holdings Inc. All rights reserved.
//

import Foundation

class MetronomeModel: NSObject {
    
    // MARK: Model Variables
    
    var delegate: MetronomeDelegate?
    var timer: NSTimer;
    var beatOffset: Double = 0.0
    var bpmDouble: Double = 0.0
    
    override init() {
        timer = NSTimer();
        super.init()
    }
    
    // MARK: Public Controls

    func startMetronome(bpm: Int, offset: Double) {
        beatOffset = offset
        bpmDouble = Double(bpm)
        var timing: NSTimeInterval = 120.0 / bpmDouble
        timer = NSTimer.scheduledTimerWithTimeInterval(timing, target: self, selector: Selector("fireTick"), userInfo: nil, repeats: true)
    }
    
    func stopMetronome(){
        timer.invalidate()
    }
    
    // MARK: Selector Functions
    
    func fireTick(){
        delegate?.metronomeTick()
        
        // Second one-time firing timer to help play an offset beat
        
        var offsetTiming: NSTimeInterval = ((120 / bpmDouble) / 2) + (((120.0 / bpmDouble) / 2) * beatOffset)
        var offsetTimer = NSTimer.scheduledTimerWithTimeInterval(offsetTiming, target: self, selector: Selector("fireOffsetTick"), userInfo: nil, repeats: false)
    }
    
    func fireOffsetTick(){
        delegate?.metronomeTick()
    }
    
    
}
