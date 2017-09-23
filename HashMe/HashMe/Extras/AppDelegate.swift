//
//  AppDelegate.swift
//  HashMe
//
//  Created by Dheeru on 9/22/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var viewControllerToBeShown: UIViewController?
        
        if UserDefaults.standard.value(forKey: Constants.onboaringIdentifier) as? String == nil {
            viewControllerToBeShown = mainStoryboard.instantiateViewController(withIdentifier: "OnboardingViewController") as? OnboardingViewController
            self.window?.rootViewController = viewControllerToBeShown
            self.window?.makeKeyAndVisible()
        } else {
            viewControllerToBeShown = mainStoryboard.instantiateInitialViewController()
            let nav1 = UINavigationController()
            nav1.viewControllers = [viewControllerToBeShown!]
            self.window?.rootViewController = nav1
        }
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
