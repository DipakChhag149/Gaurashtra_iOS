//
//  PaymentVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 13/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit
import Razorpay

class PaymentVC: GaurashtraBaseVC,RazorpayPaymentCompletionProtocol {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var btnConfirmOrder: UIButton!
    
    @IBOutlet weak var selectImgViewRazorPay: UIImageView!
    
     private var razorpay : Razorpay!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnConfirmOrder.isEnabled = false
        self.btnConfirmOrder.alpha     = 0.5
        razorpay = Razorpay.initWithKey(kRazorPayTestKey, andDelegate: self)
        
    }
    
    @IBAction func tapToConfrimOrder(_ sender: UIButton) {
        
        self.showPaymentForm()
    }
    
    
    func showPaymentForm() {
        
        
        let fullName = String.getString(LoginDataModel.getLoggedInUserDetails().firstName)
        
        let email = String.getString(LoginDataModel.getLoggedInUserDetails().email)
        
        let contact = String.getString(LoginDataModel.getLoggedInUserDetails().telephone)
        
      //  let image_url = String.getString(LoginDataModel.getLoggedInUserDetails().image_url)
        
       
        
        //let finalTotalDbl = Double.getDouble(String.getString(self.payAmount))
        //   let finalTotalDbl = 1.0
        
        let finalTotalInPaisa = 10.0 * 100.00
        
        // let finalTotal = String.getString(finalTotalInPaisa)
        
       // let image_url = "https:\/\/gaurashtra.algosoftech.in\/.\/assets\/banner\/1556874538slider1.jpg"
        
        let options: [String:Any] = [
            kAmount     : "\(finalTotalInPaisa)", //mandatory in paise
            kDescription: "Payment",
            kImage      : "",
            kName       : "\(fullName)",
            kProfile    : [
                kContact    : "\(contact)",
                kEmail      : "\(email)"
            ],
            kTheme      : [
                kColor  : kAppColor
            ]
        ]
        razorpay.open(options)
        // razorpay.open(options, displayController: self)
        
    }
    


    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapToRazorPay(_ sender: UIButton) {
        
        self.btnConfirmOrder.isEnabled = true
        self.btnConfirmOrder.alpha     = 1.0
        
        self.selectImgViewRazorPay.image = #imageLiteral(resourceName: "selected")
        
        
    }
    
    func onPaymentError(_ code: Int32, description str: String) {
        //  UIAlertView.init(title: "Error", message: str, delegate: self, cancelButtonTitle: "OK").show()
        showOkAlertWithTitle(withMessage: "Failure code: \(code)", title: "Error") {}
            
            
        showOkAlert(withMessage: "")
        
        
    }
    
    func onPaymentSuccess(_ payment_id: String) {
  
        showOkAlert(withMessage: payment_id)
        
//        self.dictParamsOS[kTxnid] = String.getString(payment_id)
//
//
//        self.dictParamsOS[kPayment_type] = "razorpay"
//
//        self.dictParamsOS[kPhone] = String.getString(LoginDataModel.getLoggedInUserDetails().phone)
//
//        self.dictParamsOS[kUid] = String.getString(LoginDataModel.getLoggedInUserDetails().id)
//
//        self.dictParamsOS[kPackage_id] = String.getString(dictData["id"])
//
//        self.dictParamsOS[kPackage_price] = String.getString(dictData["price"])
//
//        self.dictParamsOS[kPackage_packs] = String.getString(dictData["packs"])
//
//        self.callGetOrderSuccessWebService()
        
        
    }
    
}
