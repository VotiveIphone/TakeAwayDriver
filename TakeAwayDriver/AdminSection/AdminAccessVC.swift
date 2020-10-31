//
//  AdminAccessVC.swift
//  TakeAwayDriver
//
//  Created by mac on 30/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import WebKit

class AdminAccessVC: UIViewController,WKNavigationDelegate,NVActivityIndicatorViewable {
    
    @IBOutlet weak var viewWeb: WKWebView!
    var webUrl:String!

    override func viewDidLoad() {
        super.viewDidLoad()

        startAnimating(color:CommonClass().appThemColor)
        let url = URL (string: webUrl)
        viewWeb.navigationDelegate = self;
        viewWeb.load(URLRequest(url: url!))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden=true;
       
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.stopAnimating()
    }
    
    @IBAction func BackMethod(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
