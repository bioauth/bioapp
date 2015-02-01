//
//  MainViewController.swift
//  BioAuth
//
//  Created by Jack Cook on 1/31/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receivedPushNotification:", name: BAPushNotification, object: nil)
    }
    
    func receivedPushNotification(notification: NSNotification) {
        self.performSegueWithIdentifier("verifySegue", sender: self)
    }
}
