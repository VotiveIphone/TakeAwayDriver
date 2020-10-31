//
//  NotificationVC.swift
//  TakeAwayDriver
//
//  Created by mac on 29/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SlideMenuControllerSwift
import ESPullToRefresh

class NotificationVC: UIViewController,NVActivityIndicatorViewable {

    @IBOutlet weak var tblViewForNotification: UITableView!
    var VC : UIViewController!
    var arrList = [Any]()
    var pagenumber = 0
    var maxPagecount = 0
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblViewForNotification.delegate = self
        self.tblViewForNotification.dataSource = self
        
        SlideMenuOptions.panFromBezel = false
        SlideMenuOptions.rightPanFromBezel = false
        
        self.AdminOrderListService()
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
        
        self.tblViewForNotification.es.addPullToRefresh (animator: header) { [weak self] in
            self?.refresh()
        }
        self.tblViewForNotification.es.addInfiniteScrolling (animator: footer) { [weak self] in
            self?.loadMore()
        }
        
        
    }
    
    private func refresh() {
        print(index)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.pagenumber = 0
            self.currentPage = 0
            self.arrList = []
            self.AdminOrderListService()
            self.tblViewForNotification.es.stopPullToRefresh()
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
                self.AdminOrderListService()
                self.tblViewForNotification.es.stopLoadingMore()
                
            }else{
                self.tblViewForNotification.es.noticeNoMoreData()
            }
        }
    }
    
    
    func AdminOrderListService(){
        startAnimating(color:CommonClass().appThemColor)
        var param : [String : Any] = [:]
        
        param = ["localization" : String(MyDefaults().LanguageId),
                "page":String(currentPage)
                ]
        print(param)
        CommunicationManager().getResponseForParamType(strUrl: CommonClass.AdminOrderListApi, parameters: param as NSDictionary) { ( result , data) in
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
                    self.tblViewForNotification.reloadData()
                    
                }
                
                self.tblViewForNotification.reloadData()
                
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
        popOverVC.byPage = "Admin"
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    
    @IBAction func AdminMoreAccessMethod(_ sender: Any) {
        let objVC = self.storyboard?.instantiateViewController(withIdentifier: "AdminAccessVC") as? AdminAccessVC
        objVC?.webUrl = CommonClass.AdminUrl
        self.navigationController?.pushViewController(objVC!, animated: true)
    }
    
    @IBAction func LogoutMethod(_ sender: Any) {
        MyDefaults().isLogin = false
        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "LanguageVC") as! LanguageVC
        let nav = UINavigationController(rootViewController:ViewController)
        nav.navigationBar.isHidden = true
        self.slideMenuController()?.changeMainViewController(nav, close: true)
    }

}

extension NotificationVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        if arrList.count > 0{
            let dictInfo = arrList[indexPath.row] as? NSDictionary
            cell.lblRestaurent.text = CommonClass().toString(dictInfo?["rest_name"])
            cell.lblOrderID.text = CommonClass().toString(dictInfo?["order_id"])
            cell.lblOrderType.text = CommonClass().toString(dictInfo?["payment_mode"])
            cell.lblAmount.text = String(format:"%@ %@","SAR".localize(),CommonClass().toString(dictInfo?["total_amount"]))
            
            if CommonClass().toString(dictInfo?["order_get"]) == "order_delivery"{
                cell.lblName.text = String.init(format:"%@-%@","Driver Name".localize(),CommonClass().toString(dictInfo?["diver_name"]))
            }
            else{
                cell.lblName.text = String.init(format:"%@-%@","User Name".localize(),CommonClass().toString(dictInfo?["user_name"]))
            }
            
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
        
    }
}

class NotificationCell: UITableViewCell {
    
    @IBOutlet weak var lblRestaurent: UILabel!
    @IBOutlet weak var lblOrderType: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblOrderID: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
}
