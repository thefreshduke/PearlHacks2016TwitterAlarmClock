//
//  ViewController.swift
//  PearlHacks2016TwitterAlarmClock
//
//  Created by Scotty Shaw on 4/2/16.
//  Copyright © 2016 ___sks6___. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isLoggedIn: Bool = false
    
    @IBOutlet weak var startButton: UIButton!

    @IBAction func goToNextView(sender: AnyObject) {
        if (isLoggedIn) {
            self.performSegueWithIdentifier("LoggedInSegue", sender: self)
        }
        else {
            self.performSegueWithIdentifier("NotLoggedInSegue", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

