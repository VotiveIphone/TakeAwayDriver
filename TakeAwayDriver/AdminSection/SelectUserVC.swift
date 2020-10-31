//
//  SelectUserVC.swift
//  TakeAwayDriver
//
//  Created by mac on 30/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class SelectUserVC: UIViewController {

    var VC : UIViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden=true;
       
    }
    
    @IBAction func AdminMethod(_ sender: Any) {
        MyDefaults().UserType = "Admin"
        let objVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
        self.navigationController?.pushViewController(objVC!, animated: true)
    }
    
    @IBAction func DriverMethod(_ sender: Any) {
        MyDefaults().UserType = "Driver"
        let objVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
        self.navigationController?.pushViewController(objVC!, animated: true)
        
    }
    
    @IBAction func BackMethod(_ sender: Any) {
        let ViewController = storyboard?.instantiateViewController(withIdentifier: "LanguageVC") as! LanguageVC
        VC = UINavigationController(rootViewController:ViewController)
        self.slideMenuController()?.changeMainViewController(VC, close: true)
    }

}
