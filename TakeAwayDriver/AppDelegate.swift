//
//  AppDelegate.swift
//  TakeAwayDriver
//
//  Created by mac on 21/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import Localize
import SlideMenuControllerSwift
import Firebase
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true
        
        if (MyDefaults().LanguageId) != nil && MyDefaults().isLogin==true {
            
            if MyDefaults().UserType == "Admin"{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainViewController = storyboard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
                
                
                if MyDefaults().LanguageId == "ar"{
                    let leftViewController = storyboard.instantiateViewController(withIdentifier: "SliderVC") as! SliderVC
                    
                    let slideMenuController = SlideMenuController(mainViewController: mainViewController, rightMenuViewController: leftViewController)
                    
                    self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
                    self.window?.rootViewController = slideMenuController
                    self.window?.makeKeyAndVisible()
                }
                else{
                    let leftViewController = storyboard.instantiateViewController(withIdentifier: "SliderVC") as! SliderVC
                    
                    let slideMenuController = SlideMenuController(mainViewController: mainViewController, leftMenuViewController: leftViewController)
                    self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
                    self.window?.rootViewController = slideMenuController
                    self.window?.makeKeyAndVisible()
                }
            }
            else{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainViewController = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                
                
                if MyDefaults().LanguageId == "ar"{
                    let leftViewController = storyboard.instantiateViewController(withIdentifier: "SliderVC") as! SliderVC
                    
                    let slideMenuController = SlideMenuController(mainViewController: mainViewController, rightMenuViewController: leftViewController)
                    
                    self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
                    self.window?.rootViewController = slideMenuController
                    self.window?.makeKeyAndVisible()
                }
                else{
                    let leftViewController = storyboard.instantiateViewController(withIdentifier: "SliderVC") as! SliderVC
                    
                    let slideMenuController = SlideMenuController(mainViewController: mainViewController, leftMenuViewController: leftViewController)
                    self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
                    self.window?.rootViewController = slideMenuController
                    self.window?.makeKeyAndVisible()
                }
            }
        }
        else if (MyDefaults().LanguageId) != nil && MyDefaults().isLogin==false {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            
            if MyDefaults().LanguageId == "ar"{
                let leftViewController = storyboard.instantiateViewController(withIdentifier: "SliderVC") as! SliderVC
                
                let slideMenuController = SlideMenuController(mainViewController: mainViewController, rightMenuViewController: leftViewController)
                
                self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
                self.window?.rootViewController = slideMenuController
                self.window?.makeKeyAndVisible()
            }
            else{
                let leftViewController = storyboard.instantiateViewController(withIdentifier: "SliderVC") as! SliderVC
                
                let slideMenuController = SlideMenuController(mainViewController: mainViewController, leftMenuViewController: leftViewController)
                self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
                self.window?.rootViewController = slideMenuController
                self.window?.makeKeyAndVisible()
            }
            
        }
        else{
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "LanguageVC") as! LanguageVC
            let leftViewController = storyboard.instantiateViewController(withIdentifier: "SliderVC") as! SliderVC
            
            let slideMenuController = SlideMenuController(mainViewController: mainViewController, leftMenuViewController: leftViewController)
            self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
            self.window?.rootViewController = slideMenuController
            self.window?.makeKeyAndVisible()
            
        }
        
        UINavigationBar.appearance().clipsToBounds = true
        if #available(iOS 13.0, *) {
            
            let statusBar = UIView(frame:
                UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = UIColor.black
            UIApplication.shared.keyWindow?.addSubview(statusBar)
            
        } else {
            if let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
                statusBar.backgroundColor = UIColor.black
            }
        }
        
        
        
        if MyDefaults().LanguageId == "ar"{
            
            let localize = Localize.shared
            localize.update(provider: .json)
            localize.update(fileName: "lang")
            localize.resetLanguage()
            Localize.update(fileName: "lang")
            Localize.update(language: "ar")
            MyDefaults().LanguageId = "ar"
            print(MyDefaults().LanguageId)
            
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UITextField.appearance().semanticContentAttribute = .forceRightToLeft
            UITextField.appearance().textAlignment = .right
            UILabel.appearance().semanticContentAttribute = .forceRightToLeft
            UITextView.appearance().textAlignment = .right
            UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
            UICollectionView.appearance().semanticContentAttribute = .forceRightToLeft
            UITableView.appearance().semanticContentAttribute = .forceRightToLeft
            UIImageView.appearance().semanticContentAttribute = .forceRightToLeft
            UIButton.appearance().semanticContentAttribute = .forceRightToLeft
            UISwitch.appearance().semanticContentAttribute = .forceRightToLeft
        }
        else{
            
            let localize = Localize.shared
            localize.update(provider: .json)
            localize.update(fileName: "lang")
            localize.resetLanguage()
            Localize.update(fileName: "lang")
            Localize.update(language: "en")
            MyDefaults().LanguageId = "en"
            print(MyDefaults().LanguageId)
            
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UITextField.appearance().semanticContentAttribute = .forceLeftToRight
            UILabel.appearance().semanticContentAttribute = .forceLeftToRight
            UITextField.appearance().textAlignment = .left
            UITextView.appearance().textAlignment = .left
            UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
            UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
            UITableView.appearance().semanticContentAttribute = .forceLeftToRight
            UIImageView.appearance().semanticContentAttribute = .forceLeftToRight
            UIButton.appearance().semanticContentAttribute = .forceLeftToRight
            UISwitch.appearance().semanticContentAttribute = .forceLeftToRight
            
            
        }
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "TakeAwayDriver")
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

}

// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        print(userInfo)
        UIApplication.shared.applicationIconBadgeNumber = 0
        let tag = userInfo[AnyHashable("gcm.notification.notification_tag")] as? String
        print(tag)
        
        
        completionHandler([.alert,.sound])
        //completionHandler([])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        print(userInfo)
        UIApplication.shared.applicationIconBadgeNumber = 0
        //completionHandler([.alert, .badge, .sound])
        completionHandler()
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        Messaging.messaging().apnsToken = deviceToken
    }
    
    
    
    
}

extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        MyDefaults().RefreshToken = fcmToken
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
    }

    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }


}
