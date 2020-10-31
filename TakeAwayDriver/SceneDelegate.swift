
//  SceneDelegate.swift
//  TakeAwayDriver
//  Created by mac on 21/10/20.
//  Copyright © 2020 mac. All rights reserved.


import UIKit
import IQKeyboardManagerSwift
import Localize
import SlideMenuControllerSwift


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
//        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
//        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
//        guard let _ = (scene as? UIWindowScene) else { return }
//        
//        
//        IQKeyboardManager.shared.enable = true
//        
//        if (MyDefaults().LanguageId) != nil && MyDefaults().isLogin==true {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let mainViewController = storyboard.instantiateViewController(withIdentifier: "OrderHistoryVC") as! OrderHistoryVC
//            
//            
//            if MyDefaults().LanguageId == "ar"{
//                let leftViewController = storyboard.instantiateViewController(withIdentifier: "SliderVC") as! SliderVC
//                
//                let slideMenuController = SlideMenuController(mainViewController: mainViewController, rightMenuViewController: leftViewController)
//                
//                self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
//                self.window?.rootViewController = slideMenuController
//                self.window?.makeKeyAndVisible()
//            }
//            else{
//                let leftViewController = storyboard.instantiateViewController(withIdentifier: "SliderVC") as! SliderVC
//                
//                let slideMenuController = SlideMenuController(mainViewController: mainViewController, leftMenuViewController: leftViewController)
//                self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
//                self.window?.rootViewController = slideMenuController
//                self.window?.makeKeyAndVisible()
//            }
//            
//            
//            
//        }
//        else if (MyDefaults().LanguageId) != nil && MyDefaults().isLogin==false {
//            
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let mainViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//            
//            if MyDefaults().LanguageId == "ar"{
//                let leftViewController = storyboard.instantiateViewController(withIdentifier: "SliderVC") as! SliderVC
//                
//                let slideMenuController = SlideMenuController(mainViewController: mainViewController, rightMenuViewController: leftViewController)
//                
//                self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
//                self.window?.rootViewController = slideMenuController
//                self.window?.makeKeyAndVisible()
//            }
//            else{
//                let leftViewController = storyboard.instantiateViewController(withIdentifier: "SliderVC") as! SliderVC
//                
//                let slideMenuController = SlideMenuController(mainViewController: mainViewController, leftMenuViewController: leftViewController)
//                self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
//                self.window?.rootViewController = slideMenuController
//                self.window?.makeKeyAndVisible()
//            }
//            
//        }
//        else{
//            
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let mainViewController = storyboard.instantiateViewController(withIdentifier: "LanguageVC") as! LanguageVC
//            let leftViewController = storyboard.instantiateViewController(withIdentifier: "SliderVC") as! SliderVC
//            
//            let slideMenuController = SlideMenuController(mainViewController: mainViewController, leftMenuViewController: leftViewController)
//            self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
//            self.window?.rootViewController = slideMenuController
//            self.window?.makeKeyAndVisible()
//            
//        }
//        
//        UINavigationBar.appearance().clipsToBounds = true
//        if #available(iOS 13.0, *) {
//            
//            let statusBar = UIView(frame:
//                UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
//            statusBar.backgroundColor = UIColor.black
//            UIApplication.shared.keyWindow?.addSubview(statusBar)
//            
//        } else {
//            if let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
//                statusBar.backgroundColor = UIColor.black
//            }
//        }
//        
//        
//        
//        if MyDefaults().LanguageId == "ar"{
//            
//            let localize = Localize.shared
//            localize.update(provider: .json)
//            localize.update(fileName: "lang")
//            localize.resetLanguage()
//            Localize.update(fileName: "lang")
//            Localize.update(language: "ar")
//            MyDefaults().LanguageId = "ar"
//            print(MyDefaults().LanguageId)
//            
//            UIView.appearance().semanticContentAttribute = .forceRightToLeft
//            UITextField.appearance().semanticContentAttribute = .forceRightToLeft
//            UITextField.appearance().textAlignment = .right
//            UILabel.appearance().semanticContentAttribute = .forceRightToLeft
//            UITextView.appearance().textAlignment = .right
//            UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
//            UICollectionView.appearance().semanticContentAttribute = .forceRightToLeft
//            UITableView.appearance().semanticContentAttribute = .forceRightToLeft
//            UIImageView.appearance().semanticContentAttribute = .forceRightToLeft
//            UIButton.appearance().semanticContentAttribute = .forceRightToLeft
//            UISwitch.appearance().semanticContentAttribute = .forceRightToLeft
//        }
//        else{
//            
//            let localize = Localize.shared
//            localize.update(provider: .json)
//            localize.update(fileName: "lang")
//            localize.resetLanguage()
//            Localize.update(fileName: "lang")
//            Localize.update(language: "en")
//            MyDefaults().LanguageId = "en"
//            print(MyDefaults().LanguageId)
//            
//            UIView.appearance().semanticContentAttribute = .forceLeftToRight
//            UITextField.appearance().semanticContentAttribute = .forceLeftToRight
//            UILabel.appearance().semanticContentAttribute = .forceLeftToRight
//            UITextField.appearance().textAlignment = .left
//            UITextView.appearance().textAlignment = .left
//            UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
//            UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
//            UITableView.appearance().semanticContentAttribute = .forceLeftToRight
//            UIImageView.appearance().semanticContentAttribute = .forceLeftToRight
//            UIButton.appearance().semanticContentAttribute = .forceLeftToRight
//            UISwitch.appearance().semanticContentAttribute = .forceLeftToRight
//            
//            
//        }
//
//
//
//    }
//
//    func sceneDidDisconnect(_ scene: UIScene) {
//        // Called as the scene is being released by the system.
//        // This occurs shortly after the scene enters the background, or when its session is discarded.
//        // Release any resources associated with this scene that can be re-created the next time the scene connects.
//        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
//    }
//
//    func sceneDidBecomeActive(_ scene: UIScene) {
//        // Called when the scene has moved from an inactive state to an active state.
//        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
//    }
//
//    func sceneWillResignActive(_ scene: UIScene) {
//        // Called when the scene will move from an active state to an inactive state.
//        // This may occur due to temporary interruptions (ex. an incoming phone call).
//    }
//
//    func sceneWillEnterForeground(_ scene: UIScene) {
//        // Called as the scene transitions from the background to the foreground.
//        // Use this method to undo the changes made on entering the background.
//    }
//
//    func sceneDidEnterBackground(_ scene: UIScene) {
//        // Called as the scene transitions from the foreground to the background.
//        // Use this method to save data, release shared resources, and store enough scene-specific state information
//        // to restore the scene back to its current state.
//
//        // Save changes in the application's managed object context when the application transitions to the background.
//        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
//    }


}

