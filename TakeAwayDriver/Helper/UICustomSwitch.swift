//
//  UICustomSwitch.swift
//  grup
//
//  Created by mac on 18/12/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class UICustomSwitch : UISwitch {
    
    @IBInspectable var OnColor : UIColor! = UIColor(red: 0.0/255.0, green: 97.0/255.0, blue: 168.0/255.0, alpha: 0.2)
    @IBInspectable var OffColor : UIColor! = UIColor(red: 228.0/255.0, green: 228.0/255.0, blue: 228.0/255.0, alpha: 1.0)
    
    @IBInspectable var onThumbTintColor : UIColor! = UIColor(red: 0.0/255.0, green: 97.0/255.0, blue: 168.0/255.0, alpha: 1.0)
    @IBInspectable var offThumbTintColor : UIColor! = UIColor(red: 119.0/255.0, green: 119.0/255.0, blue: 119.0/255.0, alpha: 1.0)
   
   // @IBInspectable var Scale : CGFloat! = 1.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpCustomUserInterface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUpCustomUserInterface()
    }
    
    
    func setUpCustomUserInterface() {
        
        //clip the background color
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        
        //Scale down to make it smaller in look
        self.transform = CGAffineTransform(scaleX: 0.75, y: 0.75);
        
        //add target to get user interation to update user-interface accordingly
        self.addTarget(self, action: #selector(UICustomSwitch.updateUI), for: UIControl.Event.valueChanged)
        
        //set onTintColor : is necessary to make it colored
        self.onTintColor = self.OnColor
        
        //setup to initial state
        self.updateUI()
    }
    
    //to track programatic update
    override func setOn(_ on: Bool, animated: Bool) {
        super.setOn(on, animated: true)
        updateUI()
    }
    
    //Update user-interface according to on/off state
    @objc func updateUI() {
        if self.isOn == true {
            self.backgroundColor = self.OnColor
            self.thumbTintColor = self.onThumbTintColor
        }
        else {
            self.backgroundColor = self.OffColor
            self.thumbTintColor = self.offThumbTintColor
        }
    }
}
