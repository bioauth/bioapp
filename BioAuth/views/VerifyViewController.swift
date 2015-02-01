//
//  VerifyViewController.swift
//  BioAuth
//
//  Created by Jack Cook on 1/31/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

import UIKit

class VerifyViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "http://138.51.205.14:3000/external/1/list")!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if let responseJSON = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? NSArray {
                if let tokenData = responseJSON[0] as? NSDictionary {
                    if let token = tokenData["token"] as? String {
                        let deviceToken = NSUserDefaults.standardUserDefaults().stringForKey("DeviceToken")!
                        tokensHash = sha512(sha512(deviceToken) + token)
                    }
                }
            }
        }
        println(hash)
    }
}
