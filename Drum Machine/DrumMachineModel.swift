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
    var barNumber: Int = 0
    var beatOffset: Double = 0.0
    var bpmDouble: Double = 0.0
    
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
    
    // MARK: Public Functions
    
    // Updates the boolean in our dictionary to determine whether or not the note is played
    func updateDictionaryValue(valueName: String, valueBool: Bool){
        machineDictionary.updateValue(valueBool, forKey: valueName)
    }
    
    func startDrumMachine(bpm: Int, offset: Double) {
        beatOffset = offset
        bpmDouble = Double(bpm)
        var timing: NSTimeInterval = 120 / bpmDouble
        barNumber = 0
        timer = NSTimer.scheduledTimerWithTimeInterval(timing, target: self, selector: Selector("fireTick"), userInfo: nil, repeats: true)
    }
    
    func stopDrumMachine(){
        timer.invalidate()
    }
    
    // MARK: Selector Functions
    
    func fireTick(){
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
        
        // The second timer is a one-time fire that helps us do an offset beat for that fun syncopation effect
        
        var offsetTiming: NSTimeInterval = ((120 / bpmDouble) / 2) + (((120.0 / bpmDouble) / 2) * beatOffset)
        var offsetTimer = NSTimer.scheduledTimerWithTimeInterval(offsetTiming, target: self, selector: Selector("fireOffsetTick"), userInfo: nil, repeats: false)
    }
    
    func fireOffsetTick(){
        
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
    
    // MARK: Storage and Retrieval of Drum Patterns
    
    func persistDrumPatternInSlot(slotNumber: Int){
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let bankLabel = "bank" + String(slotNumber)

        var data = NSKeyedArchiver.archivedDataWithRootObject(machineDictionary)
        userDefaults.setObject(data, forKey: bankLabel)
        
    }
    
    func loadDrumPatternFromSlot(slotNumber: Int){
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let bankLabel = "bank" + String(slotNumber)
        
        if (userDefaults.objectForKey(bankLabel) != nil){
            var dictionaryData = NSUserDefaults.standardUserDefaults().objectForKey(bankLabel) as! NSData
            machineDictionary = NSKeyedUnarchiver.unarchiveObjectWithData(dictionaryData) as! [String : Bool]
        
            delegate?.updateBoard(machineDictionary)
        }
    }

}
