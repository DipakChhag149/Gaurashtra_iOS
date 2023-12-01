//
//  PaytmVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 28/02/20.
//  Copyright © 2020 Gaurashtra. All rights reserved.
//

import UIKit
//import PaymentSDK
//,UITabBarControllerDelegate,PGTransactionDelegate

class PaytmVC: GaurashtraBaseVC {
//    var serv          = PGServerEnvironment()
//    var txnController : PGTransactionViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
     
    @IBAction func paymentBtn(_ sender: UIButton) {
       // self.beginPayment()
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
//    private func setupPaytm() {
//
//           serv = serv.createStagingEnvironment()
//           let type :ServerType = .eServerTypeStaging
//           let order = PGOrder(orderID: "", customerID: "", amount: "", eMail: "", mobile: "")
//
//           order.params = ["MID":"rxazcv89315285234363",
//                           "ORDER_ID":"order1",
//                           "CUST_ID": "121",
//                           "CHANNEL_ID":"WAP",
//                           "INDUSTRY_TYPE_ID":"Retail",
//                           "WEBSITE": "APP_STAGING",
//                           "TXN_AMOUNT": "1024",
//                           "CHECKSUMHASH":"oCDBVF+hvVb68JvzbKI40TOtcxlNjMdixi9FnRSh80Ub7XfjvgNr9NrfrOCPLmt65UhStCkrDnlYkclz1qE0uBMOrmuKLGlybuErulbLYSQ=",
//                           "CALLBACK_URL" :"https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=order1"]
//
//        self.txnController =  self.txnController?.initTransaction(for: order) as?PGTransactionViewController
//        self.txnController?.title = "Paytm Payments"
//        self.txnController?.setLoggingEnabled(true)
//
//           if(type != ServerType.eServerTypeNone) {
//            self.txnController?.serverType = type;
//           } else {
//               return
//           }
//
//        self.txnController?.merchant = PGMerchantConfiguration.defaultConfiguration()
//        self.txnController?.delegate = self
//
//        self.navigationController?.pushViewController(self.txnController!, animated: true)
//
//       }
    
    //#MARK:   beginPayment 
//       func beginPayment() {
//           serv = serv.createProductionEnvironment()
//           let type :ServerType = .eServerTypeProduction
//           let order = PGOrder(orderID: "", customerID: "", amount: "", eMail: "", mobile: "")
//           order.params = ["MID" : "GAURAS14176022044176",
//               "ORDER_ID"        : "19677",
//               "CUST_ID"         : "5800",
//               "MOBILE_NO"       : "9910826821",
//               "EMAIL"           : "sunish141991@gmail.com",
//               "CHANNEL_ID"      : "WAP",
//               "WEBSITE"         : "APPSTAGING",
//               "TXN_AMOUNT"      : "1455.999902",
//               "INDUSTRY_TYPE_ID": "Retail",
//               "CHECKSUMHASH"    : "eQH4KZuSpFX9To06wF5YTzmQzyah+Q6GOkaZOh0de+p2i39wwqiznoZfEeKmYPKXsBs4zh3jDVTiQMCEfFd0zhPTUKgsa/W1JglrtYp1Xqg=",
//               "CALLBACK_URL"    : "https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=19677"]
//
//           self.txnController =  self.txnController?.initTransaction(for: order) as?PGTransactionViewController
//           self.txnController?.title = "Paytm Payments"
//           self.txnController?.setLoggingEnabled(true)
//           if(type != ServerType.eServerTypeNone) {
//               self.txnController?.serverType = type
//           } else {
//               return
//           }
//           self.txnController?.merchant = PGMerchantConfiguration.defaultConfiguration()
//           self.txnController?.delegate = self
//        //print(self.txnController as Any)
//        self.navigationController?.pushViewController(self.txnController!, animated: true)
//       }
//       func showController(controller: PGTransactionViewController) {
//
//         if self.navigationController != nil {
//            self.navigationController?.pushViewController(controller, animated: true)
//         } else {
//            self.present(controller, animated: true, completion: nil)
//         }
//       }
//       //this function triggers when transaction gets finished
//       func didFinishedResponse(_ controller: PGTransactionViewController, response responseString: String) {
//           let msg : String = responseString
//           var titlemsg : String = ""
//           if let data = responseString.data(using: String.Encoding.utf8) {
//               do {
//                   if let jsonresponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] , jsonresponse.count > 0{
//                       titlemsg = jsonresponse["STATUS"] as? String ?? ""
//                   }
//               } catch {
//                   //print("Something went wrong")
//               }
//           }
//           let actionSheetController: UIAlertController = UIAlertController(title: titlemsg , message: msg, preferredStyle: .alert)
//           let cancelAction : UIAlertAction = UIAlertAction(title: "OK", style: .cancel) {
//               action -> Void in
//               controller.navigationController?.popViewController(animated: true)
//           }
//           actionSheetController.addAction(cancelAction)
//           self.present(actionSheetController, animated: true, completion: nil)
//       }
//       //this function triggers when transaction gets cancelled
//       func didCancelTrasaction(_ controller : PGTransactionViewController) {
//           controller.navigationController?.popViewController(animated: true)
//       }
//       //Called when a required parameter is missing.
//       func errorMisssingParameter(_ controller : PGTransactionViewController, error : NSError?) {
//           controller.navigationController?.popViewController(animated: true)
//       }
    
    
}
