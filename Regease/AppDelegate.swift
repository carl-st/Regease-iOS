//
//  AppDelegate.swift
//  Regease
//
//  Created by Karol Stępień on 27.11.2016.
//  Copyright © 2016 Regease. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Ovvaride point for customization after application launch.
#if LOCAL
        injectIP()
#endif
        applyAppearance()
        let _ = PersistenceManager.sharedInstance
        let args = ProcessInfo.processInfo.arguments
        if args.contains("UI_TEST_MODE") {
            PersistenceManager.sharedInstance.clearUserData()
            debugPrint("cleared user data")
            let appointment = Appointment()
            let registrant = Registrant()
            let visitType = VisitType()
            visitType.name = "Consultation"
            visitType.duration = 3600
            registrant.name = "John Travolta"
            registrant.email = "john@travolta.com"
            appointment.date = NSDate().addingTimeInterval(600)
            appointment.registrant = registrant
            appointment.visitType = visitType
            appointment.id = "0"
            PersistenceManager.sharedInstance.createOrUpdate(appointment)
        }
        
        // Initial VC
        let storyboard = UIStoryboard(name: StoryboardNames.Login.rawValue, bundle: nil)
        let me = PersistenceManager.sharedInstance.user()
        let appointment = Appointment()
        let registrant = Registrant()
        let visitType = VisitType()
        visitType.name = "Consultation"
        visitType.duration = 3600
        registrant.name = "John Travolta"
        registrant.email = "john@travolta.com"
        appointment.date = NSDate().addingTimeInterval(600)
        appointment.registrant = registrant
        appointment.visitType = visitType
        appointment.id = "0"
        PersistenceManager.sharedInstance.createOrUpdate(appointment)
        if me == nil {
            let initialViewController = storyboard.instantiateViewController(withIdentifier: NavigationControllerStoryboardIdentifier.LoginNavigationController.rawValue)
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        } else {
            AuthServices.sharedInstance.me { _, data in
                if data is Int {
                    if data as! Int == 401 {
                        PersistenceManager.sharedInstance.clearUserData()
                        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                        let storyboard = UIStoryboard(name: StoryboardNames.Login.rawValue, bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: NavigationControllerStoryboardIdentifier.LoginNavigationController.rawValue)
                        UIView.transition(with: self.window!, duration: 0.5, options: UIViewAnimationOptions.transitionFlipFromLeft, animations: {
                            () in
                            self.window?.rootViewController = vc
                            self.window?.makeKeyAndVisible()
                        }, completion: nil)
                    }
                }
            }
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

#if LOCAL

    func injectIP() -> Void {
        let filePath = Bundle.main.path(forResource: "local", ofType: "ip")
        let data = NSData(contentsOfFile: filePath!)
        let stringData = NSString(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
        Urls.baseUrl = (stringData?.description)! + "api/"
        debugPrint("Hitting API on \(Urls.baseUrl)")

    }

#endif

}

