//
//  VerifyViewController.swift
//  BioAuth
//
//  Created by Jack Cook on 1/31/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

import UIKit

class VerifyViewController: UIViewController {
    
    var nk: NymiKit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "http://138.51.205.14:3000/external/1/list")!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if let tokenList = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? NSArray {
                if let tokenData = tokenList[0] as? NSDictionary {
                    if let token = tokenData["token"] as? String {
                        println(token)
                    }
                }
            }
        }
    }
    
    @IBAction func connectButton(sender: AnyObject) {
        nk = NymiKit()
    }
    
    @IBAction func verifyButton(sender: AnyObject) {
        nk.setEventTypeToWaitFor(NCL_EVENT_FIND)
        nk.findNymiBand()
        nk.waitNclForEvent()
    }
    
    @IBAction func signButton(sender: AnyObject) {
        nclCreateSigKeyPair(Common.sharedInstance().nymiHandle, NCL_SECP256K)
    }
}
