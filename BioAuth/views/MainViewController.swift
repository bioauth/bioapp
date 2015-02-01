//
//  MainViewController.swift
//  BioAuth
//
//  Created by Jack Cook on 1/31/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var nk: NymiKit!
    var token: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "http://138.51.205.14:3000/external/1/list")!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if let tokenList = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? NSArray {
                if let tokenData = tokenList[0] as? NSDictionary {
                    if let token = tokenData["token"] as? String {
                        self.token = self.hashToken(token)
                        nclCreateSigKeyPair(Common.sharedInstance().nymiHandle, NCL_SECP256K)
                    }
                }
            }
        }
    }
    
    func hashToken(token: String) -> String {
        let data = token.dataUsingEncoding(NSUTF8StringEncoding)!
        var digest = [UInt8](count: Int(CC_SHA1_DIGEST_LENGTH), repeatedValue: 0)
        CC_SHA1(data.bytes, CC_LONG(data.length), &digest)
        let output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
        for byte in digest {
            output.appendFormat("%02x", byte)
        }
        return output
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
