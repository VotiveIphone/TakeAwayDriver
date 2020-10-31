//
//  SliderVC.swift
//  TakeAway
//
//  Created by mac on 15/10/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import SDWebImage

class SliderTVC: UITableViewCell {
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var imgContent: UIImageView!
    
}



class SliderVC: UIViewController,UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    var arrList = [Any]()
    var arrImages = [Any]()
    var VC : UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if MyDefaults().UserProfile != nil{
            imgProfile.sd_setImage(with: URL(string:String.init(format: "%@",MyDefaults().UserProfile)), placeholderImage:UIImage(named: "Profile_icon"))
        }
        if MyDefaults().UserName != nil{
            lblName.text = MyDefaults().UserName
        }
        
        arrList = ["Home".localize(),"Order History".localize(),"Setting".localize(),"Logout".localize()]
        arrImages = ["SmHome_icon","SmOrderHistory_icon","SmSetting_icon","SmLogOut"]
        
        tblList.reloadData()
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:SliderTVC = tableView.dequeueReusableCell(withIdentifier: ("Slider")) as! SliderTVC
        cell.lblContent.text = arrList[indexPath.row] as? String
        cell.imgContent.image = UIImage.init(named:arrImages[indexPath.row] as! String)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ViewController = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let nav = UINavigationController(rootViewController:ViewController)
        nav.navigationBar.isHidden = true
        nav.navigationBar.barTintColor = UIColor(red: 200/255, green: 162/255, blue: 113/255, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white]
        //self.slideMenuController()?.changeMainViewController(nav, close: true)
        
        if (indexPath.section==0) {
            switch (indexPath.row)
            {
            case 0:
                self.slideMenuController()?.changeMainViewController(nav, close: true)
                break;
                
            case 1:
                let ViewController = storyboard.instantiateViewController(withIdentifier: "OrderHistoryVC") as! OrderHistoryVC
                self.VC = UINavigationController(rootViewController:ViewController)
                self.slideMenuController()?.changeMainViewController(self.VC, close: true)
                
                break;
                
            case 2:
                let ViewController = storyboard.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
                self.VC = UINavigationController(rootViewController:ViewController)
                self.slideMenuController()?.changeMainViewController(self.VC, close: true)
                break;
            
           case 3:
            
                MyDefaults().isLogin = false
                let ViewController = storyboard.instantiateViewController(withIdentifier: "LanguageVC") as! LanguageVC
                self.VC = UINavigationController(rootViewController:ViewController)
                self.slideMenuController()?.changeMainViewController(self.VC, close: true)
            

                break;
            default:
                break;
                
            }
        }
 
    }
   

}
