//
//  ConfirmOrderVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 07/01/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit

class ConfirmOrderVC: GaurashtraBaseVC,CouponVCDelegate {
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var bottomConstraintH: NSLayoutConstraint!
    
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var txtFieldCoupon: UITextField!
    
    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    
    @IBOutlet weak var btnProccedToPaymt: UIButton!
    @IBOutlet weak var tblConfirmOrder: UITableView!
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var lblPhone: UILabel!
    
    @IBOutlet weak var tblBottom: UITableView!
    
    var cartArrData : [Any] = []
    var couponListArr : [Any] = []
    
    var arrProdQty : [Int] = []
    
    var cartSessionId     : String = ""
    var totalCartPriceAmt : Double = 0.00
    
    var addDictData : Dictionary<String,Any>    = ["":""]
    var defaultAddress : Dictionary<String,Any> = ["":""]
    
    var cartInfoDictData : Dictionary<String,Any> = ["":""]
    
   // private var dictParams = [kUserId: ""]
    
    private var dictParamsCartInfo   = [kUserId               : "",
                                        kCartSessionId        : "",
                                        kShippingPostcode     : "",
                                        kShippingCountryId    : "",
                                        kShippingZoneId       : "",
                                        kCurrencyCode         : "",
                                        kCurrencyValue        : ""]
    
    var productQtyList : [String] = []
    var btnFlag : Bool = true

    
    private var dictParamsManageCart =  [kUserId        : "",
                                         kQuantity      : "",
                                         kProductId     : "",
                                         kActiontype    : "",
                                         kOptionid      : "",
                                         kOptionvalueid : "",
                                         kCouponCode    : "",
                                         kCurrencyCode  : "",
                                         kCurrencyValue : ""]
    
   
           private var dictParams = [kUserId        : "",
                                     kDeviceId      : "",
                                     kCurrencyCode  : "",
                                     kCurrencyValue : ""]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDevice()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.dictParamsCartInfo[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
//        self.dictParamsCartInfo[kCartSessionId]     = self.cartSessionId
        self.dictParamsCartInfo[kShippingPostcode]  = String.getString(self.addDictData["postcode"])
        self.dictParamsCartInfo[kShippingCountryId] = String.getString(self.addDictData["country_id"])
        self.dictParamsCartInfo[kShippingZoneId]    = String.getString(self.addDictData["zone_id"])
        self.dictParamsCartInfo[kCurrencyCode]      = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
        self.dictParamsCartInfo[kCurrencyValue]     = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
//        self.callGetCartInfoWebService()
        
        
         self.btnFlag = true
        //print(addDictData)
         self.bottomConstraintH.constant = 80
         self.btnProccedToPaymt.isEnabled = false
         self.btnProccedToPaymt.alpha     = 0.5
        
       // let dictData = kSharedInstance.getDictionary(self.userAddressData[indexPath.item])
        let firstname = String.getString(addDictData["firstname"])
        let lastname  = String.getString(addDictData["lastname"])
        let address_1 = String.getString(addDictData["address_1"])
        let address_2 = String.getString(addDictData["address_2"])
        let city      = String.getString(addDictData["city"])
        let postcode  = String.getString(addDictData["postcode"])
        let phoneNo   = String.getString(addDictData["custom_field"])
        let company   = String.getString(addDictData["company"])
        let address_id = String.getString(addDictData["address_id"])
        let country_id = String.getString(addDictData["country_id"])
        let zone_id    = String.getString(addDictData["zone_id"])
        
        self.lblPhone.text = phoneNo
        self.lblAddress.text =  firstname + " " + lastname + " ," + address_1 + " ," + address_2 + " ," + city + " ," + postcode
        
        //print(cartInfoDictData)
        //print(defaultAddress)
        
        //kDeviceId kCurrencyCode kCurrencyValue
        
         self.dictParams[kUserId]        = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
         
        
         let deviceToken = String.getString(kSharedUserDefaults.string(forKey: "deviceToken"))
                      
          if String.getLength(deviceToken) != 0
          {
              self.dictParams[kDeviceId]   = deviceToken
              
          }else{
              
              self.dictParams[kDeviceId]   = "yuu75k6j4h3k36k336l3h6l363"
          }
        
        
         self.dictParams[kCurrencyCode] = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
         self.dictParams[kCurrencyValue] = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
         
        self.dictParamsManageCart[kCurrencyCode] = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
        self.dictParamsManageCart[kCurrencyValue] = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
        
        //dictParamsManageCart
        
        if isInternetAvailable()
        {
             self.callGetCartDataWebService(withServiceName: kGetCartData, andDictData: dictParams)
        }else{
            
            showOkAlert(withMessage: kNetworkErrorAlert)
        }
        
       
        
        
        
        
    }
    
    @IBAction func tapToChangeAddress(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func tapToProcced(_ sender: UIButton) {
        
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextVC = sb.instantiateViewController(withIdentifier: PaymentVC.storyboardId()) as! PaymentVC
        
        nextVC.addressDictData    = addDictData
        nextVC.defaultAddressData = defaultAddress
        
        nextVC.cartSessionID = self.cartSessionId
      //  nextVC.finalOrderedPrice = self.totalCartPriceAmt
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func tapToShowAmountDetails(_ sender: UIButton) {
          self.btnFlag = !self.btnFlag
               
        if self.couponListArr.count != 0
        {

        
            if btnFlag == true
           {
              self.bottomConstraintH.constant = 80
//              self.couponView.isHidden                 = true
//              self.couponVIewConstraintH.constant        = 50
//              self.txtFieldCoupon.resignFirstResponder()
           }else{
               self.bottomConstraintH.constant = 360
//               self.couponView.isHidden                 = false
//               self.couponVIewConstraintH.constant      = 50
           }
        }else{
            if btnFlag == true
            {
              self.bottomConstraintH.constant = 80
//              self.couponView.isHidden                 = true
//              self.couponVIewConstraintH.constant      = 70
//              self.txtFieldCoupon.resignFirstResponder()
            }else{
              
               self.bottomConstraintH.constant = 360
//               self.couponView.isHidden = false
//               self.couponVIewConstraintH.constant      = 80
           }
        }
    }
    //#MARK: prepare  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
           if Int.getInt(couponListArr.count) != 0
           {
               
               if segue.identifier == "couponSegue" {
                     let couponVC: CouponVC = segue.destination as! CouponVC
                   couponVC.delegate = self
                   couponVC.couponList = self.couponListArr
                 }
               
           }else{
               self.view.makeToast( "You don't have coupon", duration: 3.0, position: .center)
                         
           }
           
          }
       
       func getCouponCode(_ couponCode: String) {
          // self.txtFieldCoupon.text = couponCode
        self.callGetCartDataWebService(withServiceName: kGetCartData, andDictData: dictParams)
        self.txtFieldCoupon.text = couponCode
        self.bottomConstraintH.constant = 360
           self.view.makeToast( "Coupon code :\(couponCode) applied successfully", duration: 4.0, position: .center)
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
//#MARK:  UITableViewDelegate,UITableViewDataSource 
extension ConfirmOrderVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        switch tableView {
        case tblConfirmOrder:
            return cartArrData.count
        case tblBottom:
            return 10
        default:
            return 0
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        switch tableView {
        case tblConfirmOrder:
            
            let cell = tblConfirmOrder.dequeueReusableCell(withIdentifier: ConfirmOrderTVC.cellIdentifier(), for: indexPath) as! ConfirmOrderTVC
            cell.configureCellConfirmOrder(withDaictData: kSharedInstance.getDictionary(cartArrData[indexPath.row]), forIndxPath: indexPath, btnDelete: { (btnDelete : UIButton) in
                
                
                let dictData = kSharedInstance.getDictionary(self.cartArrData[indexPath.row])
                
                
                self.dictParamsManageCart[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
                
                self.dictParamsManageCart[kQuantity] = "1"
                
                self.dictParamsManageCart[kActiontype] = "delete"
                
                self.dictParamsManageCart[kProductId] = String.getString(dictData["cart_product_id"])
                
                self.dictParamsManageCart[kOptionvalueid] = String.getString(dictData["option_value_id"])
                
                self.dictParamsManageCart[kProductId] = String.getString(dictData["cart_product_id"])
                
                self.dictParamsManageCart[kOptionid] = String.getString(dictData["option_id"])
                
                
                if Int.getInt(self.cartArrData.count) >= 2
                {
                    
                    self.showOkAndCancelAlert4(withMessage: "Are you sure you want to remove this item?", andTitle: "Gaurashtra", okTitle: "Remove", cancelTitle: "Cancel", andHandler: {
                        
                        self.callGetCartDataWebService(withServiceName: kManageCart, andDictData: self.dictParamsManageCart)
                       
                        
                    }, andCancelHandler: {
                        //print("Cancel")
                    })
                    
                }else{
                    self.showOkAlert(withMessage: "Can't delete")
                    
                }
                
                
                
            },btnPlus: { (btnPlus:UIButton) in
                
                let dictData = kSharedInstance.getDictionary(self.cartArrData[indexPath.row])
                
                let product_quantity = Int.getInt(dictData["product_quantity"])
           
                
                self.productQtyList.removeAll()
                
              
                for index in 1...product_quantity {
                    
                    self.productQtyList.append(String.getString(index))
                    
                }
               
                let picker = RSPickerView.init(view: self.view, arrayList: self.productQtyList, keyValue: nil, handler: { (selectedIndex: NSInteger, response: Any?) in
                
                    let qty = self.productQtyList[selectedIndex]
                    
                    self.dictParamsManageCart[kOptionvalueid] = String.getString(dictData["option_value_id"])
                    
                    self.dictParamsManageCart[kProductId] = String.getString(dictData["cart_product_id"])
                    
                    self.dictParamsManageCart[kOptionid] = String.getString(dictData["option_id"])
                    
                    self.dictParamsManageCart[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
                    
                    self.dictParamsManageCart[kQuantity] = "\(qty)"
                    
                    self.dictParamsManageCart[kProductId] = String.getString(dictData["cart_product_id"])
                    
                    self.dictParamsManageCart[kActiontype] = "update"
                     self.callGetCartDataWebService(withServiceName: kManageCart, andDictData: self.dictParamsManageCart)
                    
                })
                picker.viewContainer.backgroundColor = kWhiteColor
            })
            return cell
            
        case tblBottom :
            
            let cell = tblBottom.dequeueReusableCell(withIdentifier: ConfirmSubTotalTVC.cellIdentifier(), for: indexPath) as! ConfirmSubTotalTVC
            
            
            switch indexPath.row {
            case 0:
                
                let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                let value2              = CurrencyDataModel.getCurrencySavedDetails().value
                let currecyDoubleValue = Double.getDouble(value2)
                
                
                let subTotal = kSharedInstance.getDictionary(self.cartInfoDictData["subTotal"])
                
                //print(subTotal)
                
                cell.lblName.text = String.getString(subTotal["title"])
                
                let value = String.getString(subTotal["value"])
                
                let valueDbl  = Double.getDouble(value)*currecyDoubleValue
                
                
                let valueFloat    = Double(round(100*valueDbl)/100)
                print("valueFloat:\(valueFloat)")
                self.totalCartPriceAmt = valueFloat
                
                cell.lblAmt.text = "\(symbol)\(valueFloat)"
                
                
                if UIDevice().userInterfaceIdiom == .phone {
                    switch UIScreen.main.nativeBounds.height {
                    case 1136://iphone 5/5S/SE
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 11)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 11, weight: .regular)
                        
                        
                        
                        
                        
                    case 1334://iphone 6/6S/7/8
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 14)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                        
                        
                        
                        
                        
                    case 2208://iphone 6+/6S+/7+/8+
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                        
                        
                        
                        
                        
                    case 2436://iphone X/XS
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                        
                        //print("iphone XS")
                        
                    case 2688://iphone XS Max
                        
                        //print("iphone XS Max")
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                        
                    case 1792://iphone XR
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                    default:
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        //print("unknown")
                        
                        
                    }
                    
                }
                
                
                
                
                
            case 1:
                
                //cell.lblName.text = "Shipping"
                let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                let value2              = CurrencyDataModel.getCurrencySavedDetails().value
                let currecyDoubleValue = Double.getDouble(value2)
                
                
                let shipping = kSharedInstance.getDictionary(self.cartInfoDictData["shipping"])
                
                
                let title = String.getString(shipping["title"])
                
                cell.lblName.text = "Shipping Fee"
                
                let value = String.getString(shipping["value"])
                
                let valueDbl  = Double.getDouble(value)*currecyDoubleValue
                
                
                let valueFloat    = Double(round(100*valueDbl)/100)
                
                
                cell.lblAmt.text = "\(symbol)\(valueFloat)"
                
                
                
                
                if UIDevice().userInterfaceIdiom == .phone {
                    switch UIScreen.main.nativeBounds.height {
                    case 1136://iphone 5/5S/SE
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 11)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 11, weight: .regular)
                        
                        
                        
                        
                        
                    case 1334://iphone 6/6S/7/8
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 14)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                        
                        
                        
                        
                        
                    case 2208://iphone 6+/6S+/7+/8+
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                        
                        
                        
                        
                        
                    case 2436://iphone X/XS
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                        
                        //print("iphone XS")
                        
                    case 2688://iphone XS Max
                        
                        //print("iphone XS Max")
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                        
                    case 1792://iphone XR
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                    default: break
                        //print("unknown")
                        
                        
                    }
                    
                }
                
                
                
                
                
                
                
                
                
            case 2:
                
                //   cell.lblName.text = "Coupon"
                
                let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                let value2              = CurrencyDataModel.getCurrencySavedDetails().value
                let currecyDoubleValue = Double.getDouble(value2)
                
                let subTotal = kSharedInstance.getDictionary(self.cartInfoDictData["coupon"])
                
                cell.lblName.text = String.getString(subTotal["title"])
                
                let value = String.getString(subTotal["value"])
                
                let valueDbl  = Double.getDouble(value)*currecyDoubleValue
                
                
                let valueFloat    = Double(round(100*valueDbl)/100)
                
                
                cell.lblAmt.text = "-\(symbol)\(valueFloat)"
                
                
                
                
                if UIDevice().userInterfaceIdiom == .phone {
                    switch UIScreen.main.nativeBounds.height {
                    case 1136://iphone 5/5S/SE
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 11)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 11, weight: .regular)
                        
                        
                        
                        
                        
                    case 1334://iphone 6/6S/7/8
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 14)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                        
                        
                        
                        
                        
                    case 2208://iphone 6+/6S+/7+/8+
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                        
                        
                        
                        
                        
                    case 2436://iphone X/XS
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                        
                        //print("iphone XS")
                        
                    case 2688://iphone XS Max
                        
                        //print("iphone XS Max")
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                        
                    case 1792://iphone XR
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                    default: break
                        //print("unknown")
                        
                        
                    }
                    
                }
                
                
                
                
                
                
                
                
                
            case 3:
                
                let tax = kSharedInstance.getArray(self.cartInfoDictData["tax"])
                
                if tax.count >= 1
                {
                    let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                    let value2              = CurrencyDataModel.getCurrencySavedDetails().value
                    let currecyDoubleValue = Double.getDouble(value2)
                                       
                    
                    let dictData1 = kSharedInstance.getDictionary(tax[0])
                    
                    
                    cell.lblName.text = String.getString(dictData1["title"])
                    
                    let value = String.getString(dictData1["value"])
                    
                    let valueDbl  = Double.getDouble(value)*currecyDoubleValue
                    
                    
                    let valueFloat    = Double(round(100*valueDbl)/100)
                    
                    
                    cell.lblAmt.text = "\(symbol)\(valueFloat)"
                    
                    //cell.lblName.text = "GST(12%)"
                    
                    
                    
                    if UIDevice().userInterfaceIdiom == .phone {
                        switch UIScreen.main.nativeBounds.height {
                        case 1136://iphone 5/5S/SE
                            
                            cell.lblName.font = UIFont(name: "Poppins-Regular", size: 11)
                            
                            cell.lblAmt.font = UIFont.systemFont(ofSize: 11, weight: .regular)
                            
                            
                            
                            
                            
                        case 1334://iphone 6/6S/7/8
                            
                            cell.lblName.font = UIFont(name: "Poppins-Regular", size: 14)
                            
                            cell.lblAmt.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                            
                            
                            
                            
                            
                        case 2208://iphone 6+/6S+/7+/8+
                            
                            cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                            
                            cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                            
                            
                            
                            
                            
                            
                            
                        case 2436://iphone X/XS
                            
                            cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                            
                            cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                            
                            
                            
                            //print("iphone XS")
                            
                        case 2688://iphone XS Max
                            
                            //print("iphone XS Max")
                            
                            cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                            
                            cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                            
                            
                            
                        case 1792://iphone XR
                            
                            cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                            
                            cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                            
                            
                        default: break
                            //print("unknown")
                            
                            
                        }
                        
                    }
                    
                    
                    
                    
                    
                    
                }
                
                
                
            case 4:
                
                let tax = kSharedInstance.getArray(self.cartInfoDictData["tax"])
                
                
                if tax.count >= 2
                {
                    let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                    let value2              = CurrencyDataModel.getCurrencySavedDetails().value
                    let currecyDoubleValue = Double.getDouble(value2)
                    
                    let dictData2 = kSharedInstance.getDictionary(tax[1])
                    
                    cell.lblName.text = String.getString(dictData2["title"])
                    
                    let value = String.getString(dictData2["value"])
                    
                    let valueDbl  = Double.getDouble(value)*currecyDoubleValue
                    
                    
                    let valueFloat    = Double(round(100*valueDbl)/100)
                    
                    
                    cell.lblAmt.text = "\(symbol)\(valueFloat)"
                    
                    
                    //                    cell.lblName.text = "GST(5%)"
                    
                    
                    
                    
                }
                
                
                
                
                
                if UIDevice().userInterfaceIdiom == .phone {
                    switch UIScreen.main.nativeBounds.height {
                    case 1136://iphone 5/5S/SE
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 11)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 11, weight: .regular)
                        
                        
                        
                        
                        
                    case 1334://iphone 6/6S/7/8
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 14)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                        
                        
                        
                        
                        
                    case 2208://iphone 6+/6S+/7+/8+
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                        
                        
                        
                        
                        
                    case 2436://iphone X/XS
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                        
                        //print("iphone XS")
                        
                    case 2688://iphone XS Max
                        
                        //print("iphone XS Max")
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                        
                    case 1792://iphone XR
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                    default: break
                        //print("unknown")
                        
                        
                    }
                    
                }
                
                
                
                
                
                
                
            case 5:
                
                let tax = kSharedInstance.getArray(self.cartInfoDictData["tax"])
                if tax.count >= 3
                {
                    let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                    let value2              = CurrencyDataModel.getCurrencySavedDetails().value
                    let currecyDoubleValue = Double.getDouble(value2)
                    
                    let dictData3 = kSharedInstance.getDictionary(tax[2])
                    
                    cell.lblName.text = String.getString(dictData3["title"])
                    
                    let value = String.getString(dictData3["value"])
                    
                    let valueDbl  = Double.getDouble(value)*currecyDoubleValue
                    
                    
                    let valueFloat    = Double(round(100*valueDbl)/100)
                    
                    
                    cell.lblAmt.text = "\(symbol)\(valueFloat)"
                    
                    
                    
                    // cell.lblName.text = "GST(18%)"
                    
                    
                    
                }
                
                
                if UIDevice().userInterfaceIdiom == .phone {
                    switch UIScreen.main.nativeBounds.height {
                    case 1136://iphone 5/5S/SE
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 11)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 11, weight: .regular)
                        
                        
                        
                        
                        
                    case 1334://iphone 6/6S/7/8
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 14)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                        
                        
                        
                        
                        
                    case 2208://iphone 6+/6S+/7+/8+
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                        
                        
                        
                        
                        
                    case 2436://iphone X/XS
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                        
                        //print("iphone XS")
                        
                    case 2688://iphone XS Max
                        
                        //print("iphone XS Max")
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                        
                    case 1792://iphone XR
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                    default: break
                        //print("unknown")
                        
                        
                    }
                    
                }
                
                
                
                
                
                
            case 6:
                
                let tax = kSharedInstance.getArray(self.cartInfoDictData["tax"])
                if tax.count >= 4
                {
                    
                    let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                    let value2              = CurrencyDataModel.getCurrencySavedDetails().value
                    let currecyDoubleValue = Double.getDouble(value2)
                    
                    let dictData4 = kSharedInstance.getDictionary(tax[3])
                    
                    cell.lblName.text = String.getString(dictData4["title"])
                    
                    let value = String.getString(dictData4["value"])
                    
                    let valueDbl  = Double.getDouble(value)*currecyDoubleValue
                    
                    
                    let valueFloat    = Double(round(100*valueDbl)/100)
                    
                    
                    cell.lblAmt.text = "\(symbol)\(valueFloat)"
                    
                    
                    //cell.lblName.text = "GST(28%)"
                    
                    
                }
                
                
                if UIDevice().userInterfaceIdiom == .phone {
                    switch UIScreen.main.nativeBounds.height {
                    case 1136://iphone 5/5S/SE
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 11)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 11, weight: .regular)
                        
                        
                        
                        
                        
                    case 1334://iphone 6/6S/7/8
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 14)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                        
                        
                        
                        
                        
                    case 2208://iphone 6+/6S+/7+/8+
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                        
                        
                        
                        
                        
                    case 2436://iphone X/XS
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                        
                        //print("iphone XS")
                        
                    case 2688://iphone XS Max
                        
                        //print("iphone XS Max")
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                        
                    case 1792://iphone XR
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                    default: break
                        //print("unknown")
                        
                        
                    }
                    
                }
                
                
                
                
                
            case 7:
                
                let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                let value2              = CurrencyDataModel.getCurrencySavedDetails().value
                let currecyDoubleValue = Double.getDouble(value2)
                
                let wallet = kSharedInstance.getDictionary(self.cartInfoDictData["wallet"])
                
                cell.lblName.text = String.getString(wallet["title"])
                
                let value = String.getString(wallet["value"])
                
                let valueDbl  = Double.getDouble(value)*currecyDoubleValue
                
                
                let valueFloat    = Double(round(100*valueDbl)/100)
                
                
                cell.lblAmt.text = "\(symbol)\(valueFloat)"
                
                
                if UIDevice().userInterfaceIdiom == .phone {
                    switch UIScreen.main.nativeBounds.height {
                    case 1136://iphone 5/5S/SE
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 11)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 11, weight: .regular)
                        
                        
                        
                        
                        
                    case 1334://iphone 6/6S/7/8
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 14)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                        
                        
                        
                        
                        
                    case 2208://iphone 6+/6S+/7+/8+
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                        
                        
                        
                        
                        
                    case 2436://iphone X/XS
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                        
                        //print("iphone XS")
                        
                    case 2688://iphone XS Max
                        
                        //print("iphone XS Max")
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                        
                    case 1792://iphone XR
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 15)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                    default: break
                        //print("unknown")
                        
                        
                    }
                    
                }
                
                
                
                
                
                
            case 8:
                
                let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                let value2              = CurrencyDataModel.getCurrencySavedDetails().value
                let currecyDoubleValue = Double.getDouble(value2)
                
                
                let cartTotal = kSharedInstance.getDictionary(self.cartInfoDictData["cartTotal"])
                
                cell.lblName.text = String.getString(cartTotal["title"])
                
                let value = String.getString(cartTotal["value"])
                
                let valueDbl  = Double.getDouble(value)*currecyDoubleValue
                
                
                let valueFloat    = Double(round(100*valueDbl)/100)
                
                print("valueFloatTotal:\(valueFloat)")
                
                cell.lblAmt.text = "\(symbol)\(valueFloat)"
                
                cell.lblName.textColor = .orange
                
                
                
                if UIDevice().userInterfaceIdiom == .phone {
                    switch UIScreen.main.nativeBounds.height {
                    case 1136://iphone 5/5S/SE
                        
                        cell.lblName.font = UIFont(name: "Poppins-Medium", size: 13)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 13, weight: .medium)
                        
                        
                        
                        
                        
                    case 1334://iphone 6/6S/7/8
                        
                        cell.lblName.font = UIFont(name: "Poppins-Medium", size: 17)
                        
                        cell.lblAmt.font = UIFont(name: "System-Medium", size: 17)
                        
                        
                        
                        
                    case 2208://iphone 6+/6S+/7+/8+
                        
                        cell.lblName.font = UIFont(name: "Poppins-Medium", size: 18)
                        
                        cell.lblAmt.font = UIFont(name: "System-Medium", size: 18)
                        
                        
                        
                        
                        
                        
                    case 2436://iphone X/XS
                        
                        cell.lblName.font = UIFont(name: "Poppins-Medium", size: 18)
                        
                        cell.lblAmt.font = UIFont(name: "System-Medium", size: 18)
                        
                        //print("iphone XS")
                        
                    case 2688://iphone XS Max
                        
                        //print("iphone XS Max")
                        
                        cell.lblName.font = UIFont(name: "Poppins-Medium", size: 18)
                        
                        cell.lblAmt.font = UIFont(name: "System-Medium", size: 18)
                        
                    case 1792://iphone XR
                        
                        cell.lblName.font = UIFont(name: "Poppins-Medium", size: 18)
                        
                        cell.lblAmt.font = UIFont(name: "System-Medium", size: 18)
                        
                        
                    default: break
                        //print("unknown")
                        
                        
                    }
                    
                }
                
                
                
            case 9:
                
                cell.lblName.text = "Other"
                
                
                
                
                
                
            default:
                break
            }
            
            
            return cell
            
            
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        let offset = tableView.contentOffset
       
        tableView.layoutIfNeeded() // Force layout so things are updated before resetting the contentOffset.
        tableView.contentOffset = offset
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch tableView {
        case tblConfirmOrder:
            
            return 135.0
            
        case tblBottom:
            
            
            switch indexPath.row {
            case 0:
                
                
                
                //print("Sub Total")
                
                return 45.0
                
            case 1:
                
                let shipping = kSharedInstance.getDictionary(self.cartInfoDictData["shipping"])
                
                let value = String.getString(shipping["value"])
                
                //print(value)
                
                if value != "0"
                {
                    return 45.0
                }else{
                    
                    return 0.0
                }
                
                
                
            case 2:
                
                let coupon = kSharedInstance.getDictionary(self.cartInfoDictData["coupon"])
                
                let value = String.getString(coupon["value"])
                
                
                
                if value != "0"
                {
                    return 45.0
                }else{
                    
                    return 0.0
                }
                
                
            case 3:
                
                let tax12 = kSharedInstance.getArray(self.cartInfoDictData["tax"])
                
                
                if tax12.count >= 1
                {
                    
                    return 45.0
                    
                    
                }else{
                    
                    return 0.0
                }
                
                
                
            case 4:
                
                let tax5 = kSharedInstance.getArray(self.cartInfoDictData["tax"])
                
                //print(tax5.count)
                
                if tax5.count >= 2
                {
                    
                    
                    return 45.0
                }else{
                    
                    return 0.0
                }
                
                
                
                
                
                
            case 5:
                
                
                let tax18 = kSharedInstance.getArray(self.cartInfoDictData["tax"])
                
                
                
                if tax18.count >= 3
                {
                    //let zeroIndx = kSharedInstance.getDictionary(tax18[2])
                    return 45.0
                    
                }else{
                    return 0.0
                }
                
                
                
                
                
            case 6:
                
                
                let tax28 = kSharedInstance.getArray(self.cartInfoDictData["tax"])
                
                //print(tax28.count)
                
                if tax28.count >= 4
                {
                    //let zeroIndx = kSharedInstance.getDictionary(tax28[3])
                    
                    return 45.0
                    
                }else{
                    
                    return 0.0
                }
                
            case 7:
                
                let wallet = kSharedInstance.getDictionary(self.cartInfoDictData["wallet"])
                
                let value = Int.getInt(wallet["value"])
                
                if value != 0
                {
                    return 45.0
                    
                }else{
                    
                    return 0.0
                    
                }
                
                
            case 8:
                
                
                //                 let cartTotal = kSharedInstance.getDictionary(self.cartInfoDictData["cartTotal"])
                //
                //                 let value = String.getString(cartTotal["value"])
                
                return 45.0
                
                
                
            case 9:
                
                // let other = kSharedInstance.getDictionary(self.cartInfoDictData["other"])
                
                return 0.0
                
                
                
            default:
                return 0.0
            }
            
            
        default:
            return 0.0
        }
        
        
    }
    
    
    //#MARK:--------callGetCartDataWebService-------
    private func callGetCartDataWebService(withServiceName serviceName : String , andDictData dict : Dictionary<String,Any>)
    {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: serviceName, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dict, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    strongSelf.cartArrData = kSharedInstance.getArray(result["cartData"])
                    
                 strongSelf.cartSessionId =    String.getString(result["cartSessionId"])
                    
                    strongSelf.dictParamsCartInfo[kCartSessionId]     = String.getString(result["cartSessionId"])
                    
                    strongSelf.callGetCartInfoWebService()
                    
                    if String.getLength(strongSelf.cartSessionId) != 0
                    {
                        strongSelf.btnProccedToPaymt.isEnabled = true
                        strongSelf.btnProccedToPaymt.alpha     = 1.0
                        
                    }else{
                        
                        strongSelf.btnProccedToPaymt.isEnabled = false
                        strongSelf.btnProccedToPaymt.alpha     = 0.5
                    }
                   let couponData = kSharedInstance.getArray(result["couponData"])
                    
                     if couponData.count != 0
                    {
                         strongSelf.couponListArr = couponData
//                         strongSelf.lblTotal.isHidden     = true
//                         strongSelf.lblTotalAmt.isHidden  = true
//                         strongSelf.lblTotalAmt.text      =  ""
//                         strongSelf.lblTotal.text         =  ""
                       // strongSelf.bottomConstraintH.constant = 80
                    }else{
//                         strongSelf.lblTotal.isHidden     = false
//                         strongSelf.lblTotalAmt.isHidden  = false
                       // strongSelf.bottomConstraintH.constant = 150
                    }
                  
//                     strongSelf.cartInfoDictData = kSharedInstance.getDictionary(result["cartInfo"])
                     strongSelf.showCartCount(withCartCount: "\(strongSelf.cartArrData.count)")
                    let cartInfo = kSharedInstance.getDictionary(result["cartInfo"])
                                       
//                   let cartTotal = kSharedInstance.getDictionary(cartInfo["cartTotal"])
//
//                   let priceValue = String.getString(cartTotal["value"])
//
//                   let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
//                   let value              = CurrencyDataModel.getCurrencySavedDetails().value
//                   let currecyDoubleValue = Double.getDouble(value)
//
//                    let price = Double.getDouble(priceValue)*currecyDoubleValue
//
//                    let priceFloat    = Double(round(100*price)/100)
//
//                   //print(priceFloat)
//                   strongSelf.lblTotalAmount.text       =  "\(symbol)\(priceFloat)"
                  // strongSelf.lblTotal.text          =  "Total"
            
                    let appliedCouponData = kSharedInstance.getArray(result["appliedCouponData"])
                                       
                   if appliedCouponData.count != 0
                   {
                      // strongSelf.btnCoupon.setTitle("Change Coupon", for: .normal)
                   }else{
                     //  strongSelf.btnCoupon.setTitle("Choose Coupon", for: .normal)
                   }
                                       
                    
                    strongSelf.tblConfirmOrder.reloadData()
                    strongSelf.tblBottom.reloadData()
                    
                }else{
                    
                strongSelf.view.makeToast(String.getString(dictResponse[kMessage]), duration: 1.5, position: .center)
                    
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
       private func callGetCartInfoWebService()
       {
           
           let dictImg:[String : Any] = ["image" : UIImage(),
                                         "imageName" : "uploaded_file"]
      
      TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetCartInfo, requestMethod: .post, requestImages: [dictImg], withProgressHUD: false, withProgessHUDTitle: "Please Wait...", requestVideos: [String:  Any](), requestData: dictParamsCartInfo, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
               guard let strongSelf = self else { return }
               if errorType == .requestSuccess
               {
                   UIApplication.shared.endIgnoringInteractionEvents()
                   
                   let dictResponse = kSharedInstance.getDictionary(response)
                   
                   
                   if Int.getInt(dictResponse["success"]) == 1
                   {
                       
                       let result             = kSharedInstance.getDictionary(dictResponse["result"])
                      
                      
                      let paymentInfo = kSharedInstance.getDictionary(result["paymentInfo"])
                      
//                      strongSelf.cash = String.getString(paymentInfo["cash"])
                       
                      let cartInfo            = kSharedInstance.getDictionary(result["cartInfo"])
                    strongSelf.cartInfoDictData = kSharedInstance.getDictionary(result["cartInfo"])
                    let cartTotal = kSharedInstance.getDictionary(cartInfo["cartTotal"])
                    
                    let priceValue = String.getString(cartTotal["value"])
                    
                    let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                    let value              = CurrencyDataModel.getCurrencySavedDetails().value
                    let currecyDoubleValue = Double.getDouble(value)
                     let price = Double.getDouble(priceValue)*currecyDoubleValue
                     let priceFloat    = Double(round(100*price)/100)
                    //print(priceFloat)
                    strongSelf.lblTotalAmount.text       =  "\(symbol)\(priceFloat)"

                    strongSelf.tblBottom.reloadData()
                      
                   }else{
                      // strongSelf.showOkAlert(withMessage: String.getString(dictResponse[kMessage]))
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
