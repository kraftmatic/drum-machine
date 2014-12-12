//
//  MetronomeViewController.swift
//  Drum Machine
//
//  Created by Nicholas Kraftor on 12/6/14.
//  Copyright (c) 2014 Enterprise Holdings Inc. All rights reserved.
//

import UIKit
import AVFoundation


class MetronomeViewController: UIViewController, MetronomeDelegate {
    
    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var bpmSlider: UISlider!
    @IBOutlet weak var offsetSlider: UISlider!
    @IBOutlet weak var offsetLabel: UILabel!
    
    var metronome: MetronomeModel = MetronomeModel()
    var audioPlayer = AVAudioPlayer()
    var metronomeStarted: Bool = false
    var bpmSetting: Double = 60.0
    var offsetSetting: Double = 0.0
    var bpmInt: Int = 60
    
    override init (){
        super.init()
    }

    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        metronome.delegate = self
    }

    func metronomeTick() {
        var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("tick",ofType: "mp3")!)
        var error:NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    @IBAction func bpmChanged(sender: AnyObject) {
        bpmSetting = Double(bpmSlider.value)
        bpmLabel.text = createBpmLabelText(bpmSetting)
    }
    
    func createBpmLabelText(bpmValue: Double) -> String {
        var bpmRound = round(bpmValue)
        bpmInt = Int(bpmRound)
        return String(bpmInt)
    }
    
    @IBAction func offsetChanged(sender: AnyObject) {
        offsetSetting = Double(offsetSlider.value)
        var offsetText = String(format:"%f", offsetSetting)
        offsetText = offsetText.substringToIndex(advance(offsetText.startIndex, 4))
        offsetLabel.text = offsetText
    }
    
    
    @IBAction func startButtonPressed(sender: UIButton) {
        if metronomeStarted == false {
            metronome.startMetronome(bpmInt, offset: offsetSetting)
            startButton.setTitle("Stop", forState: UIControlState.Normal)
            metronomeStarted = true
            
        } else {
            
            metronome.stopMetronome()
            startButton.setTitle("Start", forState: UIControlState.Normal)
            metronomeStarted = false
            
        }
    }
    
}
