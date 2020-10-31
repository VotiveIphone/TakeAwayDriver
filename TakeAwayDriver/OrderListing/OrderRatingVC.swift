//
//  OrderRatingVC.swift
//  TakeAway
//
//  Created by mac on 07/01/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Cosmos
import NVActivityIndicatorView
import SDWebImage

protocol DismissReviewViewDelegate {
    func dismissView()
}


class OrderRatingVC: UIViewController,NVActivityIndicatorViewable {

    @IBOutlet weak var lblOrderNo: UILabel!
    @IBOutlet weak var imgRateStatus: UIImageView!
    @IBOutlet weak var viewRating: CosmosView!
    
    @IBOutlet weak var lblRateStatus: UILabel!
    @IBOutlet weak var txtviewComment: UITextView!
    
    var Rest_id:String!
    var Order_id:String!
    var Customer_id:String!
    var Menu_id:String!
    var FinalRating:String!
    var OrderNo:String!
    
    var delegateDismiss : DismissReviewViewDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        FinalRating = "5"
        viewRating.didFinishTouchingCosmos = didFinishTouchingCosmos
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.resignFirstResponder()
//        self.dismiss(animated: true, completion: nil)
//    }
    
    
    func UserRatingService(){
        startAnimating(color:CommonClass().appThemColor)
        var param : [String : Any] = [:]
        
        param = ["user_id" : String(Customer_id),
                 "localization" : String(MyDefaults().LanguageId),
                 "rest_id":String(Rest_id),
                 "order_id":String(Order_id),
                 "rating":String(FinalRating),
                 "review":String(txtviewComment.text!),
                 "diver_id":String(MyDefaults().UserId)
        ]
        
        print(param)
        CommunicationManager().getResponseForParamType(strUrl: CommonClass.UserRatingApi, parameters: param as NSDictionary) { ( result , data) in
            self.stopAnimating()
            if(result == "success") {
                print(data)
                //let dataDict = data["response"] as! NSDictionary
                self.dismiss(animated: true, completion: nil)
                self.delegateDismiss?.dismissView()
                
                
            }else if (result == "error") {
                print(data)
                self.present(CommonClass().Alert(title: "Take Away".localize(), msg: data["msg"] as! String), animated: true, completion: nil)
               /// self.dismiss(animated: true, completion: nil)
                
            }else if (result == "Network") {
                print(data)
                self.present(CommonClass().Alert(title: "Take Away".localize(), msg:"Data Not Found".localize()), animated: true, completion: nil)
               /// self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    
    private func didFinishTouchingCosmos(_ rating: Double) {
        print(Float(rating))
        if Int(rating) == 1{
            imgRateStatus.image = #imageLiteral(resourceName: "imogi_disappoint")
            lblRateStatus.text = "Disappoint".localize()
            FinalRating = String(rating)
        }
        else if Int(rating) == 2{
            imgRateStatus.image = #imageLiteral(resourceName: "imogi_poor")
            lblRateStatus.text = "Poor".localize()
            FinalRating = String(rating)
        }
        else if Int(rating) == 3{
            imgRateStatus.image = #imageLiteral(resourceName: "imogi_notimpress")
            lblRateStatus.text = "Not Impressed".localize()
            FinalRating = String(rating)
        }
        else if Int(rating) == 4{
            imgRateStatus.image = #imageLiteral(resourceName: "imogi_impressed")
            lblRateStatus.text = "Impressed".localize()
            FinalRating = String(rating)
        }
        else if Int(rating) == 5{
            imgRateStatus.image = #imageLiteral(resourceName: "imogi_Perfect")
            lblRateStatus.text = "Perfect".localize()
            FinalRating = String(rating)
            
        }
    }

    @IBAction func SubmitMethod(_ sender: Any) {
        
        if (Reachability.isConnectedToNetwork()){
            self.UserRatingService()
        }
        else{
            self.dismiss(animated: true, completion: nil)
            self.present(CommonClass().Alert(title: "Take Away".localize(), msg:"Internet Connection not Available!".localize()), animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func CancelMethod(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
