//
//  MyDefaults.swift
//  SwiftDefaults
//
//  Created by 杉本裕樹 on 2016/01/12.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import SwiftDefaults

class MyDefaults: SwiftDefaults {
    @objc dynamic var value: String? = "10"
    @objc dynamic var isLogin:Bool=false
    @objc dynamic var UserType: String!
    @objc dynamic var UserId: String!
    @objc dynamic var UserName: String!
    @objc dynamic var UserProfile: String!
    @objc dynamic var UserEmail: String!
    @objc dynamic var UserLat: String!
    @objc dynamic var UserLong: String!
    @objc dynamic var LanguageId: String!
    @objc dynamic var MobileNo: String!
    @objc dynamic var RefreshToken: String!
}

