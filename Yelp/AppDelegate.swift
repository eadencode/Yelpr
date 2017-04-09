//
//  AppDelegate.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        splashScreen()
        sleep(UInt32(0.3))
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
    
    
    func splashScreen() {
   
        let splashImageView = UIImageView(frame: CGRect(x: 50, y: 50, width: 320, height: 480))
        splashImageView.image = #imageLiteral(resourceName: "Default")
        
        window?.addSubview(splashImageView)
        window?.bringSubview(toFront: splashImageView)
        //2. set an anchor point on the image view so it opens from the left
        splashImageView.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        //reset the image view frame
        splashImageView.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
        
        //3. animate the open
        UIView.animate(withDuration: 3, delay: 0.6, options: .curveEaseOut, animations: {
            splashImageView.layer.transform = CATransform3DRotate(CATransform3DIdentity, -.pi/2, 0, 1, 0)

        }) { (Bool) in
            splashImageView.removeFromSuperview()
        }
        
    }


}
