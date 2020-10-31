//
//  EmptyViewVC.swift
//  TakeAwayDriver
//
//  Created by mac on 29/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class EmptyViewVC: UIViewController {

    @IBOutlet weak var lblStatus: UILabel!
    var byPage:String!
    var VC : UIViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if byPage == "Home"{
            lblStatus.text = "Hmm, Looks like you haven't available any assigned orders".localize()
        }
        else if byPage == "OrderHistory"{
            lblStatus.text = "Hmm, Looks like you haven't available any orders history".localize()
        }
        else{
            lblStatus.text = "No order found".localize()
        }
        
    }
    
    @IBAction func BackMethod(_ sender: Any) {
        if MyDefaults().LanguageId == "ar"{
            slideMenuController()?.toggleRight()
        }
        else{
            slideMenuController()?.toggleLeft()
        }
    }


}
