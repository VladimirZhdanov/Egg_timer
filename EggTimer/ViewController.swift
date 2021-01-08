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
    
    private var myTimer: Timer?
    private var feedBackSound = AVAudioPlayer()
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var progressView: MyProgressView!
    
    private let eggTimes = [
        "Soft": 5 * 1,
        "Medium": 8 * 60,
        "Hard": 12 * 60
    ]
    
    @IBAction func eggButtonPressed(_ sender: UIButton) {
        guard let hardness = sender.currentTitle else { return }
        
        titleView.text = "In process..."
        startTimer(time: eggTimes[hardness] ?? 0)
    }
    
    private func startTimer(time: Int) {
        
        stopTimer(timer: myTimer)
        
        var timeLeft = time
        
        if timeLeft > 0 {
            
            myTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                
                if timeLeft == 0 {
                    self.titleView.text = "Done!"
                    self.progressView.setProgress(1.0, animated: true)
                    self.playSound(named: "alarm_sound", type: "mp3")
                    timer.invalidate()
                } else {
                    print("\(timeLeft) seconds.")
                    let currentTime = Float(time - timeLeft) / Float(time)
                    self.progressView.setProgress(currentTime, animated: true)
                }
                timeLeft -= 1
            }
        }
    }
    
    private func stopTimer(timer: Timer?) {
        timer?.invalidate()
    }
    
    private func playSound(named: String, type: String) {
        guard let path = Bundle.main.path(forResource: named, ofType: type) else { return }
        let url = URL(fileURLWithPath: path)
        do {
            self.feedBackSound = try AVAudioPlayer(contentsOf: url)
            feedBackSound.prepareToPlay()
            feedBackSound.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    deinit {
        stopTimer(timer: myTimer)
    }
}
