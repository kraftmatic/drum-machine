//
//  DrumMachineModel.swift
//  Drum Machine
//
//  Created by Nicholas Kraftor on 12/9/14.
//  Copyright (c) 2014 Enterprise Holdings Inc. All rights reserved.
//

import Foundation

class DrumMachineModel: NSObject {
    
    var delegate: DrumMachineDelegate?
    var machineDictionary: Dictionary<String, Bool>
    var timer: NSTimer
    var barNumber: Int = 1
    
    override init(){

        timer = NSTimer()
        
        machineDictionary = Dictionary()
        var cellName: String
        for row in 1...5 {
            for column in 1...16 {
                if column < 10 {
                    cellName = String(row) + "0" + String(column)
                } else {
                    cellName = String(row) + String(column)
                }
                machineDictionary.updateValue(false, forKey: cellName)
            }
        }
    }
    
    func updateDictionaryValue(valueName: String, valueBool: Bool){
        machineDictionary.updateValue(valueBool, forKey: valueName)
    }
    
    func startDrumMachine(bpm: Int) {
        var bpmDouble: Double = Double(bpm)
        var timing: NSTimeInterval = 60.0 / bpmDouble
        timer = NSTimer.scheduledTimerWithTimeInterval(timing, target: self, selector: Selector("fireTick"), userInfo: nil, repeats: true)
    }
    
    private func fireTick(){
        barNumber++
        if barNumber == 17 {
            barNumber = 1
        }
        
        for row in 1...5 {
            var cellBuilder = row * 100
            cellBuilder += barNumber
            if machineDictionary[String(cellBuilder)] == true {
                switch row {
                    case 1: delegate?.playSoundOne()
                    case 2: delegate?.playSoundTwo()
                    case 3: delegate?.playSoundThree()
                    case 4: delegate?.playSoundFour()
                    case 5: delegate?.playSoundFive()
                default: println("Uh oh...")
                }
            }
        }
        
    }

}
