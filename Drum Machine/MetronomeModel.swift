//
//  MetronomeModel.swift
//  Drum Machine
//
//  Created by Nicholas Kraftor on 12/6/14.
//  Copyright (c) 2014 Enterprise Holdings Inc. All rights reserved.
//

import Foundation

class MetronomeModel: NSObject {
    
    var delegate: MetronomeDelegate?
    var timer: NSTimer;
    
    override init() {
        self.timer = NSTimer();
        super.init()
    }

    func startMetronome(bpm: Int) {
        var bpmDouble: Double = Double(bpm)
        var timing: NSTimeInterval = 60.0 / bpmDouble
        timer = NSTimer.scheduledTimerWithTimeInterval(timing, target: self, selector: Selector("fireTick"), userInfo: nil, repeats: true)
    }
    
    func stopMetronome(){
        timer.invalidate()
    }
    
    func fireTick(){
        delegate?.metronomeTick()
    }
    
    
}
