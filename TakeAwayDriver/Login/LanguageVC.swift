//
//  LanguageVC.swift
//  TakeAwayDriver
//
//  Created by mac on 28/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import Localize

class LanguageVC: UIViewController {

    var VC : UIViewController!
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SlideMenuOptions.panFromBezel = false
        SlideMenuOptions.rightPanFromBezel = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden=true;
       
    }

    @IBAction func ArabicMethod(_ sender: Any) {
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
            
            
//            let ViewController = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//            VC = UINavigationController(rootViewController:ViewController)
//            self.slideMenuController()?.changeMainViewController(VC, close: true)
        
        let ViewController = storyboard?.instantiateViewController(withIdentifier: "SelectUserVC") as! SelectUserVC
        VC = UINavigationController(rootViewController:ViewController)
        self.slideMenuController()?.changeMainViewController(VC, close: true)
            
            
        }
        
        @IBAction func EnglishMethod(_ sender: Any) {
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


    //        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    //
    //        // call didFinishLaunchWithOptions ... why?
    //        appDelegate?.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
            
            
            
            
//            let ViewController = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//            VC = UINavigationController(rootViewController:ViewController)
//            self.slideMenuController()?.changeMainViewController(VC, close: true)
            
            
            
            let ViewController = storyboard?.instantiateViewController(withIdentifier: "SelectUserVC") as! SelectUserVC
            VC = UINavigationController(rootViewController:ViewController)
            self.slideMenuController()?.changeMainViewController(VC, close: true)
            
        }
    
}
