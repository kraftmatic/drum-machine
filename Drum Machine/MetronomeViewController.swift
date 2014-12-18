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
    
    // MARK: Storyboard Outlets
    
    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var bpmSlider: UISlider!
    @IBOutlet weak var offsetSlider: UISlider!
    @IBOutlet weak var offsetLabel: UILabel!
    @IBOutlet weak var metronomeBackground: MetronomeBackground!
    
    // MARK: Control Variables
    
    var metronome: MetronomeModel = MetronomeModel()
    var audioPlayer = AVAudioPlayer()
    var metronomeStarted: Bool = false
    var bpmSetting: Double = 60.0
    var offsetSetting: Double = 0.0
    var bpmInt: Int = 60
    
    // MARK: Default Control Functions
    
    override init (){
        super.init()
    }

    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        metronome.delegate = self
        self.view.sendSubviewToBack(metronomeBackground)
    }

    // MARK: Delegate Functions
    
    func metronomeTick() {
        var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("tick",ofType: "mp3")!)
        var error:NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    // MARK: Control Functions For Sliding Controls
    
    @IBAction func bpmChanged(sender: AnyObject) {
        bpmSetting = Double(bpmSlider.value)
        bpmLabel.text = createBpmLabelText(bpmSetting)
    }
    
    func createBpmLabelText(bpmValue: Double) -> String {
        var bpmRound = round(bpmValue)
        bpmInt = Int(bpmRound)
        return String(bpmInt)
    }
    
    // The offset will control syncopation when sent with the bpm to the model
    @IBAction func offsetChanged(sender: AnyObject) {
        offsetSetting = Double(offsetSlider.value)
        var offsetText = String(format:"%f", offsetSetting)
        offsetText = offsetText.substringToIndex(advance(offsetText.startIndex, 4))
        offsetLabel.text = offsetText
    }
    
    // MARK: Control Functions For Buttons
    
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
