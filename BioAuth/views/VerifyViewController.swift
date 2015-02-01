//
//  VerifyViewController.swift
//  BioAuth
//
//  Created by Jack Cook on 1/31/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

import UIKit

class VerifyViewController: UIViewController {
    
    @IBOutlet var siteLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    @IBOutlet var noButton: UIButton!
    @IBOutlet var yesButton: UIButton!
    
    var hud: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(gradientStyle: .TopToBottom, withFrame: self.view.frame, andColors: [UIColor.flatLimeColorDark(), UIColor.flatLimeColor()])
        
        noButton.setBackgroundImage(UIImage(named: "white.png"), forState: .Normal)
        noButton.setBackgroundImage(UIImage(named: "gray.png"), forState: .Highlighted)
        yesButton.setBackgroundImage(UIImage(named: "white.png"), forState: .Normal)
        yesButton.setBackgroundImage(UIImage(named: "gray.png"), forState: .Highlighted)
        
        noButton.layer.cornerRadius = 8
        noButton.clipsToBounds = true
        yesButton.layer.cornerRadius = 8
        yesButton.clipsToBounds = true
        
        noButton.setTitleColor(UIColor(red: 0.56, green: 0.7, blue: 0.11, alpha: 1), forState: .Normal)
        noButton.titleLabel?.font = UIFont(name: "Avenir-Roman", size: 28)
        yesButton.setTitleColor(UIColor(red: 0.56, green: 0.7, blue: 0.11, alpha: 1), forState: .Normal)
        yesButton.titleLabel?.font = UIFont(name: "Avenir-Roman", size: 28)
        
        let url = NSURL(string: "http://138.51.205.14/external/1/list")!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        self.siteLabel.text = self.siteLabel.text?.stringByReplacingOccurrencesOfString("%site%", withString: name)
        self.locationLabel.text = self.locationLabel.text?.stringByReplacingOccurrencesOfString("%location%", withString: location)
    }
    
    @IBAction func noButtonPressed(sender: AnyObject) {
        verifySignature(false)
        
        hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = MBProgressHUDModeText
        hud.labelText = "Sign-in Prevented"
        hud.show(true)
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "finish", userInfo: nil, repeats: false)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    @IBAction func yesButtonPressed(sender: AnyObject) {
        verifySignature(true)
        
        hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = MBProgressHUDModeText
        hud.labelText = "Sign-in Authorized"
        hud.show(true)
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "finish", userInfo: nil, repeats: false)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    func verifySignature(yes: Bool) {
        let url = NSURL(string: "http://138.51.205.14/external/verify")!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        
        println(token)
        
        let deviceToken = NSUserDefaults.standardUserDefaults().stringForKey("DeviceToken")!
        let hashed = sha512(sha512(deviceToken) + token)
        println(hashed)
        let requestBody = ["token": token, "hashed": hashed]
        
        if yes {
            let postString = "token=\(token)&hashed=\(hashed)"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        }
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            
        }
    }
    
    func finish() {
        hud.hide(true)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
