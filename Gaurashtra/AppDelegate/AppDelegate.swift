//
//  AppDelegate.swift
//  Gaurashtra
//
//  Created by abc on 24/09/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit
import CoreData
import SWRevealViewController
import IQKeyboardManagerSwift
//import FBSDKLoginKit
//import FBSDKCoreKit

import Firebase
//import FirebaseInstanceID

import FirebaseMessaging
import PushNotifications
import UserNotifications


var launch : String = ""

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,MessagingDelegate,UNUserNotificationCenterDelegate {

    var swrevealObject = SWRevealViewController()
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        //ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
               
         if launchedBefore
        {
                    //print("Has launched before")
            
            launch = "Has launched before"
         }
         else
         {
            
            launch = "First launch"
            
                    //print("First launch")
                    UserDefaults.standard.set(true, forKey: "launchedBefore")
          }
      
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            
        } else {
            
            
            let settings  = UIUserNotificationSettings(types: [UIUserNotificationType.alert , UIUserNotificationType.badge , UIUserNotificationType.sound], categories: nil)
            
            application.registerUserNotificationSettings(settings)
        }
        FirebaseApp.configure()
        application.registerForRemoteNotifications()
         // GIDSignIn.sharedInstance().clientID = "113779175583-g0stf1pcs8trjq1s3uf0h1diesklkipm.apps.googleusercontent.com"
        
        //113779175583-g0stf1pcs8trjq1s3uf0h1diesklkipm.apps.googleusercontent.com
        Messaging.messaging().delegate = self
        let token = Messaging.messaging().fcmToken
        
        print(token)
        
        kSharedUserDefaults.set(token, forKey: "deviceToken")
       
        self.configureAppIntialSetUp()
        return true
    }
    
    
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken
        deviceToken: Data) {
        
//        InstanceID.instanceID().instanceID { (result, error) in
//            if let error = error {
//                //print("Error fetching remote instange ID: \(error)")
//            } else if let result = result {
//                //print("Remote instance ID token: \(result.token)")
//                let deviceToken = String.getString(result.token)
//                //print(deviceToken)
//                kSharedUserDefaults.set(deviceToken, forKey: "deviceToken")
//                
//                
//            }
//        }
        
    }
    
    
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError
        error: Error) {
        // Try again later.
        
        //print(error)
        
    }
//    
//    func applicationReceivedRemoteMessage(_ remoteMessage: MessagingRemoteMessage) {
//        //  self.playSound()
//        //print(remoteMessage.appData)
//        
//    }
//    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    {
        
        let dictData = kSharedInstance.getDictionary(userInfo["aps"])
        //print(dictData)
        
        
        
        let alert = kSharedInstance.getDictionary(dictData["alert"])
        
        
        
        
        //print(alert)
        // //print full message.
        //print(userInfo)
 
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        
        
        let userInfo = notification.request.content.userInfo
        let dictData = kSharedInstance.getDictionary(userInfo["aps"])
        //print(dictData)
        
        
        
        let alert = kSharedInstance.getDictionary(dictData["alert"])
     
        completionHandler(.alert)
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

    
//    func application(_ application: UIApplication,
//                     didRegisterForRemoteNotificationsWithDeviceToken
//        deviceToken: Data) {
//        
//        InstanceID.instanceID().instanceID { (result, error) in
//            if let error = error {
//                //print("Error fetching remote instange ID: \(error)")
//            } else if let result = result {
//                //print("Remote instance ID token: \(result.token)")
//                let deviceToken = String.getString(result.token)
//                
//                //print(deviceToken)
//                
//                
//                
//                kSharedUserDefaults.set(deviceToken, forKey: "deviceToken")
//                
//                
//            }
//        }
//        
//    }
//    
//    func application(_ application: UIApplication,
//                     didFailToRegisterForRemoteNotificationsWithError
//        error: Error) {
//        // Try again later.
//        
//        //print(error)
//        
//    }
//    
//    func applicationReceivedRemoteMessage(_ remoteMessage: MessagingRemoteMessage) {
//        //print(remoteMessage.appData)
//        
//    }
//    
//    
//    
//    func application(_ application: UIApplication,
//                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
//                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
//    {
//        
//        let dictData = kSharedInstance.getDictionary(userInfo["aps"])
//        //print(dictData)
//        
//        
//        
//        let alert = kSharedInstance.getDictionary(dictData["alert"])
//        
//        //print(alert)
//        // //print full message.
//        //print(userInfo)
//        
//        // let rideId = String.getString(userInfo["rideId"])
//        
//        
//        
//        completionHandler(UIBackgroundFetchResult.newData)
//    }
  
    func configureAppIntialSetUp()
    {
        //self.setRootNavigation()
       IQKeyboardManager.shared.enable = true
      
      //  GIDSignIn.sharedInstance().clientID = "206176254009-hgk8t7afa945pflinaludaa10183pplb.apps.googleusercontent.com"
        
      //  self.setRootNavigation()
        
         self.showSideMenu()
    }
    
    func setRootNavigation() -> Void {
        
        
        if kSharedUserDefaults.isUserLoggedIn()
        {
            
            self.showSideMenu()
            
        }else{
            
            
            self.showloginView()
        }
    }
    
    
    //
    
    
       func showProfileView()
       {
           let storyBoard = UIStoryboard(name: kHome, bundle: nil)
           swrevealObject = storyBoard.instantiateViewController(withIdentifier: "profileNav") as! SWRevealViewController
           //        navigationController.setupNavigationBarView()
           //        swrevealObject.rearViewRevealOverdraw = 65
           window?.rootViewController = swrevealObject
           
       }
    
    
    func showSideMenu()
    {
        let storyBoard = UIStoryboard(name: kHome, bundle: nil)
        swrevealObject = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        //        navigationController.setupNavigationBarView()
        //        swrevealObject.rearViewRevealOverdraw = 65
        window?.rootViewController = swrevealObject
        
    }
    
    
    func showloginView()
    {
      
        window?.rootViewController = nil
        
        let storyBoard = UIStoryboard(name: kLoginPlaceholder, bundle: nil)
        let navigationController = storyBoard.instantiateViewController(withIdentifier: "LoginNavigation") as! UINavigationController
        navigationController.setupNavigationBarView()
        
        window?.rootViewController = navigationController
     
    }
    
    
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Gaurashtra")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func managedObjectContext() -> NSManagedObjectContext
    {
        return self.persistentContainer.viewContext
    }
    
}

