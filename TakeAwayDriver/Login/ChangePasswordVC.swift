//
//  ChangePasswordVC.swift
//  TakeAway
//
//  Created by mac on 21/10/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ChangePasswordVC: UIViewController,NVActivityIndicatorViewable,UITextFieldDelegate {
    
    @IBOutlet weak var txtoldPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnOldPassEye: UIButton!
    @IBOutlet weak var btnPassEye: UIButton!
    @IBOutlet weak var btnConfirmPassEye: UIButton!
    
    var oldpassCheck = false
    var passCheck = false
    var confirmpassCheck = false
    var PasswordMaxLength = 11
    var isSliderOpen:Bool!
    var VC : UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden=true;
        
    }
    
    
    func ChangePasswordService(){
        startAnimating(color:CommonClass().appThemColor)
        var param : [String : Any] = [:]
        
        param = ["mobile" : MyDefaults().MobileNo,
                "new_password" : String(txtConfirmPassword.text!),
                "password" : String(txtoldPassword.text!)]
        print(param)
        CommunicationManager().getResponseForParamType(strUrl: CommonClass.ChangePasswordApi, parameters: param as NSDictionary) { ( result , data) in
            self.stopAnimating()
            if(result == "success") {
                
                let dataDict = data as! NSDictionary
                print(dataDict)
                //let responce = dataDict.value(forKey: "response") as! NSDictionary
                
                let alertController = UIAlertController(title: "Take Away".localize(), message: data["msg"] as? String, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok".localize(), style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    MyDefaults().isLogin = true
                    
                    let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                    let nav = UINavigationController(rootViewController:ViewController)
                    nav.navigationBar.isHidden = true
                    self.slideMenuController()?.changeMainViewController(nav, close: true)
                    
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                
                
                
            }else if (result == "error") {
                print(data)
                self.present(CommonClass().Alert(title: "Take Away".localize(), msg: data["msg"] as! String), animated: true, completion: nil)
            }else if (result == "Network") {
                print(data)
                self.present(CommonClass().Alert(title: "Take Away".localize(), msg:"Data Not Found".localize()), animated: true, completion: nil)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == txtoldPassword{
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= PasswordMaxLength
        }
        if textField == txtNewPassword{
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= PasswordMaxLength
        }
        if textField == txtConfirmPassword{
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= PasswordMaxLength
        }
        
        return true
    }
    
    func CheckValidation() -> Bool {
        
        
        if(txtoldPassword.text == ""){
            let alertController = UIAlertController(title: "Take Away".localize(), message: "Please Enter Old Password".localize(), preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok".localize(), style: UIAlertActionStyle.default) {
                UIAlertAction in
                self.txtoldPassword.becomeFirstResponder()
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            return false
        }
        
        if(txtNewPassword.text == ""){
            let alertController = UIAlertController(title: "Take Away".localize(), message: "Please Enter New Password".localize(), preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok".localize(), style: UIAlertActionStyle.default) {
                UIAlertAction in
                self.txtNewPassword.becomeFirstResponder()
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            return false
        }
        
//        if(validatePassword(value:txtNewPassword.text!)==false){
//            let alertController = UIAlertController(title: "Take Away".localize(), message: "Password must contain at least 8 characters,including UPPER/lowercase,number and special characters.".localize(), preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "Ok".localize(), style: UIAlertActionStyle.default) {
//                UIAlertAction in
//                self.txtNewPassword.becomeFirstResponder()
//            }
//            alertController.addAction(okAction)
//            self.present(alertController, animated: true, completion: nil)
//            
//            return false
//        }
        
        if(txtConfirmPassword.text == ""){
            let alertController = UIAlertController(title: "Take Away".localize(), message: "Please Enter Confirm Password".localize(), preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok".localize(), style: UIAlertActionStyle.default) {
                UIAlertAction in
                self.txtConfirmPassword.becomeFirstResponder()
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            return false
        }
        
        if((txtNewPassword.text!) != (txtConfirmPassword.text!)){
            let alertController = UIAlertController(title: "Take Away".localize(), message: "Password Not Match".localize(), preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok".localize(), style: UIAlertActionStyle.default) {
                UIAlertAction in
                self.txtConfirmPassword.becomeFirstResponder()
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return false
        }
        
        
        return true
    }
    
    func validatePassword(value: String) -> Bool {
        let passwordFormat = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,15}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordFormat)
        return passwordPredicate.evaluate(with: value)
    }
    
    @IBAction func OldPasswordSecureMethod(_ sender: Any) {
        
        if oldpassCheck==false{
            oldpassCheck=true
            txtoldPassword.isSecureTextEntry=false
            btnOldPassEye.setImage(#imageLiteral(resourceName: "eyeOn"), for:.normal)
        }
        else{
            oldpassCheck=false
            txtoldPassword.isSecureTextEntry=true
            btnOldPassEye.setImage(#imageLiteral(resourceName: "eyeOff"), for: .normal)
        }
    }
    
    @IBAction func PasswordSecureMethod(_ sender: Any) {
        if passCheck==false{
            passCheck=true
            txtNewPassword.isSecureTextEntry=false
            btnPassEye.setImage(#imageLiteral(resourceName: "eyeOn"), for:.normal)
        }
        else{
            passCheck=false
            txtNewPassword.isSecureTextEntry=true
            btnPassEye.setImage(#imageLiteral(resourceName: "eyeOff"), for: .normal)
        }
    }
    
    @IBAction func ConfirmPasswordSecureMethod(_ sender: Any) {
        if confirmpassCheck==false{
            confirmpassCheck=true
            txtConfirmPassword.isSecureTextEntry=false
            btnConfirmPassEye.setImage(#imageLiteral(resourceName: "eyeOn"), for:.normal)
        }
        else{
            confirmpassCheck=false
            txtConfirmPassword.isSecureTextEntry=true
            btnConfirmPassEye.setImage(#imageLiteral(resourceName: "eyeOff"), for: .normal)
        }
    }
    
    @IBAction func SaveMethod(_ sender: Any) {
        if (Reachability.isConnectedToNetwork()){
            if(CheckValidation()) {
                self.ChangePasswordService()
            }
        }
        else{
            self.present(CommonClass().Alert(title: "Take Away".localize(), msg:"Internet Connection not Available!".localize()), animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func BackMethod(_ sender: Any) {
        
        if isSliderOpen == true{
            let ViewController = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            VC = UINavigationController(rootViewController:ViewController)
            self.slideMenuController()?.changeMainViewController(VC, close: true)
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }

        
    }
    
}
