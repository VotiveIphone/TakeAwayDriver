//
//  LoginVC.swift
//  TakeAwayDriver
//
//  Created by mac on 28/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SlideMenuControllerSwift

class LoginVC: UIViewController,NVActivityIndicatorViewable {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnPassEye: UIButton!
    
    var passCheck = false
    var VC : UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        SlideMenuOptions.panFromBezel = false
        SlideMenuOptions.rightPanFromBezel = false
        
        
//        txtEmail.text = "8839004585"
//        txtPassword.text = "Qwerty@1234"
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden=true;
       
    }
    
    func LoginDriverService(){
        startAnimating(color:CommonClass().appThemColor)
        var param : [String : Any] = [:]
            
        param = ["mobile" : String(txtEmail.text!),
                 "password" : String(txtPassword.text!),
                 "localization" : MyDefaults().LanguageId!,
                 "device_token":String(CommonClass.DeviceID),
                 "device_type":"iphone"
                ]
        print(param)
        CommunicationManager().getResponseForParamType(strUrl: CommonClass.LoginApi, parameters: param as NSDictionary) { ( result , data) in
            self.stopAnimating()
            if(result == "success") {
                let dataDict = data as! NSDictionary
                print(dataDict)
                let responce = dataDict.value(forKey: "response") as! NSDictionary
                let strCheck = dataDict.value(forKey: "msg") as! String
                if strCheck == "Your Account is not verified"{
                    self.present(CommonClass().Alert(title: "Take Away".localize(), msg: data["msg"] as! String), animated: true, completion: nil)
                }
                else{
                    MyDefaults().UserId = CommonClass().toString(responce["user_id"])
                    MyDefaults().MobileNo = CommonClass().toString(responce["mobile"])
                    MyDefaults().UserName = CommonClass().toString(responce["fullname"])
                    MyDefaults().UserProfile = CommonClass().toString(responce["profile_img"])
                    MyDefaults().UserEmail = self.txtEmail.text
                    
                    if CommonClass().toString(responce["change_password_status"]) == "0"{
                        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
                        ViewController.isSliderOpen = true
                        let nav = UINavigationController(rootViewController:ViewController)
                        nav.navigationBar.isHidden = true
                        self.slideMenuController()?.changeMainViewController(nav, close: true)
                    }
                    else{
                        MyDefaults().isLogin = true
                        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                        let nav = UINavigationController(rootViewController:ViewController)
                        nav.navigationBar.isHidden = true
                        self.slideMenuController()?.changeMainViewController(nav, close: true)
                    }
                }
                    
            }else if (result == "error") {
                print(data)
                self.present(CommonClass().Alert(title: "Take Away".localize(), msg: data["msg"] as! String), animated: true, completion: nil)
            }else if (result == "Network") {
                print(data)
                self.present(CommonClass().Alert(title: "Take Away".localize(), msg:"Data Not Found".localize()), animated: true, completion: nil)
            }
        }
    }
    
    
    func LoginAdminService(){
        startAnimating(color:CommonClass().appThemColor)
        var param : [String : Any] = [:]
            
        param = ["mobile" : String(txtEmail.text!),
                 "password" : String(txtPassword.text!),
                 "localization" : MyDefaults().LanguageId!,
                 "device_token":String(CommonClass.DeviceID),
                 "device_type":"iphone"
                ]
        print(param)
        CommunicationManager().getResponseForParamType(strUrl: CommonClass.LoginAdminApi, parameters: param as NSDictionary) { ( result , data) in
            self.stopAnimating()
            if(result == "success") {
                let dataDict = data as! NSDictionary
                print(dataDict)
                let responce = dataDict.value(forKey: "response") as! NSDictionary
                let strCheck = dataDict.value(forKey: "msg") as! String
                if strCheck == "Your Account is not verified"{
                    self.present(CommonClass().Alert(title: "Take Away".localize(), msg: data["msg"] as! String), animated: true, completion: nil)
                }
                else{
                    MyDefaults().UserId = CommonClass().toString(responce["user_id"])
                    MyDefaults().MobileNo = CommonClass().toString(responce["mobile"])
                    MyDefaults().UserName = CommonClass().toString(responce["fullname"])
                    MyDefaults().UserProfile = CommonClass().toString(responce["profile_img"])
                    MyDefaults().UserEmail = self.txtEmail.text
                    MyDefaults().isLogin = true
                    let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
                    let nav = UINavigationController(rootViewController:ViewController)
                    nav.navigationBar.isHidden = true
                    self.slideMenuController()?.changeMainViewController(nav, close: true)
                    
                }
                    
            }else if (result == "error") {
                print(data)
                self.present(CommonClass().Alert(title: "Take Away".localize(), msg: data["msg"] as! String), animated: true, completion: nil)
            }else if (result == "Network") {
                print(data)
                self.present(CommonClass().Alert(title: "Take Away".localize(), msg:"Data Not Found".localize()), animated: true, completion: nil)
            }
        }
    }
    
    
    
    func CheckValidation() -> Bool {
        
        if(txtEmail.text == ""){
            let alertController = UIAlertController(title: "Take Away".localize(), message: "Please Enter Email Or Mobile No.".localize(), preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok".localize(), style: UIAlertAction.Style.default) {
                UIAlertAction in
                self.txtEmail.becomeFirstResponder()
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            return false
        }
        
        if(txtPassword.text == ""){
            let alertController = UIAlertController(title: "Take Away".localize(), message: "Please Enter Password".localize(), preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok".localize(), style: UIAlertAction.Style.default) {
                UIAlertAction in
                self.txtPassword.becomeFirstResponder()
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            return false
        }
        
        
        return true
    }
    
    
    @IBAction func PasswordHideShowMethod(_ sender: Any) {
        if passCheck==false{
            passCheck=true
            txtPassword.isSecureTextEntry=false
            btnPassEye.setImage(#imageLiteral(resourceName: "eyeOn"), for:.normal)
        }
        else{
            passCheck=false
            txtPassword.isSecureTextEntry=true
            btnPassEye.setImage(#imageLiteral(resourceName: "eyeOff"), for: .normal)
        }
    }
    

    @IBAction func LoginMethod(_ sender: Any) {
        
        if (Reachability.isConnectedToNetwork()){
            if(CheckValidation()) {
                
                if MyDefaults().UserType == "Admin"{
                    self.LoginAdminService()
                }
                else{
                    self.LoginDriverService()
                }
            }
        }
        else{
            self.present(CommonClass().Alert(title: "Take Away".localize(), msg:"Internet Connection not Available!".localize()), animated: true, completion: nil)
        }
    }
    
    
}


