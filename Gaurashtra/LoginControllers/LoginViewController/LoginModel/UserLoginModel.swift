//
//  UserLoginModel.swift
//  YiwuLife
//
//  Created by mac  on 6/25/18.
//  Copyright © 2018 mac . All rights reserved.
// kCustomer_id customer_id

import Foundation
import UIKit

class LoginDataModel
{
    var firstName            : String!
    var lastName             : String!
    var customer_id          : String!
    var telephone            : String!
    var email                : String!
   
    
    init(_ loginDataDetail :Dictionary<String, Any>, andSaveUserProfile isProfileSaved: Bool)
    {
        firstName         = String.getString(loginDataDetail[kFirstName])
        lastName          = String.getString(loginDataDetail[kLastName])
        email             = String.getString(loginDataDetail[kEmail])
        customer_id       = String.getString(loginDataDetail[kCustomer_id])
        telephone         = String.getString(loginDataDetail[kTelephone])
        

        if isProfileSaved
        {
        
            kSharedUserDefaults.setLoggedInUserDetails(loggedInUserDetails: loginDataDetail)
        }
    }
    static func getLoggedInUserDetails() -> LoginDataModel
    {
        return LoginDataModel.init(kSharedUserDefaults.getLoggedInUserDetails(), andSaveUserProfile: false)
    }
}
