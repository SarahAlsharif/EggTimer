//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    // let eggTimer = ["Hard" : 720, "Medium" : 420, "Soft" : 300]
    let eggTimer = ["Hard  " : 7, "Medium" : 5, "Soft  " : 3]
    var totalTime : Float = 0
    var secondsPassed : Float = 0
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        let eggHardness = sender.currentTitle!
        // dictionary[key] returns optional / returns nil when the key doesn't exist
        label.text = eggHardness
        totalTime = Float(eggTimer[eggHardness]!)
        progressBar.progress = 0.0
        secondsPassed = 0.0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self , selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    // because selector is objective-c -> add @objc
    @objc func updateTimer (){
        if totalTime > secondsPassed {
            secondsPassed += 1
            let precentageProgress = secondsPassed / totalTime
            progressBar.progress = precentageProgress
        } else {
            timer.invalidate()
            label.text = "Done!"
            playSound()
        }
    }
    var player : AVAudioPlayer?
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else {print("**************"); return }
            
            player.play()

        } catch let error {
            print("erroooooor : ",error.localizedDescription)
        }
    }
    
}
