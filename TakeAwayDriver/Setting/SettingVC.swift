//
//  SettingVC.swift
//  TakeAwayDriver
//
//  Created by mac on 28/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class SettingTVC: UITableViewCell {
    @IBOutlet weak var imgContent: UIImageView!
    @IBOutlet weak var lblName: UILabel!
}

class SettingVC: UIViewController {

    
    @IBOutlet weak var tblList: UITableView!
    var arrList = [Any]()
    var arrImages = [Any]()
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        arrList = ["Language".localize(),"Change Password".localize()]
        arrImages = ["Globe_icon","PasswordWhite"]
        
        tblList.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden=true;
       
    }
    
    @IBAction func SliderMethod(_ sender: Any) {
        if MyDefaults().LanguageId == "ar"{
            slideMenuController()?.toggleRight()
        }
        else{
            slideMenuController()?.toggleLeft()
        }
        
    }
    

}


extension SettingVC : UITableViewDelegate,UITableViewDataSource,changeLanguageDelegate {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"Setting", for: indexPath)as! SettingTVC
        cell.selectionStyle = .none
        cell.lblName.text = arrList[indexPath.row] as? String
        cell.imgContent.image = UIImage.init(named:arrImages[indexPath.row] as! String)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let vc = LanguageChangeVC()
            vc.delegateLanguage = self
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
        }
        else if indexPath.row == 1{
            let objVC = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as? ChangePasswordVC
            self.navigationController?.pushViewController(objVC!, animated: true)
        }
        
    }
    
    func didSelectLanguage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "OrderHistoryVC") as! OrderHistoryVC
        
        
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
