//
//  Common.swift
//  BioAuth
//
//  Created by Jack Cook on 1/31/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

import UIKit

let deviceSize = UIScreen.mainScreen().bounds

let nc = NSNotificationCenter.defaultCenter()
let BAPushNotification = "BAPushNotification"

var token: String!
var location: String!
var name: String!

func dataToString(data: NSData) -> String {
    return "\(data)".stringByReplacingOccurrencesOfString("<", withString: "").stringByReplacingOccurrencesOfString(">", withString: "").stringByReplacingOccurrencesOfString(" ", withString: "")
}

func sha512(string: String) -> String {
    let url = NSURL(string: "http://107.170.109.85:8080/\(string)")!
    let request = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "GET"
    
    let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)!
    let string = NSString(data: data, encoding: NSUTF8StringEncoding)!
    return string
}
