//
//  LanguageChangeVC.swift
//  TakeAway
//
//  Created by mac on 15/01/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import Localize
import NVActivityIndicatorView
import SDWebImage

protocol changeLanguageDelegate {
    func didSelectLanguage()
}

class LanguageChangeVC: UIViewController,NVActivityIndicatorViewable {

    var delegateLanguage : changeLanguageDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.resignFirstResponder()
        //self.dismiss(animated: true, completion: nil)
    }
    
//    func SettingUpdateService(value:String!){
//        startAnimating(color:CommonClass().appThemColor)
//        var param : [String : Any] = [:]
//
//        param = ["user_id" :MyDefaults().UserId,
//                 "setting_tag" : "setting_language",
//                 "setting_value": value]
//        print(param)
//        CommunicationManager().getResponseForParamType(strUrl: CommonClass.SettingUpdateApi, parameters: param as NSDictionary) { ( result , data) in
//            self.stopAnimating()
//            if(result == "success") {
//                let dataDict = data["response"] as! NSDictionary
//                print(dataDict)
//
//            }else if (result == "error") {
//                print(data)
//                self.dismiss(animated: true, completion: nil)
//                self.present(CommonClass().Alert(title: "Take Away".localize(), msg: data["msg"] as! String), animated: true, completion: nil)
//            }else if (result == "Network") {
//                print(data)
//                self.dismiss(animated: true, completion: nil)
//                self.present(CommonClass().Alert(title: "Take Away".localize(), msg:"Data Not Found".localize()), animated: true, completion: nil)
//            }
//        }
//    }

    @IBAction func ArabicMethod(_ sender: Any) {
        
       // self.SettingUpdateService(value:"ar")
        
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
        
        delegateLanguage?.didSelectLanguage()
        
        
//        let sceneDelegate: SceneDelegate? = UIApplication.shared.delegate as? SceneDelegate
//        sceneDelegate?.scene(UIScene.self, willConnectTo: <#T##UISceneSession#>, options: nil)
//        
//        // call didFinishLaunchWithOptions ... why?
//        appDelegate?.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        
        // call didFinishLaunchWithOptions ... why?
        appDelegate?.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func EnglishMethod(_ sender: Any) {
       // self.SettingUpdateService(value:"en")
        
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
        
                   
        delegateLanguage?.didSelectLanguage()
        
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        
        // call didFinishLaunchWithOptions ... why?
        appDelegate?.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        
        self.dismiss(animated: true, completion: nil)
        
        

        
    }
    
    @IBAction func CancelMethod(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
