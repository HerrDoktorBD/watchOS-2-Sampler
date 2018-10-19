//
//  AppDelegate.swift
//  watchOS2Sampler
//
//  Created by Shuichi Tsutsumi on 2015/06/10.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit
import WatchConnectivity
import HealthKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {

    var window: UIWindow?

    // MARK: App Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let settings = UIUserNotificationSettings(
            types: [.badge, .sound, .alert],
            categories: nil)
        UIApplication.shared.registerUserNotificationSettings(settings)

        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self // conform to WCSessionDelegate
            session.activate()
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func applicationShouldRequestHealthAuthorization(_ application: UIApplication) {
        let healthStore = HKHealthStore()
        guard HKHealthStore.isHealthDataAvailable() else {
            return
        }

        let dataTypes = Set([HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!])
        healthStore.requestAuthorization(toShare: nil, read: dataTypes, completion: { (result, error) -> Void in
        })
    }

    // =========================================================================
    // MARK: - WCSessionDelegate
    func sessionWatchStateDidChange(_ session: WCSession) {
        print(#function)
        print(session)
        print("reachable: \(session.isReachable)")
        print("isPaired: \(session.isPaired)")
        print("session.isWatchAppInstalled: \(session.isWatchAppInstalled)")
        print("watchDirectoryURL: \(String(describing: session.watchDirectoryURL))")
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print(#function)
        guard message["request"] as? String == "fireLocalNotification" else {return}

        let localNotification = UILocalNotification()
        localNotification.alertBody = "Message Received!"
        localNotification.fireDate = NSDate() as Date
        localNotification.soundName = UILocalNotificationDefaultSoundName;

        UIApplication.shared.scheduleLocalNotification(localNotification)
    }

    // we don’t care about these
    @available(iOS 9.3, *)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //<#code#>
    }

    func sessionDidBecomeInactive(_ session: WCSession) {
        //<#code#>
    }

    func sessionDidDeactivate(_ session: WCSession) {
        //<#code#>
    }
}
