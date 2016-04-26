//
//  AppDelegate.swift
//  DynamicLayout
//
//  Created by Thomas Torp on 21/04/16.
//  Copyright © 2016 Schibsted. All rights reserved.
//

import UIKit
import Spots

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        // Set the cache size to start caching images.
        let cacheSizeMemory = 500*1024*1024; // 500 MB
        let cacheSizeDisk = 500*1024*1024; // 500 MB
        let sharedCache = NSURLCache(memoryCapacity: cacheSizeMemory, diskCapacity: cacheSizeDisk, diskPath: "cache")
        NSURLCache.setSharedURLCache(sharedCache)

        Grid.views["Image"] = Image.self
        Grid.views["Text"] = Text.self
        Grid.views["VCard"] = VCard.self
        Grid.views["HCard"] = HCard.self

        Horizontal.views["Image"] = Image.self
        Horizontal.views["Text"] = Text.self
        Horizontal.views["HCard"] = HCard.self
        Horizontal.views["VCard"] = VCard.self

        SpotFactory.register("Grid", spot: Grid.self)
        SpotFactory.register("Horizontal", spot: Horizontal.self)

        SpotsController.configure = {
            $0.backgroundColor = UIColor.whiteColor()
        }

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

