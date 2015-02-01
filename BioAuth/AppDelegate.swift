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
        let deviceTokenString = deviceToken.description.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "<>")).stringByReplacingOccurrencesOfString(" ", withString: "")
        println(deviceTokenString)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        application.applicationIconBadgeNumber = 0
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vvc = storyboard.instantiateViewControllerWithIdentifier("VerifyViewController") as VerifyViewController
        
        (self.window?.rootViewController as UINavigationController).visibleViewController.presentViewController(vvc, animated: true, completion: nil)
    }
}
