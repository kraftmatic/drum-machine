//
//  DrumMachineController.swift
//  Drum Machine
//
//  Created by Nicholas Kraftor on 12/8/14.
//  Copyright (c) 2014 Enterprise Holdings Inc. All rights reserved.
//

import UIKit
import AVFoundation

class DrumMachineController: UIViewController, DrumMachineDelegate {
    
    var drumMachine: DrumMachineModel = DrumMachineModel()
    var machineRunning: Bool = false;
    
    @IBOutlet weak var bpmSlider: UISlider!
    @IBOutlet weak var offsetSlider: UISlider!
    
    @IBOutlet weak var offsetLabel: UILabel!
    @IBOutlet weak var bpmLabel: UILabel!
    
    // MARK: Control Variables
    
    var bpmSetting: Double = 120.0
    var offsetSetting: Double = 0.0
    var bpmInt: Int = 120
    
    // MARK: Audio Players For Each Channel
    
    // I had to create a separate player for each channel as at faster BPMs the player wouldn't unqueue fast enough for the next sound
    var hihatPlayer = AVAudioPlayer()
    var kickPlayer = AVAudioPlayer()
    var snarePlayer = AVAudioPlayer()
    var tomPlayer = AVAudioPlayer()
    var sticksPlayer = AVAudioPlayer()
    
    // MARK: Default Control Functions
    
    override func viewDidLoad() {
        drumMachine.delegate = self
        self.drawDrumButtonFrame()
        self.drawMemoryBankFrame()
    }
    
    // MARK: Model Control Functions

    @IBAction func startButtonClicked(sender: AnyObject) {
        if !machineRunning{
            drumMachine.startDrumMachine(bpmInt, offset: offsetSetting)
            machineRunning = true;
        } else{
            drumMachine.stopDrumMachine()
            machineRunning = false;
        }
    }
    
    // MARK: Button Controls
    
    @IBAction func isClicked(sender: DrumMachineButton) {
        if sender.isActive == false {
            sender.setImage(UIImage(named: "led-on-15.png"), forState: UIControlState.Normal)
            drumMachine.updateDictionaryValue(String(sender.tag), valueBool: true)
            sender.isActive = true
        } else {
            sender.setImage(UIImage(named: "led-off-15.png"), forState: UIControlState.Normal)
            drumMachine.updateDictionaryValue(String(sender.tag), valueBool: false)
            sender.isActive = false
        }
    }
    
    // Slider Controls
    
    @IBAction func bpmChanged(sender: UISlider) {
        bpmSetting = Double(bpmSlider.value)
        bpmLabel.text = createBpmLabelText(bpmSetting)
    }
    
    func createBpmLabelText(bpmValue: Double) -> String {
        var bpmRound = round(bpmValue)
        bpmInt = Int(bpmRound)
        return String(bpmInt)
    }
    
    @IBAction func offsetChanged(sender: UISlider) {
        offsetSetting = Double(offsetSlider.value)
        var offsetText = String(format:"%f", offsetSetting)
        offsetText = offsetText.substringToIndex(advance(offsetText.startIndex, 4))
        offsetLabel.text = offsetText
    }
    
    // MARK: Delegate Functions
    
    func playSoundOne() {
        var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("hihat",ofType: "mp3")!)
        var error:NSError?
        hihatPlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
        hihatPlayer.prepareToPlay()
        hihatPlayer.play()
    }
    
    func playSoundTwo() {
        var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("tom",ofType: "wav")!)
        var error:NSError?
        tomPlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
        tomPlayer.prepareToPlay()
        tomPlayer.play()
    }
    
    func playSoundThree() {
        var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("snare",ofType: "wav")!)
        var error:NSError?
        snarePlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
        snarePlayer.prepareToPlay()
        snarePlayer.play()
    }
    
    func playSoundFour() {
        var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("kick",ofType: "wav")!)
        var error:NSError?
        kickPlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
        kickPlayer.prepareToPlay()
        kickPlayer.play()
    }
    
    func playSoundFive() {
        var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sticks",ofType: "wav")!)
        var error:NSError?
        sticksPlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
        sticksPlayer.prepareToPlay()
        sticksPlayer.play()
    }
    
    // This sets the board layout to whatever bank was selected
    func updateBoard(machineDictionary: Dictionary<String, Bool>) {
        
        for (buttonTag, buttonStatus) in machineDictionary {
            var buttonTagInt: Int = buttonTag.toInt()!
            var tempButton: DrumMachineButton = self.view.viewWithTag(buttonTagInt) as! DrumMachineButton
            if buttonStatus == true {
                tempButton.setImage(UIImage(named: "led-on-15.png"), forState: UIControlState.Normal)
                tempButton.isActive = true
            } else {
                tempButton.setImage(UIImage(named: "led-off-15.png"), forState: UIControlState.Normal)
                tempButton.isActive = false
            }
        }
    }
    
    // MARK: Save and Load Buttons
    
    @IBAction func bankOneSave(sender: UIButton) {
        drumMachine.persistDrumPatternInSlot(1)
    }
    
    @IBAction func bankOneLoad(sender: UIButton) {
        drumMachine.loadDrumPatternFromSlot(1)
    }
    
    @IBAction func bankTwoSave(sender: UIButton) {
        drumMachine.persistDrumPatternInSlot(2)
    }
    
    @IBAction func bankTwoLoad(sender: UIButton) {
        drumMachine.loadDrumPatternFromSlot(2)
    }
    
    @IBAction func bankThreeSave(sender: UIButton) {
        drumMachine.persistDrumPatternInSlot(3)
    }
    
    @IBAction func bankThreeLoad(sender: UIButton) {
        drumMachine.loadDrumPatternFromSlot(3)
    }
    
    // MARK: Core Graphics Frame Drawing
    
    func drawDrumButtonFrame() {
        
        var bezier:CAShapeLayer = CAShapeLayer()
        
        bezier.path = buttonBezierPath().CGPath
        bezier.strokeColor = UIColor.blackColor().CGColor
        bezier.fillColor = UIColor(white: 0.8, alpha: 0.85).CGColor
        bezier.lineWidth = 1.5
        bezier.strokeStart = 0.0
        bezier.strokeEnd = 1.0
        
        self.view.layer.insertSublayer(bezier, atIndex: 0)
        
    }
    
    func buttonBezierPath() -> UIBezierPath {
        
        var path = UIBezierPath()
        
        path.moveToPoint(CGPointMake(90, 10))
        path.addLineToPoint(CGPointMake(90, 170))
        path.addLineToPoint(CGPointMake(520, 170))
        path.addLineToPoint(CGPointMake(520, 10))
        path.addLineToPoint(CGPointMake(90, 10))
        
        return path;
    }
    
    func drawMemoryBankFrame() {
        
        var bezier:CAShapeLayer = CAShapeLayer()
        
        bezier.path          = bankBezierPath().CGPath
        bezier.strokeColor   = UIColor.blackColor().CGColor
        bezier.fillColor     = UIColor(white: 0.8, alpha: 0.85).CGColor
        bezier.lineWidth     = 1.5
        bezier.strokeStart   = 0.0
        bezier.strokeEnd     = 1.0
        
        self.view.layer.insertSublayer(bezier, atIndex: 0)
        
    }
    
    func bankBezierPath() -> UIBezierPath {
        
        var path = UIBezierPath()
        
        path.moveToPoint(CGPointMake(365, 190))
        path.addLineToPoint(CGPointMake(365, 300))
        path.addLineToPoint(CGPointMake(520, 300))
        path.addLineToPoint(CGPointMake(520, 190))
        path.addLineToPoint(CGPointMake(365, 190))
        
        return path;
    }
    
}
