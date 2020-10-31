//
//  HomeVC.swift
//  TakeAwayDriver
//
//  Created by mac on 27/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import ESPullToRefresh

class HomeVC: UIViewController,NVActivityIndicatorViewable {
    
    @IBOutlet weak var tblViewHome: UITableView!
    var VC : UIViewController!
    var arrList = [Any]()
    var pagenumber = 0
    var maxPagecount = 0
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.setStatusBarStyle(.lightContent)
        
        self.tblViewHome.delegate = self
        self.tblViewHome.dataSource = self
        
        self.CurrentOrderListService()
        self.RefreshSetup()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden=true;
       
    }
    
    func RefreshSetup(){
        var header: ESRefreshProtocol & ESRefreshAnimatorProtocol
        var footer: ESRefreshProtocol & ESRefreshAnimatorProtocol
        header = ESRefreshHeaderAnimator.init(frame: CGRect.zero)
        footer = ESRefreshFooterAnimator.init(frame: CGRect.zero)
        
        self.tblViewHome.es.addPullToRefresh (animator: header) { [weak self] in
            self?.refresh()
        }
        self.tblViewHome.es.addInfiniteScrolling (animator: footer) { [weak self] in
            self?.loadMore()
        }
        
        
    }
    
    private func refresh() {
        print(index)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.pagenumber = 0
            self.currentPage = 0
            self.arrList = []
            self.CurrentOrderListService()
            self.tblViewHome.es.stopPullToRefresh()
        }
    }
    
    private func loadMore() {
        print(index)
        print(maxPagecount)
        print(pagenumber)
        print(currentPage)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            //            var count = self.maxPagecount%20
            //            if count != 0{
            //                count = count + 1
            //            }
            self.currentPage += 1
            if self.currentPage <= self.maxPagecount{
                self.CurrentOrderListService()
                self.tblViewHome.es.stopLoadingMore()
                
            }else{
                self.tblViewHome.es.noticeNoMoreData()
            }
        }
    }
    
    
    func CurrentOrderListService(){
        startAnimating(color:CommonClass().appThemColor)
        var param : [String : Any] = [:]
        
        param = ["diver_id" : String(MyDefaults().UserId),
                "localization" : String(MyDefaults().LanguageId),
                "page":String(currentPage)
                ]
        print(param)
        CommunicationManager().getResponseForParamType(strUrl: CommonClass.CurrentOrderApi, parameters: param as NSDictionary) { ( result , data) in
            self.stopAnimating()
            if(result == "success") {
                let dataDict = data as! NSDictionary
                print(dataDict)
                //self.arrList = dataDict.value(forKey: "response") as! Array
                
                let totalreview = CommonClass().toString(dataDict["total_page"])
                self.maxPagecount = Int(totalreview)!
                
                if self.currentPage <= self.maxPagecount{
                    
                    let arrTemp = dataDict.value(forKey:"response") as! Array<Any>
                    for review in arrTemp{
                        self.arrList.append(review)
                    }
                    self.tblViewHome.reloadData()
                    
                }
                
                self.tblViewHome.reloadData()
                
            }else if (result == "error") {
                print(data)
                self.EmptyCartScreen()
            }else if (result == "Network") {
                print(data)
                self.present(CommonClass().Alert(title: "Take Away".localize(), msg:"Data Not Found".localize()), animated: true, completion: nil)
            }
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
                self.CurrentOrderListService()
                //let responce = dataDict.value(forKey: "response") as! NSDictionary
                
                
                
                
            }else if (result == "error") {
                print(data)
                self.present(CommonClass().Alert(title: "Take Away".localize(), msg: data["msg"] as! String), animated: true, completion: nil)
            }else if (result == "Network") {
                print(data)
                self.present(CommonClass().Alert(title: "Take Away".localize(), msg:"Data Not Found".localize()), animated: true, completion: nil)
            }
        }
    }
    
    
    func EmptyCartScreen() {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmptyViewVC") as! EmptyViewVC
        popOverVC.byPage = "Home"
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
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

extension HomeVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableCell
        if arrList.count > 0 {
            let dictInfo = arrList[indexPath.row] as! NSDictionary
            cell.lblName.text = CommonClass().toString(dictInfo["user_name"])
            cell.lblDateTime.text = CommonClass().toString(dictInfo["date"])
            cell.lblOrderID.text = CommonClass().toString(dictInfo["order_id"])
            cell.lblOrderAmount.text = String(format:"%@ %@","SAR".localize(),CommonClass().toString(dictInfo["total_amount"]))
            cell.lblPaymentType.text = CommonClass().toString(dictInfo["payment_mode"])
            cell.lblAddress.text = String.init(format:"%@ %@ %@ ",CommonClass().toString(dictInfo["location_name"]),CommonClass().toString(dictInfo["landmark"]),CommonClass().toString(dictInfo["city"]))
            
            if CommonClass().toString(dictInfo["order_status"]) == "7"{
                cell.btnViewDetail.isHidden = false
            }
            else{
                cell.btnViewDetail.isHidden = true
            }
        }
        cell.btnAccept.tag = indexPath.row
        cell.btnAccept.addTarget(self, action: #selector(AcceptMethod(button:)), for: .touchUpInside)
        
        cell.btnReject.tag = indexPath.row
        cell.btnReject.addTarget(self, action: #selector(RejectMethod(button:)), for: .touchUpInside)
        
        cell.btnViewDetail.tag = indexPath.row
        cell.btnViewDetail.addTarget(self, action: #selector(ViewDetailMethod(button:)), for: .touchUpInside)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 287
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let dictInfo = arrList[indexPath.row] as! NSDictionary
//        let objVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderDetailsVC") as? OrderDetailsVC
//        objVC?.Rest_id = CommonClass().toString(dictInfo["rest_id"])
//        objVC?.Order_id = CommonClass().toString(dictInfo["order_id"])
//        objVC?.Customer_id = CommonClass().toString(dictInfo["user_id"])
//        self.navigationController?.pushViewController(objVC!, animated: true)
    }
    
    @IBAction func AcceptMethod(button: UIButton){
        let dictInfo = self.arrList[button.tag] as! NSDictionary
        self.OrderStatusService(status: "1", order_id: CommonClass().toString(dictInfo["order_id"]))
    }
    
    @IBAction func RejectMethod(button: UIButton){
        let dictInfo = self.arrList[button.tag] as! NSDictionary
        let alertController = UIAlertController(title: "Take Away".localize(), message: "Are you sure you want to reject this order?".localize(), preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok".localize(), style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.OrderStatusService(status: "2", order_id: CommonClass().toString(dictInfo["order_id"]))
        }
        let cancelAction = UIAlertAction(title: "Cancel".localize(), style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func ViewDetailMethod(button: UIButton){
        let dictInfo = arrList[button.tag] as! NSDictionary
//        let objVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderDetailsVC") as? OrderDetailsVC
//        objVC?.Rest_id = CommonClass().toString(dictInfo["rest_id"])
//        objVC?.Order_id = CommonClass().toString(dictInfo["order_id"])
//        objVC?.Customer_id = CommonClass().toString(dictInfo["user_id"])
//        self.navigationController?.pushViewController(objVC!, animated: true)
        
        
        let ViewController = storyboard?.instantiateViewController(withIdentifier: "OrderDetailsVC") as? OrderDetailsVC
        ViewController?.Rest_id = CommonClass().toString(dictInfo["rest_id"])
        ViewController?.Order_id = CommonClass().toString(dictInfo["order_id"])
        ViewController?.Customer_id = CommonClass().toString(dictInfo["user_id"])
        ViewController?.byPage = "Home"
        VC = UINavigationController(rootViewController:ViewController!)
        self.slideMenuController()?.changeMainViewController(VC, close: true)
        
        
    }
    
    
}

class HomeTableCell: UITableViewCell {
    
    @IBOutlet weak var btnReject: UIButton!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnViewDetail: UIButton!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPaymentType: UILabel!
    @IBOutlet weak var lblOrderAmount: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblOrderID: UILabel!
    
}
