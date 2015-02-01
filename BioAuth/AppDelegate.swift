//
//  AppDelegate.swift
//  BioAuth
//
//  Created by Jack Cook on 1/30/15.
//  Copyright (c) 2015 Jack Cook. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: .Sound | .Alert | .Badge, categories: nil))
        
        return true
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        application.registerForRemoteNotifications()
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let token = dataToString(deviceToken)
        NSUserDefaults.standardUserDefaults().setObject(token, forKey: "DeviceToken")
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        application.applicationIconBadgeNumber = 0
        
        let url = NSURL(string: "http://138.51.205.14/external/1/list")!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if let responseJSON = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? NSArray {
                if let tokenData = responseJSON[0] as? NSDictionary {
                    if let t = tokenData["token"] as? String {
                        if let l = tokenData["location"] as? String {
                            if let n = tokenData["name"] as? String {
                                token = t
                                location = l
                                name = n
                                
                                NSNotificationCenter.defaultCenter().postNotificationName(BAPushNotification, object: nil)
                            }
                        }
                        //let deviceToken = NSUserDefaults.standardUserDefaults().stringForKey("DeviceToken")!
                        //println(sha512(deviceToken) + token)
                        //tokensHash = sha512(sha512(deviceToken) + token)
                        //println(tokensHash)
                    }
                }
            }
        }
    }
}
