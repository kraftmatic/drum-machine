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
    @IBOutlet weak var bpmField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    
    
    var metronome: MetronomeModel = MetronomeModel()
    var audioPlayer = AVAudioPlayer()
    var metronomeStarted: Bool = false;
    
    override init (){
        super.init()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        metronome.delegate = self
        var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("tick",ofType: "mp3")!)
        var error:NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
        audioPlayer.prepareToPlay()

    }

    func metronomeTick() {
        audioPlayer.play()
        
    }
    
    @IBAction func startButtonPressed(sender: UIButton) {
        if metronomeStarted == false {
            
            var bpm = self.bpmField.text.toInt()
            bpmLabel.text = self.bpmField.text + " BPM"
            metronome.startMetronome(bpm!)
            startButton.setTitle("Stop", forState: UIControlState.Normal)
            metronomeStarted = true
            
        } else {
            
            metronome.stopMetronome()
            startButton.setTitle("Start", forState: UIControlState.Normal)
            bpmLabel.text = "Stopped"
            metronomeStarted = false
            
        }
    }
}
