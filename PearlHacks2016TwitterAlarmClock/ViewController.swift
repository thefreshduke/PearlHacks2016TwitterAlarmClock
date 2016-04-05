//
//  ViewController.swift
//  PearlHacks2016TwitterAlarmClock
//
//  Created by Scotty Shaw on 4/2/16.
//  Copyright © 2016 ___sks6___. All rights reserved.
//

import UIKit
import AVFoundation
import TwitterKit

class ViewController: UIViewController {
    
    var wavesAudioPlayer: AVAudioPlayer?
    
    var startTime = NSTimeInterval()
    
    var timer = NSTimer()
    
    var isLoggedIn: Bool = false
    
    var userSettings = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func goToNextView(sender: AnyObject) {
        Twitter.sharedInstance().logInWithCompletion { (session, error) in
            if let _ = session {
                self.performSegueWithIdentifier("LoggedInSegue", sender: self)
            }
            else {
                NSLog("Login error: %@", error!.localizedDescription);
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        validateTimer()
        
        if let waves = self.setupAudioPlayerWithFile("waves", type:"mp3") {
            self.wavesAudioPlayer = waves
        }
        
        wavesAudioPlayer?.numberOfLoops = -1
        wavesAudioPlayer?.volume = 0.1
        wavesAudioPlayer?.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func validateTimer() {
        let repeatingFunction: Selector = "pulseButton"
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: repeatingFunction, userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate()
    }
    
    func pulseButton() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        // calculate elapsed time
        let elapsedTime = currentTime - startTime
        let sizeOffset = elapsedTime % 10.0
        var sizeAdjustment: Double = 0.0
        //        var alphaAdjustment: Double = 0.0
        if (sizeOffset < 5) {
            sizeAdjustment = (80.0 + 4 * sizeOffset) / 100.0
            //            alphaAdjustment = (80.0 + 4 * sizeOffset) / 100.0
        }
        else {
            sizeAdjustment = (120.0 - 4 * sizeOffset) / 100.0
            //            alphaAdjustment = (120.0 - 4 * sizeOffset) / 100.0
        }
        startButton.titleLabel!.font =  UIFont(name: (startButton.titleLabel?.font?.fontName)!, size: 75.0 * CGFloat(sizeAdjustment))
        //        startButton.titleLabel!.textColor = UIColor(red: 0.0, green: 1, blue: 1, alpha: CGFloat(alphaAdjustment))
    }
    
    func setupAudioPlayerWithFile(file: NSString, type: NSString) -> AVAudioPlayer?  {
        
        // 1
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        let url = NSURL.fileURLWithPath(path!)
        
        // 2
        var audioPlayer: AVAudioPlayer?
        
        // 3
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
        }
        catch {
            print("Player not available")
        }
        
        // 4
        return audioPlayer
    }
}

