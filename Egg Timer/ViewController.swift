//
//  ViewController.swift
//  Egg Timer
//
//  Created by Nishant Taneja on 29/08/20.
//  Copyright © 2020 Nishant Taneja. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    // IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    // Initialise
    var timer = Timer()
    var player: AVAudioPlayer?
    let eggTime = ["Soft": 3, "Medium": 4, "Hard": 7]
    var totalTime = 0
    var secondsPassed = 0
    
    // IBAction
    @IBAction func harnessSelected(_ sender: UIButton) {
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        totalTime = eggTime[hardness]!
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed)/Float(totalTime)
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            playSound()
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        do {
            player = try AVAudioPlayer(contentsOf: url!)
            player?.play()
        }
        catch {print(error)}
    }
}

