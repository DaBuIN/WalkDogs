//
//  AppDelegate.swift
//  WorkDogs
//
//  Created by Seven Tsai on 2017/7/6.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit

//GPS import CoreLocation
import CoreLocation
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var account:String?
    var passwd:String?
    var id:String?
    var mastername:String?
    var sentToDetailId:String?
    
    //GPS CL...Manager
    let lmgr = CLLocationManager()
    
    
    func cleanVar(){
        account = nil
        passwd = nil
        id = nil
        mastername = nil
        sentToDetailId = nil
        print(type(of: account))
        
    
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        window = UIWindow(frame: UIScreen.main.bounds)
//        
////        window?.backgroundColor 
//        
////        
//        let navigationBar = UINavigationController(rootViewController: ViewController())
//
//        
//        
//        
//        window?.rootViewController = navigationBar
////
//        window?.makeKeyAndVisible()
    
        
        
        
        
        //ＧＰＳ有關。先跳出詢問是否同意取得坐標授權
        
        
        lmgr.requestWhenInUseAuthorization()
        
        
        
        
        
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


}

