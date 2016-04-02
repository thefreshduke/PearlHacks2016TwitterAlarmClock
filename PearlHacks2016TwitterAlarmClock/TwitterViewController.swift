//
//  TwitterViewController.swift
//  PearlHacks2016TwitterAlarmClock
//
//  Created by Scotty Shaw on 4/2/16.
//  Copyright © 2016 ___sks6___. All rights reserved.
//

import UIKit
import TwitterKit

class TwitterViewController: UIViewController {
    
    var startTime = NSTimeInterval()
    
    var timer = NSTimer()
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        validateTimer()
        
        let logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                let alert = UIAlertController(title: "Logged In",
                    message: "User \(unwrappedSession.userName) has logged in",
                    preferredStyle: UIAlertControllerStyle.Alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                NSLog("Login error: %@", error!.localizedDescription);
            }
        }
        
        // TODO: Change where the log in button is positioned in your view
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
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
        button.titleLabel!.font =  UIFont(name: (button.titleLabel?.font?.fontName)!, size: 75.0 * CGFloat(sizeAdjustment))
        //        startButton.titleLabel!.textColor = UIColor(red: 0.0, green: 1, blue: 1, alpha: CGFloat(alphaAdjustment))
    }

}
