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
    
    var metronome: MetronomeModel = MetronomeModel()
    var audioPlayer = AVAudioPlayer()
    
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
        println("test in controller")
        audioPlayer.play()
        
    }
    
    @IBAction func startButtonPressed(sender: UIButton) {
        self.metronome.startMetronome()
    }
}
