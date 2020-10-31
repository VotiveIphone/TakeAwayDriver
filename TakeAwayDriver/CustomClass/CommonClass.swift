//
//  CommonClass.swift
//  EasyDukan
//
//  Created by admin on 24/01/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import Alamofire
import Localize

class CommonClass: NSObject {
    
    static let AppName : NSString = "TakeAway"
    static let BaseUrl = "http://votivelaravel.in/take_away/api/"
    static let AdminUrl = "http://votivelaravel.in/take_away/admin/login"
    //static let BaseUrl = "https://theocean-sa.com/api/"
    
    
    static let LoginApi = BaseUrl + "diver_login"
    static let LoginAdminApi = BaseUrl + "admin_login"
    static let ChangePasswordApi = BaseUrl + "diver_changepassword"
    static let OrderHistoryApi = BaseUrl + "diver_order_complete_listing"
    static let CurrentOrderApi = BaseUrl + "diver_order_history"
    static let OrderDetailApi = BaseUrl + "driver_order_detail"
    static let UserRatingApi = BaseUrl + "user_rating_review"
    static let OrderStatusApi = BaseUrl + "driver_order_status_update"
    
    static let AdminOrderListApi = BaseUrl + "admin_order_history"
    
    static let DeviceID = UIDevice.current.identifierForVendor!.uuidString
    static let noInternet = "Internet Connection not Available!"
    
    //let appThemColor = UIColor(red: 67.0/255.0, green: 67.0/255.0, blue: 67.0/255.0, alpha: 1.0)
    
    let appThemColor = UIColor.white
    
    struct Connectivity {
        static let sharedInstance = NetworkReachabilityManager()!
        static var isConnectedToInternet:Bool {
            return self.sharedInstance.isReachable
        }
    }
    
    func Alert(title:String, msg:String) ->UIAlertController{
        let alertController = UIAlertController(title:title, message: msg, preferredStyle:UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: "OK".localize(), style: UIAlertAction.Style.default)
        { action -> Void in
            // Put your code here
        })
        return alertController
    }
    
    func toString(_ value: Any?) -> String {
        return String(describing: value ?? "")
    }
    
}
