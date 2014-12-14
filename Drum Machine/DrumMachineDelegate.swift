//
//  DrumMachineDelegate.swift
//  Drum Machine
//
//  Created by Nicholas Kraftor on 12/9/14.
//  Copyright (c) 2014 Enterprise Holdings Inc. All rights reserved.
//

protocol DrumMachineDelegate {
    func updateBoard(Dictionary<String, Bool>)
    func playSoundOne()
    func playSoundTwo()
    func playSoundThree()
    func playSoundFour()
    func playSoundFive()
}
