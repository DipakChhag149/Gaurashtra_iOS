//
//  PaymentVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 20/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit
import Razorpay

class PaymentVC: GaurashtraBaseVC {
    
    @IBOutlet weak var lblTotalAmt: UILabel!
    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var totalAmtViewConstraintH: NSLayoutConstraint!
    @IBOutlet weak var paperImgView: UIImageView!
    @IBOutlet weak var btnPayNow: UIButton!
    var addressDictData    : Dictionary<String,Any> = ["":""]
    var defaultAddressData : Dictionary<String,Any>  = ["":""]
    
    var cartSessionID : String = ""
    
    var orderId   : String = ""
    var totalAmt  : Double = 0.00
    var codCharge : Double = 0.00
    
    var razorPayOrderId : String = ""
    
    @IBOutlet weak var tblPaymentGateway: UITableView!
    
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var lblAmt: UILabel!
    
    @IBOutlet weak var lblCODCharge: UILabel!
    
    @IBOutlet weak var tblView1: UITableView!
    @IBOutlet weak var topViewHConstraint: NSLayoutConstraint!
    

    @IBOutlet weak var imgViewRazorPay: UIImageView!
    
    @IBOutlet weak var imgViewPayPal: UIImageView!
    
    var eightDigitNumber: String {
        var result = ""
        repeat {
            // Create a string with a random number 0...9999
            result = String(format:"%08d", arc4random_uniform(100000000) )
        } while result.count < 8
        return result
    }
    
    private var dictParamsPaymnt     = [kCountryid      : ""]
    
    private var dictParamsShipping   = [kCountryid      : ""]
    
    private var dictParams   = [kUserId        : "",
                                kCartSessionId : "",
                                kOrderId       : "",
                                kCurrencyCode  : "",
                                kCurrencyValue : "",
                                kTxnId         : "",
                                kPaymentType   : ""]
    
    
    private var dictParamsGenRazorPayOrderId   = [kUserId        : "",
                                                  kCartSessionId : "",
                                                  kOrderId       : ""]
    
    private var dictParamsCheckCapture   = [kUserId        : "",
                                            kCartSessionId : "",
                                            kOrderId       : "",
                                            kPayId         : ""]
                                            
    
    //userid, cartSessionId, orderId, payId
    
   

                                                  
    var cash : String = ""
    var paymentGetway : [Any]  =  []
    var subTotal      : Dictionary<String,Any> = ["":""]
    var shipping      : Dictionary<String,Any> = ["":""]
    var coupon        : Dictionary<String,Any> = ["":""]
    var storeCredit : Dictionary<String,Any> = ["":""]
    var cartTotal   : Dictionary<String,Any> = ["":""]
    var other       : Dictionary<String,Any> = ["":""]
    var tax         : [Any]                  = []
    var cartTotals  : Dictionary<String,Any> = ["":""]

    private var dictParamsCartInfo   = [kUserId               : "",
                                        kCartSessionId        : "",
                                        kShippingPostcode     : "",
                                        kShippingCountryId    : "",
                                        kShippingZoneId       : "",
                                        kCurrencyCode         : "",
                                        kCurrencyValue        : ""]
    
    var expandViewBool : Bool = true
    private var dictParamsPlaceOrder =  [kUserId             : "",
                                         kCartSessionId      : "",
                                         kDeviceType         : "",
                                         kPaymentType        : "",
                                         kPaymentFirstName   : "",
                                         kPaymentLastName    : "",
                                         kPaymentCompany     : "",
                                         kPaymentAddress1    : "",
                                         kPaymentAddress2    : "",
                                         kPaymentCity        : "",
                                         kPaymentPostcode    : "",
                                         kPaymentCountry     : "",
                                         kPaymentCountryId   : "",
                                         kPaymentZone        : "",
                                         kPaymentZoneId      : "",
                                         kShippingFirstName  : "",
                                         kShippingLastName   : "",
                                         kShippingCompany    : "",
                                         kShippingAddress1   : "",
                                         kShippingAddress2   : "",
                                         kShippingCity       : "",
                                         kShippingPostcode   : "",
                                         kShippingCountry    : "",
                                         kShippingCountryId  : "",
                                         kShippingZone       : "",
                                         kShippingZoneId     : "",
                                         kCurrencyCode       : "",
                                         kCurrencyValue      : "",
                                         kPaymentTelephone   : "",
                                         kCustomerPhone      : "",
                                         kShippingTelephone  : ""]
    
    // private var razorpay : Razorpay!
     var razorpay: RazorpayCheckout!
     var finalOrderedPrice : Double = 0.00
     var paymentCountry  : String = ""
     var paymentZone     : String = ""
     var shippingCountry : String = ""
     var shippingZone    : String = ""
     var paymentId : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getDevice()
        self.totalAmtViewConstraintH.constant     = 70
        self.tblPaymentGateway.estimatedRowHeight = 200
        self.tblPaymentGateway.rowHeight          = UITableView.automaticDimension
        paperImgView.image = paperImgView.image?.withRenderingMode(.alwaysTemplate)
        paperImgView.tintColor = .white
        //print(cartSessionID)
        //print(finalOrderedPrice)
        self.btnPayNow.isEnabled = false
        self.btnPayNow.alpha     = 0.5
      
        self.dictParamsCartInfo[kCurrencyCode]   = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
        self.dictParamsCartInfo[kCurrencyValue]   = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
        
        self.dictParamsCartInfo[kCartSessionId]   = String.getString(cartSessionID)
        self.dictParamsCartInfo[kUserId]          = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        
        self.dictParamsCartInfo[kShippingPostcode] = String.getString(self.addressDictData["postcode"])
        self.dictParamsCartInfo[kShippingCountryId] = String.getString(self.addressDictData["country_id"])
        
        self.dictParamsCartInfo[kShippingZoneId] = String.getString(self.addressDictData["zone_id"])
        
        self.callGetCartInfoWebService()
      //getCartInfo //rzp_live_tNlHeOfmNqgtwO//rzp_test_5yQOhTkQAEbs9e
      // razorpay = Razorpay.initWithKey(kLiveRazorPayKey, andDelegate: self)
        
       // razorpay = RazorpayCheckout.initWithKey("rzp_test_5yQOhTkQAEbs9e", andDelegate: self)
         razorpay = RazorpayCheckout.initWithKey(kLiveRazorPayKey, andDelegate: self)
        self.dictParams[kCurrencyCode]   = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
        self.dictParams[kCurrencyValue]  = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
        
//        razorpay = RazorpayCheckout.initWithKey(kLiveRazorPayKey, andDelegate: self)
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.expandViewBool =  true
        self.topViewHConstraint.constant = 70
        self.dictParams[kDeviceType] = "IOS"
        self.dictParamsCheckCapture[kCartSessionId]   = String.getString(cartSessionID)
        self.dictParamsCheckCapture[kUserId]          = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        //print(addressDictData)
        //print(defaultAddressData)
        //print(cartSessionID)
        
        self.btnPayNow.isEnabled  = false
        self.btnPayNow.alpha      = 0.5
        
        let code          = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
        let currencyValue = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
        //print(code)
        //print(currencyValue)
   
        self.dictParamsShipping[kCountryid] = String.getString(addressDictData["country_id"])
        self.dictParamsPaymnt[kCountryid] = String.getString(defaultAddressData["country_id"])
      //  self.dictParamsPaymnt[kCountryid] = String.getString(defaultAddressData["country_id"])
        self.callPaymentZoneListWebService()
        self.callShippingZoneListWebService()
        self.callCountryListWebService()
        self.dictParamsData()
    }
    @IBAction func tapToShowAmountDetail(_ sender: UIButton) {
        self.expandViewBool = !self.expandViewBool
        if self.expandViewBool == true
        {
            self.topViewHConstraint.constant = 70
        }else{
            self.topViewHConstraint.constant = 260//260
        }
    }
    @IBAction func tapToRazorPay(_ sender: UIButton) {
        
    }
    
    @IBAction func tapToPayPal(_ sender: UIButton) {
        self.dictParamsData()
        self.paymentId = 2
        self.dictParamsPlaceOrder[kCurrencyCode]   = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
        self.dictParamsPlaceOrder[kCurrencyValue]   = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
        self.dictParamsPaymnt[kCountryid] = String.getString(defaultAddressData["country_id"])
        self.imgViewRazorPay.image   = #imageLiteral(resourceName: "redioUncheck")
        self.imgViewPayPal.image     = #imageLiteral(resourceName: "dot")
        
       //  self.callSetConfirmOrderWebService()
        
    }
    
    @IBAction func tapTopayNow(_ sender: UIButton) {
        print("paymentType_sunish : \(String.getString(self.dictParamsPlaceOrder[kPaymentType]))")
        if String.getLength(self.orderId) != 0
        {
            self.dictParams[kOrderId] = self.orderId
            if String.getString(self.dictParamsPlaceOrder[kPaymentType]) == "cod"
            {
                self.dictParams[kTxnId]   = "COD_" + eightDigitNumber
                self.dictParams[kOrderId] = self.orderId
                self.callSetPaymentWebService()
            }else{
                if String.getLength(razorPayOrderId) != 0
                {
                   
                    self.showPaymentForm()
                }else{
                    self.showOkAlert(withMessage: "Getting issue from razorpay orderid")
                }
            }
        }else{
            self.showOkAlert(withMessage: "Order id is missing")
        }
        
        
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    func dictParamsData()
    {
        print("self.defaultAddressDatasss:\(self.defaultAddressData)")
        self.dictParamsPlaceOrder[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        self.dictParamsPlaceOrder[kCartSessionId] = String.getString(cartSessionID)
        self.dictParamsPlaceOrder[kPaymentFirstName] = String.getString(self.defaultAddressData["firstname"])
        self.dictParamsPlaceOrder[kPaymentLastName] = String.getString(self.defaultAddressData["lastname"])
        self.dictParamsPlaceOrder[kPaymentCompany] = String.getString(self.defaultAddressData["company"])
        self.dictParamsPlaceOrder[kPaymentAddress1] = String.getString(self.defaultAddressData["address_1"])
        self.dictParamsPlaceOrder[kPaymentAddress2] = String.getString(self.defaultAddressData["address_2"])
        self.dictParamsPlaceOrder[kPaymentCity] = String.getString(self.defaultAddressData["city"])
        self.dictParamsPlaceOrder[kPaymentPostcode] = String.getString(self.defaultAddressData["postcode"])
        self.dictParamsPlaceOrder[kShippingTelephone] = String.getString(self.addressDictData["custom_field"])
        self.dictParamsPlaceOrder[kPaymentTelephone]  = String.getString(LoginDataModel.getLoggedInUserDetails().telephone)
      
        self.dictParamsPlaceOrder[kCustomerPhone] = String.getString(self.defaultAddressData["custom_field"])
        self.dictParamsPlaceOrder[kPaymentCountryId] = String.getString(self.defaultAddressData["country_id"])
        
        self.dictParamsPlaceOrder[kPaymentZoneId] = String.getString(self.defaultAddressData["zone_id"])
        
        self.dictParamsPlaceOrder[kShippingFirstName] = String.getString(self.addressDictData["firstname"])
        self.dictParamsPlaceOrder[kShippingLastName]  = String.getString(self.addressDictData["lastname"])
        self.dictParamsPlaceOrder[kShippingCompany]   = String.getString(self.addressDictData["company"])
        self.dictParamsPlaceOrder[kShippingAddress1]  = String.getString(self.addressDictData["address_1"])
        self.dictParamsPlaceOrder[kShippingAddress2]  = String.getString(self.addressDictData["address_2"])
        self.dictParamsPlaceOrder[kShippingCity]      = String.getString(self.addressDictData["city"])
        self.dictParamsPlaceOrder[kShippingPostcode]  = String.getString(self.addressDictData["postcode"])
        self.dictParamsPlaceOrder[kShippingCountryId] = String.getString(self.addressDictData["country_id"])
        self.dictParamsPlaceOrder[kPaymentZone] = String.getString(self.defaultAddressData["zone_name"])
        self.dictParamsPlaceOrder[kDeviceType] = "IOS"
        //print(self.defaultAddressData["zone_name"])
        
        self.lblAddress.text = String.getString(self.addressDictData["firstname"]) + " " + String.getString(self.addressDictData["lastname"]) + ", "  + String.getString(self.addressDictData["company"]) + "," + String.getString(self.addressDictData["address_1"]) +  "," + String.getString(self.addressDictData["address_2"]) + "," + String.getString(self.addressDictData["city"]) + "," + String.getString(self.addressDictData["postcode"])
        
        //print(String.getString(self.addressDictData["zone_id"]))
        
        self.dictParamsPlaceOrder[kShippingZoneId] = String.getString(self.addressDictData["zone_id"])
        self.dictParamsPlaceOrder[kShippingZone]   = String.getString(self.addressDictData["zone_name"])
        //print(String.getString(self.addressDictData["zone_name"]))
    }
    
    //#MARK:-----------callCountryListWebService---------
    private func callCountryListWebService()
    {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetCountryList, requestMethod: .post, requestImages: [dictImg], withProgressHUD: false, withProgessHUDTitle: "Please Wait...", requestVideos: [String:  Any](), requestData: dictParamsPaymnt, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
              
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    
                  let countryData = kSharedInstance.getArray(result["countryData"])
                    
                    for dict in countryData
                    {
                        let dictData = kSharedInstance.getDictionary(dict)
                        
                        let paymentCountryId = String.getString(strongSelf.defaultAddressData["country_id"])
                        
                         let shippingCountryId = String.getString(strongSelf.addressDictData["country_id"])
                        
                        if paymentCountryId == String.getString(dictData["country_id"])
                        {
                          
                            
                            strongSelf.paymentCountry = String.getString(dictData["name"])
                            
                            strongSelf.dictParamsPlaceOrder[kPaymentCountry] = String.getString(dictData["name"])
                        }
                        
                        if shippingCountryId == String.getString(dictData["country_id"])
                        {
                           strongSelf.dictParamsPlaceOrder[kShippingCountry] = String.getString(dictData["name"])
                        }
                        
                        
                    }
                  
                    
                }else{
                    
                    strongSelf.showOkAlert(withMessage: String.getString(dictResponse[kMessage]))
                    
                }
                
            }
            else if errorType == .requestFailed
            {
                UIApplication.shared.endIgnoringInteractionEvents()
            }
            else
            {
            }
        })
    }
    
    //#MARK:-----------callPaymentZoneListWebService---------
    private func callPaymentZoneListWebService()
    {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetZoneList, requestMethod: .post, requestImages: [dictImg], withProgressHUD: false, withProgessHUDTitle: "Please Wait...", requestVideos: [String:  Any](), requestData: dictParamsPaymnt, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    
                    let zoneData = kSharedInstance.getArray(result["zoneData"])
                    
                    for dict in zoneData
                    {
                        let dictData = kSharedInstance.getDictionary(dict)
                        
                        let paymentZoneId = String.getString(strongSelf.defaultAddressData["zone_id"])
                        
                        
                        
                        if paymentZoneId == String.getString(dictData["zone_id"])
                        {
                            
                            
                            strongSelf.dictParamsPlaceOrder[kPaymentZone] = String.getString(dictData["name"])
                        }
                        
                        
                    }
                    
                    
                }else{
                    
                    strongSelf.showOkAlert(withMessage: String.getString(dictResponse[kMessage]))
                    
                }
                
            }
            else if errorType == .requestFailed
            {
                UIApplication.shared.endIgnoringInteractionEvents()
            }
            else
            {
            }
        })
    }
    
    //#MARK:-----------callShippingZoneListWebService---------
    private func callShippingZoneListWebService()
    {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetZoneList, requestMethod: .post, requestImages: [dictImg], withProgressHUD: false, withProgessHUDTitle: "Please Wait...", requestVideos: [String:  Any](), requestData: dictParamsShipping, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    //print(result)
                    
                    let zoneData = kSharedInstance.getArray(result["zoneData"])
                    
                    for dict in zoneData
                    {
                        let dictData = kSharedInstance.getDictionary(dict)
                        //print(strongSelf.addressDictData)
                        let shippingZoneId = String.getString(strongSelf.addressDictData["zone_id"])
                        
                        //print(shippingZoneId)
                       
                        if shippingZoneId == String.getString(dictData["zone_id"])
                        {
                            //print(String.getString(dictData["name"]))
                            strongSelf.dictParamsPlaceOrder[kShippingZone] = String.getString(dictData["name"])
                        }
                    }
                }else{
                    strongSelf.showOkAlert(withMessage: String.getString(dictResponse[kMessage]))
                }
                
            }
            else if errorType == .requestFailed
            {
                UIApplication.shared.endIgnoringInteractionEvents()
            }
            else
            {
            }
        })
    }
    
    
    //#MARK:-----------callCountryListWebService---------
    private func callSetConfirmOrderWebService()
    {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kSetConfirmOrder, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait...", requestVideos: [String:  Any](), requestData: dictParamsPlaceOrder, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    
                    //print(result)
                    
                 //   let cartInfo kSharedInstance.getDictionary(result["cartInfo"])
                    
                    
                    let cartInfo = kSharedInstance.getDictionary(result["cartInfo"])
                    
                    let cartTotal = kSharedInstance.getDictionary(cartInfo["cartTotal"])
                    
                    //print(cartInfo)
                    //print(cartTotal)
                    let currencyValue = Double.getDouble(CurrencyDataModel.getCurrencySavedDetails().value)
                   
                    //let value = String.getString(cartTotal["value"])
                    // let valueDbl  = Double.getDouble(value)*currencyValue
                  //  strongSelf.finalOrderedPrice = Double(round(100*valueDbl)/100)
                    //ssss
                    
                    
                    let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                    let value2              = CurrencyDataModel.getCurrencySavedDetails().value
                    let currecyDoubleValue = Double.getDouble(value2)
                    
                    let value = String.getString(cartTotal["value"])
                    let valueDbl  = Double.getDouble(value)*currecyDoubleValue
                    let valueFloat    = Double(round(100*valueDbl)/100)
                    strongSelf.finalOrderedPrice = Double.getDouble(valueFloat)
                 
                  
                    let orderId = String.getString(result["orderId"])
                  
                    strongSelf.dictParamsGenRazorPayOrderId[kCartSessionId]   = String.getString(strongSelf.cartSessionID)
                    strongSelf.dictParamsGenRazorPayOrderId[kUserId]          = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
                    strongSelf.dictParamsGenRazorPayOrderId[kOrderId]         = orderId
                    strongSelf.dictParamsCheckCapture[kOrderId]               = orderId
                 
                    if String.getString(strongSelf.dictParamsPlaceOrder[kPaymentType]) == "cod"
                    {
                        strongSelf.btnPayNow.isEnabled  = true
                        strongSelf.btnPayNow.alpha      = 1.0
                        strongSelf.btnPayNow.setTitle("Order Now", for: .normal)
                    }else{
                        if isInternetAvailable()
                        {
                            strongSelf.callRazorPayOrderIdWebService()
                        }else{
                            strongSelf.showOkAlert(withMessage: kNetworkErrorAlert)
                        }
                    }
             
                    strongSelf.orderId = String.getString(result["orderId"])
            
                }else{
                    
                    strongSelf.showOkAlert(withMessage: String.getString(dictResponse[kMessage]))
                    
                }
                
            }
            else if errorType == .requestFailed
            {
                UIApplication.shared.endIgnoringInteractionEvents()
            }
            else
            {
            }
        })
    }
    
    
    //#MARK:-----------callCountryListWebService---------
    private func callSetPaymentWebService()
    {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kSetPayment, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait...", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    
                    
                    strongSelf.thanyouPage()
                    
                  
                    
                }else{
                    
                    strongSelf.showOkAlert(withMessage: String.getString(dictResponse[kMessage]))
                    
                }
                
            }
            else if errorType == .requestFailed
            {
                UIApplication.shared.endIgnoringInteractionEvents()
            }
            else
            {
            }
        })
    }
    
   
    func thanyouPage()
    {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextVC = sb.instantiateViewController(withIdentifier: ThankyouVC.storyboardId()) as! ThankyouVC
        
        nextVC.orderId = self.orderId
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func getDevice()
       {
           if UIDevice().userInterfaceIdiom == .phone {
               switch UIScreen.main.nativeBounds.height {
               case 1136://iphone 5/5S/SE
                   
                   self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 12)
                   
                   self.headerViewConstraintH.constant = 64
                   
               case 1334://iphone 6/6S/7/8
                   self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 15)
                   self.headerViewConstraintH.constant = 64
               case 2208://iphone 6+/6S+/7+/8+
                   
                   self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
                   self.headerViewConstraintH.constant = 64
               case 2436://iphone X/XS
                   
                   self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
                   self.headerViewConstraintH.constant = 84
                   //print("iphone XS")
                   
               case 2688,2778://iphone XS Max
                   
                   //print("iphone XS Max")
                   self.headerViewConstraintH.constant = 84
                   self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
                   
               case 1792://iphone XR
                   self.headerViewConstraintH.constant = 84
                   self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
               default:
                self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
                self.headerViewConstraintH.constant = 84
               }
               
           }
           
       }

}
extension PaymentVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // paymentGetway
        switch tableView {
        case tblView1:
             return 9
            
        case tblPaymentGateway:
            
            return paymentGetway.count
            
        default:
            return 0
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        
        switch tableView {
        case tblView1:
            
             let cell = tblView1.dequeueReusableCell(withIdentifier: PaymentTVC1.cellIdentifier(), for: indexPath) as! PaymentTVC1
             
             cell.backgroundColor = .clear
             
            
             switch indexPath.row {
               case 0:
                 
                    
                   let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                   let valueCurr              = CurrencyDataModel.getCurrencySavedDetails().value
                   let currecyDoubleValue = Double.getDouble(valueCurr)
                
                   
                
                    let value = String.getString(subTotal["value"])
                    
                     let title = String.getString(subTotal["title"])
                    
                    let price = Double.getDouble(value)*currecyDoubleValue
                   
                   let priceFloat    = Double(round(100*price)/100)
                   print("sunishPrice:\(priceFloat)")
                    cell.lblAmt.text = "\(symbol)\(priceFloat)"
                    cell.lblTitle.text = title
                
                case 1:
                    
                    let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                    let valueCurr              = CurrencyDataModel.getCurrencySavedDetails().value
                    let currecyDoubleValue = Double.getDouble(valueCurr)
                    
                    let value = String.getString(shipping["value"])
                    
                    let title = String.getString(shipping["title"])
                                   
                    let price = Double.getDouble(value)*currecyDoubleValue
                    let priceFloat    = Double(round(100*price)/100)
                    cell.lblAmt.text = "\(symbol)\(priceFloat)"
                    cell.lblTitle.text = title
                
                case 2:
                   
                    let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                    let valueCurr              = CurrencyDataModel.getCurrencySavedDetails().value
                    let currecyDoubleValue = Double.getDouble(valueCurr)
                
                     let value = String.getString(coupon["value"])
                
                   let title = String.getString(coupon["title"])
                                                 
                  let price = Double.getDouble(value)*currecyDoubleValue
                  let priceFloat    = Double(round(100*price)/100)
                  cell.lblAmt.text = "-\(symbol)\(priceFloat)"
                  cell.lblTitle.text = title
                   
                case 3:
                    
                    if self.tax.count >= 1
                    {
                       let txt1 = kSharedInstance.getDictionary(tax[0])
                        
                        let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                        let valueCurr              = CurrencyDataModel.getCurrencySavedDetails().value
                        let currecyDoubleValue = Double.getDouble(valueCurr)
                   
                        let value = String.getString(txt1["value"])
                   
                        let title = String.getString(txt1["title"])
                                                    
                        let price = Double.getDouble(value)*currecyDoubleValue
                        let priceFloat    = Double(round(100*price)/100)
                        cell.lblAmt.text = "\(symbol)\(priceFloat)"
                        cell.lblTitle.text = title
                        
                    }
                  
                case 4:
                  
                    if self.tax.count >= 2
                   {
                      let txt1 = kSharedInstance.getDictionary(tax[1])
                       
                       let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                       let valueCurr              = CurrencyDataModel.getCurrencySavedDetails().value
                       let currecyDoubleValue = Double.getDouble(valueCurr)
                  
                       let value = String.getString(txt1["value"])
                  
                       let title = String.getString(txt1["title"])
                                                   
                       let price = Double.getDouble(value)*currecyDoubleValue
                       let priceFloat    = Double(round(100*price)/100)
                       cell.lblAmt.text = "\(symbol)\(priceFloat)"
                       cell.lblTitle.text = title
                       
                   }
                
                
                case 5:
                  
                

                     if self.tax.count >= 3
                      {
                         let txt1 = kSharedInstance.getDictionary(tax[2])
                          
                          let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                          let valueCurr              = CurrencyDataModel.getCurrencySavedDetails().value
                          let currecyDoubleValue = Double.getDouble(valueCurr)
                     
                          let value = String.getString(txt1["value"])
                     
                          let title = String.getString(txt1["title"])
                                                      
                          let price = Double.getDouble(value)*currecyDoubleValue
                          let priceFloat    = Double(round(100*price)/100)
                          cell.lblAmt.text = "\(symbol)\(priceFloat)"
                          cell.lblTitle.text = title
                          
                      }
                
                
                
                case 6:
                               
                      

                      if self.tax.count >= 4
                      {
                        let txt1 = kSharedInstance.getDictionary(tax[3])
                         
                         let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                         let valueCurr              = CurrencyDataModel.getCurrencySavedDetails().value
                         let currecyDoubleValue = Double.getDouble(valueCurr)
                    
                         let value = String.getString(txt1["value"])
                    
                         let title = String.getString(txt1["title"])
                                                     
                         let price = Double.getDouble(value)*currecyDoubleValue
                         let priceFloat    = Double(round(100*price)/100)
                         cell.lblAmt.text = "\(symbol)\(priceFloat)"
                         cell.lblTitle.text = title
                      }
                
                case 7:
                 
                        let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                        let valueCurr              = CurrencyDataModel.getCurrencySavedDetails().value
                        let currecyDoubleValue = Double.getDouble(valueCurr)
                      
                        let value = String.getString(storeCredit["value"])
                      
                        let title = String.getString(coupon["title"])
                                                       
                        let price = Double.getDouble(value)*currecyDoubleValue
                        let priceFloat    = Double(round(100*price)/100)
                        cell.lblAmt.text = "\(symbol)\(priceFloat)"
                        cell.lblTitle.text = title
                
                case 9:
   
                
                  let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                  let valueCurr              = CurrencyDataModel.getCurrencySavedDetails().value
                  let currecyDoubleValue = Double.getDouble(valueCurr)
                   
                 
                 let value = String.getString(cartTotals["value"])
                    
               //    let title = String.getString(subTotal["title"])
                    
                   let price = Double.getDouble(value)*currecyDoubleValue
                   
                   let priceFloat        = Double(round(100*price)/100)
                    let totalAmtWithCOD  = self.codCharge + priceFloat
                    cell.lblAmt.text     = "\(symbol)\(totalAmtWithCOD)"
                    cell.lblAmt.font     = UIFont.systemFont(ofSize: 18)
                    cell.lblTitle.text   = "Total Amount"
                    cell.lblTitle.font   = UIFont(name: "Poppins-Bold", size: 16)

                
            default:
                  return UITableViewCell()
            }
            
          case tblPaymentGateway: 
            
               let cell = tblPaymentGateway.dequeueReusableCell(withIdentifier: PaymentGatewayListTVC.cellIdentifier(), for: indexPath) as! PaymentGatewayListTVC
            
               cell.configureCell(withDictData: kSharedInstance.getDictionary(self.paymentGetway[indexPath.row]), forIndxpath: indexPath)
               
                return cell
            
        default:
            return UITableViewCell()
        }
        
        return UITableViewCell()
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == self.tblPaymentGateway
        {
         let dictData = kSharedInstance.getDictionary(self.paymentGetway[indexPath.row])
        //print(dictData)
        
         self.paymentId = Int.getInt(dictData["id"])
     
       
          self.dictParamsData()
        
        let name = String.getString(dictData["name"])
        
        let amount = String.getString(dictData["amount"])
        
        let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
        let valueCurr              = CurrencyDataModel.getCurrencySavedDetails().value
        let currecyDoubleValue = Double.getDouble(valueCurr)
   
        let price = Double.getDouble(amount)*currecyDoubleValue
      
        let priceFloat    = Double(round(100*price)/100)
        self.codCharge    = priceFloat

        if name == "Cash on delivery"
        {
            self.lblCODCharge.text = "COD charge : \(symbol)\(priceFloat)"
            
            let totalAmtWithCOD    = self.totalAmt + priceFloat
            self.lblAmt.text       = "\(symbol)\(totalAmtWithCOD)"
            self.lblTotalAmt.text  = "\(symbol)\(totalAmtWithCOD)"
            self.dictParamsPlaceOrder[kPaymentType] = "cod"
            self.dictParams[kPaymentType] = "cod"
           // self.totalAmt
        }else{
            self.lblAmt.text       = "\(symbol)\(self.totalAmt)"
            self.lblTotalAmt.text  = "\(symbol)\(self.totalAmt)"
            self.lblCODCharge.text = ""
            self.dictParamsPlaceOrder[kPaymentType] = String.getString(dictData["name"])
            self.dictParams[kPaymentType] = String.getString(dictData["name"])
        }
            //let paymentTypeName = String.getString(dictData["name"])
//            self.dictParamsPlaceOrder[kPaymentType] = String.getString(dictData["name"])
//            self.dictParams[kPaymentType] = String.getString(dictData["name"])
            self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
            self.dictParams[kCartSessionId] = self.cartSessionID
         
            self.dictParamsPlaceOrder[kCurrencyCode]   = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
            self.dictParamsPlaceOrder[kCurrencyValue]   = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
            self.dictParamsPlaceOrder[kShippingZone] = String.getString(self.defaultAddressData["zone_name"])
            self.callSetConfirmOrderWebService()
//            if String.getLength(self.orderId) == 0
//            {
//              self.callSetConfirmOrderWebService()
//            }
//            let indexPath = IndexPath(item: 9, section: 0)
//            self.tblView1.reloadRows(at: [indexPath], with: .none)
     }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == tblView1
        {
        
        switch indexPath.row {
           case 0:
            
             return 30
            
//                let value = String.getString(subTotal["value"])
//
//                //print(value)
//
//                    if Int.getInt(value) != 0
//                    {
//                        return 30
//                    }else{
//
//                        return 0
//                    }
            
            case 1:
                
                
                 return 30
                
//                let value = String.getString(shipping["value"])
//
//
//                //print(Int.getInt(value))
//                if Int.getInt(value) != 0
//                {
//                    return 30
//
//                }else{
//
//                    return 0
//                }
//
               
            
            
            case 2:
               
            
                 let value = String.getString(coupon["value"])
                          
                 if Double.getDouble(value) > 0.0
                  {
                      return 30
                  }else{
                      
                      return 0
                  }

            
            
            case 3:
                
                //print(self.tax.count)
                
                if self.tax.count >= 1
                {
                   return 30
                }else{
                    
                    return 0
                }
                
            case 4:
              
                 if self.tax.count >= 2
                  {
                     return 30
                  }else{
                      
                      return 0
                  }
            
            case 5:
            
                  if self.tax.count >= 3
                  {
                    return 30
                   }else{
                    return 0
                  }
            
            case 6:
                  
                  if self.tax.count >= 4
                  {
                    return 30
                   }else{
                    
                    return 0
                  }
            
            
            
            case 7:
               
                    let value = String.getString(storeCredit["value"])
                            
                    //print(value)
                    //print(Int.getInt(value))
                    
                    if Double.getDouble(value) > 0.0
                    {
                        return 30
                    }else{
                        
                        return 0
                    }
            
                       
                       
            case 8:
            
                 let value = String.getString(other["totalTax"])
                                   
                 if Double.getDouble(value) > 0.0
                   {
                       return 0
                   }else{
                       
                       return 0
                   }
                           
            default:
                 return 0
            }
        
        }else{
            //"name": "PayUmoney" cash //Paytm PayPal
            let dictData = kSharedInstance.getDictionary(self.paymentGetway[indexPath.row])
            if String.getString(dictData["name"])  == "PayUmoney" ||   String.getString(dictData["name"]) == "PayPal"
            {
                return 0
            } else  if String.getString(dictData["name"]) == "Cash on delivery"
            {
                if String.getString(self.cash) == "Yes"
                {
                     return UITableView.automaticDimension
                }else{
                    return 0
                }

            } else{
                return UITableView.automaticDimension
            }
        }
    }
    //

      //#MARK:-----------callCountryListWebService---------
         private func callGetCartInfoWebService()
         {
             
             let dictImg:[String : Any] = ["image" : UIImage(),
                                           "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetCartInfo, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait...", requestVideos: [String:  Any](), requestData: dictParamsCartInfo, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                 guard let strongSelf = self else { return }
                 if errorType == .requestSuccess
                 {
                     UIApplication.shared.endIgnoringInteractionEvents()
                     
                     let dictResponse = kSharedInstance.getDictionary(response)
                     
                     
                     if Int.getInt(dictResponse["success"]) == 1
                     {
                         
                         let result             = kSharedInstance.getDictionary(dictResponse["result"])
                        
                        
                        let paymentInfo = kSharedInstance.getDictionary(result["paymentInfo"])
                        
                        strongSelf.cash = String.getString(paymentInfo["cash"])
                         
                        let cartInfo            = kSharedInstance.getDictionary(result["cartInfo"])
                        let cartTotal           = kSharedInstance.getDictionary(cartInfo["cartTotal"])
                        let symbol              = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                        let valueCurr           = CurrencyDataModel.getCurrencySavedDetails().value
                        let currecyDoubleValue  = Double.getDouble(valueCurr)
                        strongSelf.cartTotals   = cartTotal
                   
                        let value = String.getString(cartTotal["value"])
                       
                       // let title = String.getString(cartTotal["title"])
                       
                       let price = Double.getDouble(value)*currecyDoubleValue
                        
                       let priceFloat    = Double(round(100*price)/100)
                        
                       strongSelf.lblAmt.text = "\(symbol)\(priceFloat)"
                       strongSelf.lblTotalAmt.text = "\(symbol)\(priceFloat)"
                        strongSelf.totalAmt   = priceFloat
                         
                         strongSelf.paymentGetway = kSharedInstance.getArray(result["paymentGetway"])
                         strongSelf.subTotal      = kSharedInstance.getDictionary(cartInfo["subTotal"])
                         strongSelf.shipping      = kSharedInstance.getDictionary(cartInfo["shipping"])
                         strongSelf.coupon        = kSharedInstance.getDictionary(cartInfo["coupon"])
                         strongSelf.storeCredit   = kSharedInstance.getDictionary(cartInfo["storeCredit"])
                         strongSelf.cartTotal     = kSharedInstance.getDictionary(cartInfo["cartTotal"])
                         strongSelf.other         = kSharedInstance.getDictionary(cartInfo["other"])
                         strongSelf.tax           = kSharedInstance.getArray(cartInfo["tax"])
                        strongSelf.tblView1.reloadData()
                        strongSelf.tblPaymentGateway.reloadData()
                     }else{
                         strongSelf.showOkAlert(withMessage: String.getString(dictResponse[kMessage]))
                     }
                 }
                 else if errorType == .requestFailed
                 {
                     UIApplication.shared.endIgnoringInteractionEvents()
                 }
                 else
                 {
                 }
             })
         }
    //#MARK:-----------callCountryListWebService---------
       private func callRazorPayOrderIdWebService()
       {
           let dictImg:[String : Any] = ["image" : UIImage(),
                                         "imageName" : "uploaded_file"]
      TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kRazorPayId, requestMethod: .post, requestImages: [dictImg], withProgressHUD: false, withProgessHUDTitle: "Please Wait...", requestVideos: [String:  Any](), requestData: dictParamsGenRazorPayOrderId, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
               guard let strongSelf = self else { return }
               if errorType == .requestSuccess
               {
                   UIApplication.shared.endIgnoringInteractionEvents()
                   let dictResponse = kSharedInstance.getDictionary(response)
                   if Int.getInt(dictResponse["success"]) == 1
                   {
                       let result = kSharedInstance.getDictionary(dictResponse["result"])
                       let id = String.getString(result["razorpayOrderId"])
                       //print(result)
                       strongSelf.razorPayOrderId      = String.getString(result["razorpayOrderId"])
                       strongSelf.btnPayNow.isEnabled  = true
                       strongSelf.btnPayNow.alpha      = 1.0
                       strongSelf.btnPayNow.setTitle("Pay Now", for: .normal)
                   }else{
                       strongSelf.showOkAlert(withMessage: String.getString(dictResponse[kMessage]))
                       if let selectedIndexPaths = strongSelf.tblPaymentGateway.indexPathsForSelectedRows {
                            for indexPath in selectedIndexPaths {
                                strongSelf.tblPaymentGateway.deselectRow(at: indexPath, animated: true)
                            }
                       }
                   }
                   
               }
               else if errorType == .requestFailed
               {
                   UIApplication.shared.endIgnoringInteractionEvents()
               }
               else
               {
               }
           })
       }
    
    //#MARK:-----------callCountryListWebService---------
     private func callCheckPaymentCaptureOrNotWebService()
     {
         let dictImg:[String : Any] = ["image" : UIImage(),
                                       "imageName" : "uploaded_file"]
    TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kCheckPaymentCaptureOrNot, requestMethod: .post, requestImages: [dictImg], withProgressHUD: false, withProgessHUDTitle: "Please Wait...", requestVideos: [String:  Any](), requestData: dictParamsCheckCapture, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
             guard let strongSelf = self else { return }
             if errorType == .requestSuccess
             {
                 UIApplication.shared.endIgnoringInteractionEvents()
                 let dictResponse = kSharedInstance.getDictionary(response)
                 if Int.getInt(dictResponse["success"]) == 1
                 {
                     let result = kSharedInstance.getDictionary(dictResponse["result"])
                    let razorpayData = kSharedInstance.getDictionary(result["razorpayData"])
                    let status = String.getString(razorpayData["status"])
                     print("Status_1:\(status)")
                    if status == "captured"
                    {
                         strongSelf.callSetPaymentWebService()
                    }else{
                        strongSelf.callCaptureOrderAmountWebService()
                    }
                    
                   
//                     let id = String.getString(result["razorpayOrderId"])
//                     //print(result)
//                     strongSelf.razorPayOrderId = String.getString(result["razorpayOrderId"])
                 }else{
                     strongSelf.showOkAlert(withMessage: String.getString(dictResponse[kMessage]))
                 }
                 
             }
             else if errorType == .requestFailed
             {
                 UIApplication.shared.endIgnoringInteractionEvents()
             }
             else
             {
             }
         })
     }
    
    //#MARK:-----------callCountryListWebService---------
     private func callCaptureOrderAmountWebService()
     {
         let dictImg:[String : Any] = ["image" : UIImage(),
                                       "imageName" : "uploaded_file"]
    TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kCaptureOrderAmount, requestMethod: .post, requestImages: [dictImg], withProgressHUD: false, withProgessHUDTitle: "Please Wait...", requestVideos: [String:  Any](), requestData: dictParamsCheckCapture, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
             guard let strongSelf = self else { return }
             if errorType == .requestSuccess
             {
                 UIApplication.shared.endIgnoringInteractionEvents()
                 let dictResponse = kSharedInstance.getDictionary(response)
                 if Int.getInt(dictResponse["success"]) == 1
                 {
                     let result = kSharedInstance.getDictionary(dictResponse["result"])
                     let razorpayData = kSharedInstance.getDictionary(result["razorpayData"])
                     let status = String.getString(razorpayData["status"])
                     if status == "captured"
                     {
                        strongSelf.callSetPaymentWebService()
                     }
                  
                 }else{
                     strongSelf.showOkAlert(withMessage: String.getString(dictResponse[kMessage]))
                 }
                 
             }
             else if errorType == .requestFailed
             {
                 UIApplication.shared.endIgnoringInteractionEvents()
             }
             else
             {
             }
         })
     }
}

extension PaymentVC : RazorpayPaymentCompletionProtocol
{
    func onPaymentError(_ code: Int32, description str: String) {
        self.showOkAlertWithTitle(withMessage: "Failure", title: "Error") {}
    }

    func onPaymentSuccess(_ payment_id: String) {
      self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        
        self.dictParams[kPaymentType]   = "razorpay"
        self.dictParams[kTxnId]         = String.getString(payment_id)
        self.dictParams[kCartSessionId] = String.getString(cartSessionID)
        self.dictParams[kOrderId]       = String.getString(orderId)
        self.dictParamsCheckCapture[kPayId] = String.getString(payment_id)
        self.callCheckPaymentCaptureOrNotWebService()
       //
       // #MARK: Must need change from here
       
    }

    func showPaymentForm() {
        //        let options = [
        //            "amount" : "2000" // and all other options
        //        ]
        //        razorpay.open(options) kDescription description

        let name = String.getString(LoginDataModel.getLoggedInUserDetails().firstName)
        let email = String.getString(LoginDataModel.getLoggedInUserDetails().email)
        let contact = String.getString(LoginDataModel.getLoggedInUserDetails().telephone)
        
//          let finalTotalStr = String.getString(priceDictData["finalTotal"])
//         let finalTotalInt = Int.getInt(String.getString(priceDictData["finalTotal"]))
       
        let finalTotalInPaisa = (self.finalOrderedPrice * 100.00 )
      
        let options: [String:Any] = [
            kAmount      : "\(finalTotalInPaisa)", //mandatory in paise
            kDescription : "\(self.orderId)",
            kImage       : "https://url-to-image.png",
            kRPayOrderId : "\(self.razorPayOrderId)",
            kName        : "\(name)",
            kProfile     : [
                kContact    : "\(contact)",
                kEmail      : "\(email)"
            ],
            kTheme      : [
                kColor  : kAppColor
            ]
        ]
        print("options:\(options)")
        razorpay.open(options)
    }
}
