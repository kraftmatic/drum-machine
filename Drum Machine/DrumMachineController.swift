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
    var hihatPlayer = AVAudioPlayer()
    var kickPlayer = AVAudioPlayer()
    var snarePlayer = AVAudioPlayer()
    var tomPlayer = AVAudioPlayer()
    var sticksPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        drumMachine.delegate = self
    }

    @IBAction func startButtonClicked(sender: AnyObject) {
        drumMachine.startDrumMachine(120)
    }
    
    
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
    
}
