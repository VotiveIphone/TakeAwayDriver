//
//  OrderHistoryVC.swift
//  TakeAwayDriver
//
//  Created by mac on 28/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import ESPullToRefresh

class OrderHistoryVC: UIViewController,NVActivityIndicatorViewable {

    @IBOutlet weak var tblViewForOrderHistory: UITableView!
    var arrList = [Any]()
    var pagenumber = 0
    var maxPagecount = 0
    var currentPage = 0
    var firstTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblViewForOrderHistory.delegate = self
        self.tblViewForOrderHistory.dataSource = self
        

        self.OrderHistoryListService()
        self.RefreshSetup()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden=true;
       
    }
    
    func RefreshSetup(){
        var header: ESRefreshProtocol & ESRefreshAnimatorProtocol
        var footer: ESRefreshProtocol & ESRefreshAnimatorProtocol
        header = ESRefreshHeaderAnimator.init(frame: CGRect.zero)
        footer = ESRefreshFooterAnimator.init(frame: CGRect.zero)
        
        self.tblViewForOrderHistory.es.addPullToRefresh (animator: header) { [weak self] in
            self?.refresh()
        }
        self.tblViewForOrderHistory.es.addInfiniteScrolling (animator: footer) { [weak self] in
            self?.loadMore()
        }
        
        
    }
    
    private func refresh() {
        print(index)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.pagenumber = 0
            self.currentPage = 0
            self.arrList = []
            self.OrderHistoryListService()
            self.tblViewForOrderHistory.es.stopPullToRefresh()
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
                self.OrderHistoryListService()
                self.tblViewForOrderHistory.es.stopLoadingMore()
                
            }else{
                self.tblViewForOrderHistory.es.noticeNoMoreData()
            }
        }
    }
    
    
    func OrderHistoryListService(){
        startAnimating(color:CommonClass().appThemColor)
        var param : [String : Any] = [:]
        
        param = ["diver_id" : String(MyDefaults().UserId),
                "localization" : String(MyDefaults().LanguageId),
                "page":String(currentPage)
                ]
        print(param)
        CommunicationManager().getResponseForParamType(strUrl: CommonClass.OrderHistoryApi, parameters: param as NSDictionary) { ( result , data) in
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
                    self.tblViewForOrderHistory.reloadData()
                    
                }
                
                self.tblViewForOrderHistory.reloadData()
                
            }else if (result == "error") {
                print(data)
                self.EmptyCartScreen()
            }else if (result == "Network") {
                print(data)
                self.present(CommonClass().Alert(title: "Take Away".localize(), msg:"Data Not Found".localize()), animated: true, completion: nil)
            }
        }
    }
    
    func EmptyCartScreen() {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmptyViewVC") as! EmptyViewVC
        popOverVC.byPage = "OrderHistory"
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

extension OrderHistoryVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderHistoryCell", for: indexPath) as! OrderHistoryCell
        if arrList.count > 0 {
            let dictInfo = arrList[indexPath.row] as! NSDictionary
            cell.lblName.text = CommonClass().toString(dictInfo["user_name"])
            cell.lblDateTime.text = CommonClass().toString(dictInfo["date"])
            cell.lblOrderID.text = CommonClass().toString(dictInfo["date"])
            cell.lblOrderStatus.text = "Delivered".localize()
        }
        
        cell.btnViewDetail.tag = indexPath.row
        cell.btnViewDetail.addTarget(self, action: #selector(ViewOrderMethod(button:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let dictInfo = arrList[indexPath.row] as! NSDictionary
//        let objVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderDetailsVC") as? OrderDetailsVC
//        objVC?.Rest_id = CommonClass().toString(dictInfo["rest_id"])
//        objVC?.Order_id = CommonClass().toString(dictInfo["order_id"])
//        objVC?.Customer_id = CommonClass().toString(dictInfo["user_id"])
//        self.navigationController?.pushViewController(objVC!, animated: true)
    }
    
    @IBAction func ViewOrderMethod(button: UIButton){
        let dictInfo = arrList[button.tag] as! NSDictionary
        let objVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderDetailsVC") as? OrderDetailsVC
        objVC?.Rest_id = CommonClass().toString(dictInfo["rest_id"])
        objVC?.Order_id = CommonClass().toString(dictInfo["order_id"])
        objVC?.Customer_id = CommonClass().toString(dictInfo["user_id"])
        self.navigationController?.pushViewController(objVC!, animated: true)
    }
    
    
}

class OrderHistoryCell: UITableViewCell {
    
    @IBOutlet weak var btnViewDetail: UIButton!
    @IBOutlet weak var lblOrderStatus: UILabel!
    @IBOutlet weak var lblOrderID: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    
}
