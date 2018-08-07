//
//  AppDelegate.swift
//  ConfApp
//
//  Created by Marta Piątek on 01.06.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps
import TwitterKit
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
let googleApiKey = "AIzaSyA3FR4wr1WaAqQKLLeLnHHwDF7UKoYnM9E"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
    //    UINavigationBar.appearance().backgroundColor = .clear
     //   UINavigationBar.appearance().isTranslucent = true
        
         TWTRTwitter.sharedInstance().start(withConsumerKey: "REsQLbkKzVas8RKwK209VDsIG", consumerSecret: "QZE688CvafFo9y9y6FHYsDgiFnM4JgQnH1LqZPQeMYmoAjwUgm")
        
        FirebaseApp.configure()
         GMSServices.provideAPIKey(googleApiKey)
       GMSPlacesClient.provideAPIKey(googleApiKey)
    
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Skia", size: 20)!], for: UIControlState.normal)

        Database.database().isPersistenceEnabled = true
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

    func application(_ app: UIApplication, open url:URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
    }
}

