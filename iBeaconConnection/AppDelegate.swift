//
//  AppDelegate.swift
//  iBeaconConnection
//
//  Created by TOTO on 5/1/19.
//  Copyright © 2019 TOTO. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, CLLocationManagerDelegate {

    var window: UIWindow?

    var view: BeaconTableViewController?

    let locationMgr = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        rangeBeacons()
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print(region.identifier)
        pushNotification(str: "enter")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print(region.identifier)
        pushNotification(str: "exit")
    }
    
    func rangeBeacons(){

        let id = "BeaconRegiontest"
        //        let region = CLBeaconRegion(proximityUUID: uuid, major: major, identifier: id)
        let region = CLBeaconRegion(proximityUUID: Constant.uuid, major: Constant.major, minor: Constant.minor, identifier: id)
        locationMgr.startRangingBeacons(in: region)
        locationMgr.startMonitoring(for: region)
        
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        locationMgr.requestAlwaysAuthorization()
        UNUserNotificationCenter.current().delegate = self

        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {_,_ in })
        

        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func pushNotification(str: String){
        let content = UNMutableNotificationContent()
        content.title = str
        content.launchImageName = "faceless"
        content.body = " I am body"
        content.sound = UNNotificationSound.default
        
        let request3 = UNNotificationRequest(identifier: "notId2", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request3, withCompletionHandler: nil)
        
    }

}

