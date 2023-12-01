//
//  CurrencySaveModel.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 25/01/20.
//  Copyright © 2020 Gaurashtra. All rights reserved.
//
/*
 
      title         = String.getString(currencyDataDetail["title"])
      code          = String.getString(currencyDataDetail["code"])
      value         = String.getString(currencyDataDetail["value"])
      symbol        = String.getString(currencyDataDetail["symbol"])
 
 */


 

import Foundation
import UIKit

class CurrencyDataModel
{
    var title            : String!
    var code             : String!
    var value            : String!
    var symbol           : String!
  
  
    
       init(_ currencyDataDetail :Dictionary<String, Any>, andSaveCurrency isCurrencySaved: Bool)
       {
        title         = String.getString(currencyDataDetail["title"])
        code          = String.getString(currencyDataDetail["code"])
        value         = String.getString(currencyDataDetail["value"])
        symbol        = String.getString(currencyDataDetail["symbol"])
        
        

        if isCurrencySaved
        {
        
           // kSharedUserDefaults.setLoggedInUserDetails(loggedInUserDetails: currencyDataDetail)
            
            kSharedUserDefaults.setCurrencyDetails(currencyDetails: currencyDataDetail)
        }
    }
    static func getCurrencySavedDetails() -> CurrencyDataModel
    {
      //  return LoginDataModel.init(kSharedUserDefaults.getLoggedInUserDetails(), andSaveUserProfile: false)
        
        return CurrencyDataModel.init(kSharedUserDefaults.getCurrencySavedDetails(), andSaveCurrency: false)
    }
}
