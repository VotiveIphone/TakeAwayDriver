//
//  UpdateStatusPopupVC.swift
//  TakeAwayDriver
//
//  Created by mac on 29/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol OrderStatusChangeDelegate {
    func UpdateStatus()
}

class UpdateStatusPopupVC: UIViewController,NVActivityIndicatorViewable {

    @IBOutlet weak var btnDelivered: UIButton!
    @IBOutlet weak var btnPickUp: UIButton!
    @IBOutlet weak var btnOnTheWay: UIButton!
    var delegateOrderStatus : OrderStatusChangeDelegate?
    var Order_id:String!
    var DriverStatus:String!
    var RatingStatus:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if DriverStatus == "3"{
            self.btnPickUp.isSelected = true
            self.btnOnTheWay.isSelected = false
            self.btnDelivered.isSelected = false
        }
        else if DriverStatus == "4"{
            self.btnOnTheWay.isSelected = true
            self.btnPickUp.isSelected = true
            self.btnDelivered.isSelected = false
        }
        else if DriverStatus == "6"{
            self.btnOnTheWay.isSelected = true
            self.btnPickUp.isSelected = true
            self.btnDelivered.isSelected = true
        }
        

    }
    
    func OrderStatusService(status:String,order_id:String){
        startAnimating(color:CommonClass().appThemColor)
        var param : [String : Any] = [:]
        
        param = ["diver_id" : String(MyDefaults().UserId),
                "order_id" : String(order_id),
                "driver_order_status" : String(status),
                "localization" : String(MyDefaults().LanguageId)]
        print(param)
        CommunicationManager().getResponseForParamType(strUrl: CommonClass.OrderStatusApi, parameters: param as NSDictionary) { ( result , data) in
            self.stopAnimating()
            if(result == "success") {
                
                let dataDict = data as! NSDictionary
                print(dataDict)
                //self.dismiss(animated: true, completion: nil)
                self.delegateOrderStatus?.UpdateStatus()
                self.dismiss(animated: true, completion: nil)
                
            }else if (result == "error") {
                print(data)
                self.present(CommonClass().Alert(title: "Take Away".localize(), msg: data["msg"] as! String), animated: true, completion: nil)
            }else if (result == "Network") {
                print(data)
                self.present(CommonClass().Alert(title: "Take Away".localize(), msg:"Data Not Found".localize()), animated: true, completion: nil)
            }
        }
    }
    

    @IBAction func btnActionToPickUp(_ sender: UIButton) {
//        if self.btnPickUp.isSelected {
//            self.btnPickUp.isSelected = false
//        }else{
//            self.btnPickUp.isSelected = true
//            self.btnOnTheWay.isSelected = false
//            self.btnDelivered.isSelected = false
//        }
        if DriverStatus != "3" && DriverStatus != "4" && DriverStatus != "6"{
            self.btnPickUp.isSelected = true
            self.OrderStatusService(status: "3", order_id: Order_id)
        }
        
    }
    
    @IBAction func btnActionToOnTheWay(_ sender: UIButton) {
//        if self.btnOnTheWay.isSelected {
//            self.btnOnTheWay.isSelected = false
//        }else{
//            self.btnOnTheWay.isSelected = true
//            self.btnPickUp.isSelected = false
//            self.btnDelivered.isSelected = false
//        }
        
        if DriverStatus != "4" && DriverStatus != "6"{
            self.btnOnTheWay.isSelected = true
            self.OrderStatusService(status: "4", order_id: Order_id)
        }
    }
    
    @IBAction func btnActionToDelivered(_ sender: UIButton) {
//        if self.btnDelivered.isSelected {
//            self.btnDelivered.isSelected = false
//        }else{
//            self.btnDelivered.isSelected = true
//            self.btnOnTheWay.isSelected = false
//            self.btnPickUp.isSelected = false
//        }
        
        if RatingStatus == "1"{
            if DriverStatus != "6"{
                self.btnDelivered.isSelected = true
                self.OrderStatusService(status: "6", order_id: Order_id)
            }
        }
        else{
            let alertController = UIAlertController(title: "Take Away".localize(), message: "First rate customer then you can change status to delivered".localize(), preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok".localize(), style: UIAlertAction.Style.default) {
                UIAlertAction in
                self.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
}
