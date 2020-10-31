//
//  OrderDetailsVC.swift
//  TakeAwayDriver
//
//  Created by mac on 28/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Cosmos

class OrderListTVC: UITableViewCell {
    @IBOutlet weak var lblDishName: UILabel!
    @IBOutlet weak var lblDishQty: UILabel!
    @IBOutlet weak var lblDishPrice: UILabel!
}

class OrderDetailsVC: UIViewController,NVActivityIndicatorViewable,DismissReviewViewDelegate,OrderStatusChangeDelegate {
    
    
    
    @IBOutlet weak var lblRestraName1: UILabel!
    @IBOutlet weak var lblDriverStatus: UILabel!
    @IBOutlet weak var lblDeliveryTime: UILabel!
    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var btnPhoneNo: UIButton!
    @IBOutlet weak var lblInstruction: UILabel!
    @IBOutlet weak var lblAddressFrom: UILabel!
    @IBOutlet weak var lblAddressTo: UILabel!
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblPayment: UILabel!
    @IBOutlet weak var tblList: UITableView!
    
    @IBOutlet weak var constraintViewOrder: NSLayoutConstraint!
    @IBOutlet weak var viewTotalRating: CosmosView!
    
    var byPage:String!
    var Order_id:String!
    var Rest_id:String!
    var Customer_id:String!
    var dictInfo:NSDictionary!
    var arrDish = [Any]()
    var VC : UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.OrderDetailService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden=true;
       
    }
    
    
    func OrderDetailService(){
        startAnimating(color:CommonClass().appThemColor)
        var param : [String : Any] = [:]

        param = ["user_id" : String(Customer_id),
                "order_id" : String(Order_id),
                "rest_id" : String(Rest_id),
                "localization" : String(MyDefaults().LanguageId)]
        print(param)
        CommunicationManager().getResponseForParamType(strUrl: CommonClass.OrderDetailApi, parameters: param as NSDictionary) { ( result , data) in
            self.stopAnimating()
            if(result == "success") {
                let dataDict = data as! NSDictionary
                print(dataDict)
                self.dictInfo = dataDict.value(forKey: "response") as? NSDictionary
                self.SetInfo()
            }else if (result == "error") {
                print(data)
                self.present(CommonClass().Alert(title: "Take Away".localize(), msg: data["msg"] as! String), animated: true, completion: nil)
            }else if (result == "Network") {
                print(data)
                self.present(CommonClass().Alert(title: "Take Away".localize(), msg:"Data Not Found".localize()), animated: true, completion: nil)
            }
        }
    }
    
    func SetInfo(){
        
        let AddressTo = dictInfo["address"] as? NSDictionary
        let UserInfo = dictInfo["user"] as? NSDictionary
        let UserRating = dictInfo["user_rating"] as? NSDictionary
        
        lblRestraName1.text = CommonClass().toString(dictInfo["rest_name"])
        lblDeliveryTime.text = CommonClass().toString(dictInfo["date"])
        lblCustomerName.text = CommonClass().toString(UserInfo?["fullname"])
        btnPhoneNo.setTitle(String.init(format:"  %@", CommonClass().toString(UserInfo?["mobile"])), for: .normal)
        lblInstruction.text = CommonClass().toString(dictInfo["order_note"])
        lblAddressFrom.text = CommonClass().toString(dictInfo["rest_address"])
        if CommonClass().toString(dictInfo["address_type"]) == "home"{
            lblAddressTo.text = String.init(format:"%@ %@ %@ %@ %@ %@ ",CommonClass().toString(AddressTo?["location_name"]),CommonClass().toString(AddressTo?["floor"]),CommonClass().toString(AddressTo?["wassel_number"]),CommonClass().toString(AddressTo?["apartment_number"]),CommonClass().toString(AddressTo?["landmark"]),CommonClass().toString(AddressTo?["city"]))
        }
        else{
            lblAddressTo.text = String.init(format:"%@ %@ %@ %@ %@ %@ %@ %@ ",CommonClass().toString(AddressTo?["location_name"]),CommonClass().toString(AddressTo?["floor"]),CommonClass().toString(AddressTo?["office_number"]),CommonClass().toString(AddressTo?["department"]),CommonClass().toString(AddressTo?["wassel_number"]),CommonClass().toString(AddressTo?["apartment_number"]),CommonClass().toString(AddressTo?["landmark"]),CommonClass().toString(AddressTo?["city"]))
        }
        
        self.arrDish = dictInfo["items_list"] as! Array
        self.constraintViewOrder.constant = CGFloat(arrDish.count * 40)
        
        lblOrderId.text = CommonClass().toString(dictInfo["order_id"])
        lblPayment.text = String(format:"%@ %@","SAR".localize(),CommonClass().toString(dictInfo["total_price"]))
        
        let rating = CommonClass().toString(UserRating?["rating_value"])
        if rating != "" {
            self.viewTotalRating.rating = Double(rating)!
        }
        else{
            self.viewTotalRating.rating = 0
        }
        
        if CommonClass().toString(dictInfo["driver_order_status"]) == "3"{
            lblDriverStatus.text = "Pick up order".localize()
        }
        else if CommonClass().toString(dictInfo["driver_order_status"]) == "4"{
            lblDriverStatus.text = "On the way".localize()
        }
        else if CommonClass().toString(dictInfo["driver_order_status"]) == "6"{
            lblDriverStatus.text = "Delivered".localize()
        }
        else{
            lblDriverStatus.text = "Update Status".localize()
        }
        
        
        
        self.tblList.reloadData()
    
    }
    func dismissView() {
        self.OrderDetailService()
    }
    func UpdateStatus() {
        self.OrderDetailService()
    }
    
    
    @IBAction func CallMethod(_ sender: Any) {
        let UserInfo = dictInfo["user"] as! NSDictionary
        
        if let url = URL(string: String.init(format:"tel://%@",CommonClass().toString(UserInfo["mobile"]))), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
    }
    
    @IBAction func NavigateCustomerMethod(_ sender: Any) {
        let AddressTo = dictInfo["address"] as! NSDictionary
        
        let lat = CommonClass().toString(AddressTo["latitude"])
        let lng = CommonClass().toString(AddressTo["longitude"])
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
            UIApplication.shared.openURL(NSURL(string:
                        "comgooglemaps://?saddr=&daddr=\(lat),\(lng)&directionsmode=driving")! as URL)
                    
        } else {
            UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=loc:\(lat),\(lng)&zoom=14&views=traffic")!, options: [:], completionHandler: nil)
        }
        
    }
    
    @IBAction func UpdateStatusMethod(_ sender: Any) {
        if CommonClass().toString(dictInfo["current_order_status"]) != "6"{
            let vc = UpdateStatusPopupVC()
            vc.Order_id = self.Order_id
            vc.DriverStatus = CommonClass().toString(dictInfo["driver_order_status"])
            vc.RatingStatus = CommonClass().toString(dictInfo["user_rating_status"])
            vc.delegateOrderStatus = self
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func RateUserMethod(_ sender: Any) {
        if CommonClass().toString(dictInfo["user_rating_status"]) != "1"{
            let vc = OrderRatingVC()
            vc.Rest_id = self.Rest_id
            vc.Order_id = self.Order_id
            vc.Customer_id = self.Customer_id
            vc.delegateDismiss = self
            vc.OrderNo = String.init(format:"%@ %@","Order No".localize(),CommonClass().toString(dictInfo["bill_id"]))
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func BackMethod(_ sender: Any) {
        
        if byPage == "Home"{
            let ViewController = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            VC = UINavigationController(rootViewController:ViewController)
            self.slideMenuController()?.changeMainViewController(VC, close: true)
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
    }

}
extension OrderDetailsVC : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDish.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"OrderList", for: indexPath)as! OrderListTVC
        cell.selectionStyle = .none
        if arrDish.count > 0{
            let dictInfo = arrDish[indexPath.row] as! NSDictionary
            cell.lblDishName.text = CommonClass().toString(dictInfo["menu_name"])
            cell.lblDishQty.text = String.init(format: "Qty:%@",CommonClass().toString(dictInfo["menu_quantity"]))
            cell.lblDishPrice.text = String(format:"%@ %@","SAR".localize(),CommonClass().toString(dictInfo["menu_price"]))
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
}
