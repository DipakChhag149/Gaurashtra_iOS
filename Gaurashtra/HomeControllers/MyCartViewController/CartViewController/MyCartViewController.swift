//
//  MyCartViewController.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 20/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit
import SWRevealViewController
import Toast_Swift

class MyCartViewController: GaurashtraBaseVC {
    
    @IBOutlet weak var btnContinueShop2: UIButton!
    @IBOutlet weak var btnDeleteCart: UIButton!
    @IBOutlet weak var imgDelete: UIImageView!
    
    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    let bgImageView = UIImageView(image: #imageLiteral(resourceName: "graybox2"))
    let shimmerImageView = UIImageView(image: #imageLiteral(resourceName: "gaybox1"))
    
   // var arr : [Any] = ["ss","aa"]
    
    var indexValue : [Int] = []
    
    var selectedData : [Any] = []
     
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var imgDataNotFound: UIImageView!
    
  //  @IBOutlet weak var subView: UIView!
    
//    @IBOutlet weak var couponViewConstraintH2: NSLayoutConstraint!
//
//
//    @IBOutlet weak var priceTotalConstraintH: NSLayoutConstraint!
    
    //@IBOutlet weak var couponView2: UIView!
//    @IBOutlet weak var couponView: UIView!
//    @IBOutlet weak var txtFieldCoupon: UITextField!
//    @IBOutlet weak var couponVIewConstraintH: NSLayoutConstraint!
    @IBOutlet weak var tblBottom: UITableView!
   // @IBOutlet weak var btnCoupon: UIButton!
    @IBOutlet weak var btnShopping: UIButton!
    @IBOutlet weak var btnProcceed: UIButton!
    
    @IBOutlet weak var myCartTbl: UITableView!
    
    @IBOutlet weak var lblOffer: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    
    @IBOutlet weak var lblTotalAmt: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    
    @IBOutlet weak var bottomViewHeightConstraint: NSLayoutConstraint!
    
    var outOfStockArr : [Any] = []
    var cartArrData   : [Any] = []
    
    var arrProdQty    : [Int] = []
    
    var cartInfoDictData : Dictionary<String,Any> = ["":""]
    
    var couponListArr : [Any] = []
    
    var productQtyList : [String] = []
    
    private var dictParamsCurr = [kCode   : ""]
    
    var btnFlag : Bool = true
    
    var titleStr  : [String] = []
    var codeStr   : [String] = []
    var valueStr  : [String] = []
    var symbolStr : [String] = []
    
    
    private var dictParams = [kUserId        : "",
                              kDeviceId      : "",
                              kCurrencyCode  : "",
                              kCurrencyValue : ""]
                              
                                
    
    private var dictParamsManageCart =  [kUserId        : "",
                                         kQuantity      : "",
                                         kProductId     : "",
                                         kActiontype    : "",
                                         kOptionid      : "",
                                         kOptionvalueid : "",
                                         kCouponCode    : "",
                                         kCurrencyCode  : "",
                                         kCurrencyValue : ""]
    
    private var dictParamsDeleteCart : Dictionary<String,Any> =  [kUserId        : "",
                                         kCurrencyCode  : "",
                                         kCurrencyValue : "",
                                         kProductData : [Any]()]
//    kCurrencyCode  kCurrencyValue : "",
//                                           kCurrencyValue : ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgDelete.alpha = 0.4
        self.btnDeleteCart.isUserInteractionEnabled = false
        self.myCartTbl.allowsMultipleSelection = true
       
        self.callGetCurrencyListWebServiceHM()
        
        self.getDevice()
        
         self.bottomView.isHidden      = false
         self.imgDataNotFound.isHidden = true
        btnMenu.target = revealViewController()
        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        self.bottomView.isHidden   = true
        self.myCartTbl.isHidden    = true
        self.btnProcceed.isHidden  = true
        
        self.dictParams[kCurrencyCode]   = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
        
         self.dictParams[kCurrencyValue]   = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
        self.dictParams[kUserId]   = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        let deviceToken = String.getString(kSharedUserDefaults.string(forKey: "deviceToken"))
           if String.getLength(deviceToken) != 0
           {
               self.dictParams[kDeviceId]   = deviceToken
           }else{
               
               self.dictParams[kDeviceId]   = "yuu75k6j4h3k36k336l3h6l363"
           }
        
        if isInternetAvailable()
        {
            self.callGetCartDataWebService(withServiceName: kGetCartData, andDictData: dictParams, progressHUD: false, withId: 0)
            kSharedInstance.setupShimmeringImage(withView: self.view, backGrroundImgV: bgImageView, shimmerImageView: shimmerImageView)
        }else{
            
            self.view.makeToast(kNetworkErrorAlert, duration: 1.5, position: .center)
        }
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.btnContinueShop2.isHidden = true
        self.btnFlag = true
        self.bottomViewHeightConstraint.constant = 150
        
        self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        
        self.dictParams[kCurrencyCode]   = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
               
        self.dictParams[kCurrencyValue]   = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
               
        let userId = LoginDataModel.getLoggedInUserDetails().customer_id
             
             if String.getLength(userId) == 0
             {
               
                kSharedUserDefaults.set("MyCartViewContoller", forKey: "LoginView")
                 self.loginView()
                
                          if let tabItems = self.tabBarController?.tabBar.items {
                                // In this case we want to modify the badge number of the third tab:
                             let tabItem = tabItems[4]

                             tabItem.badgeValue = nil
                }
             }else{
                if isInternetAvailable()
                {
                    self.callGetCartDataWebService(withServiceName: kGetCartData, andDictData: dictParams, progressHUD: false, withId: 0)
                     kSharedInstance.setupShimmeringImage(withView: self.view, backGrroundImgV: bgImageView, shimmerImageView: shimmerImageView)
                }else{
                    
                    self.view.makeToast(kNetworkErrorAlert, duration: 1.5, position: .center)
                }
        }
    }
        
    func loginView()
    {
        let sb : UIStoryboard  = UIStoryboard(name: kLoginPlaceholder, bundle: nil)
        
        let nextVc = sb.instantiateViewController(withIdentifier: LoginViewController.storyboardId()) as! LoginViewController
        
        //self.navigationController?.pushViewController(nextVc, animated: true)
        
        self.present(nextVc, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func tapToSelectCurrency(_ sender: UIBarButtonItem) {
        
        if codeStr.count != 0
       {
           let picker = RSPickerView.init(view: self.view, arrayList: self.codeStr, keyValue: nil, handler: { (selectedIndex: NSInteger, response: Any?) in
                                   
                                   //fuel_type_id_list fuel_type_name_list
           //                        self.lblHistoryResult.text = kDisplayHistoryResult[selectedIndex]
               
               let codeStr = self.codeStr[selectedIndex]
               
                self.dictParamsCurr[kCode] = "\(codeStr)"
               
                self.callGetCurrencyDetailsWebServiceHM()
              
              
               self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
                      
               let deviceToken = String.getString(kSharedUserDefaults.string(forKey: "deviceToken"))
                                          
                      if String.getLength(deviceToken) != 0
                      {
                          self.dictParams[kDeviceId]   = deviceToken
                          
                      }else{
                          
                          self.dictParams[kDeviceId]   = "yuu75k6j4h3k36k336l3h6l363"
                      }
              
              if isInternetAvailable()
              {
                   
                
                
                self.dictParams[kCurrencyCode]   = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
                       
                self.dictParams[kCurrencyValue]   = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
               
               
               
               self.dictParams[kUserId]   = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
                let deviceToken = String.getString(kSharedUserDefaults.string(forKey: "deviceToken"))
                                          
                      if String.getLength(deviceToken) != 0
                      {
                          self.dictParams[kDeviceId]   = deviceToken
                          
                      }else{
                          
                          self.dictParams[kDeviceId]   = "yuu75k6j4h3k36k336l3h6l363"
                      }
               
               
               if isInternetAvailable()
               {
                self.callGetCartDataWebService(withServiceName: kGetCartData, andDictData: self.dictParams, progressHUD: false, withId: 0)
                kSharedInstance.setupShimmeringImage(withView: self.view, backGrroundImgV: self.bgImageView, shimmerImageView: self.shimmerImageView)
               }else{
                   
                   self.view.makeToast(kNetworkErrorAlert, duration: 1.5, position: .center)
               }
                
              }else{
               self.showOkAlert(withMessage:kNetworkErrorAlert)
              }
               
               })
                picker.viewContainer.backgroundColor = kWhiteColor
               }else{
                self.view.makeToast("Loading Please Wait")
               }
    }
    
    @IBAction func tapToNotification(_ sender: UIBarButtonItem) {
        
       // self.notificationVC()
        
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextViewController = sb.instantiateViewController(withIdentifier: NotificationVC.storyboardId()) as! NotificationVC
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
    }
    
    
    @IBAction func tapToProceed(_ sender: UIButton) {
       self.myAddressListVC()
    }
    
    @IBAction func tapToContinueShopping(_ sender: UIButton) {
        kSharedAppDelegate.showSideMenu()
    }
    
   
    
    
    @IBAction func tapToCoupon(_ sender: UIButton) {
        
//        if Int.getInt(couponListArr.count) != 0
//        {
//            let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
//            let nextViewController = sb.instantiateViewController(withIdentifier: CouponVC.getStotyboardId()) as! CouponVC
//
//
//
//           // nextViewController.modalPresentationStyle = .overCurrentContext
//            present(nextViewController, animated: true, completion: nil)
//        }else{
//
//
//        }
        
        
  
        
    }
  
    func myAddressListVC()
    {
        
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextViewController = sb.instantiateViewController(withIdentifier: MyAddresViewController.storyboardId()) as! MyAddresViewController
        
        nextViewController.controllerId = 0
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    //#MARK:  prepare for segue 

      
    
    @IBAction func tapToShowCartPriceDetails(_ sender: UIButton) {
        
        self.btnFlag = !self.btnFlag
        
        
       
        if self.couponListArr.count != 0
        {

        
            if btnFlag == true
           {
              self.bottomViewHeightConstraint.constant = 150
//              self.couponView.isHidden                 = true
//              self.couponVIewConstraintH.constant        = 50
//              self.txtFieldCoupon.resignFirstResponder()
           }else{
               self.bottomViewHeightConstraint.constant = 410
//               self.couponView.isHidden                 = false
//               self.couponVIewConstraintH.constant      = 50
           }
        }else{
            if btnFlag == true
            {
              self.bottomViewHeightConstraint.constant = 150
//              self.couponView.isHidden                 = true
//              self.couponVIewConstraintH.constant      = 70
//              self.txtFieldCoupon.resignFirstResponder()
            }else{
              
               self.bottomViewHeightConstraint.constant = 410
//               self.couponView.isHidden = false
//               self.couponVIewConstraintH.constant      = 80
           }
        }
    }
    
    
    @IBAction func tapToDelete(_ sender: UIButton) {
        
        self.dictParamsDeleteCart[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        self.dictParamsDeleteCart[kCurrencyCode]   = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
        self.dictParamsDeleteCart[kCurrencyValue]   = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
        
        self.showOkAndCancelAlert4(withMessage: "Are you sure you want to remove this item?", andTitle: "Gaurashtra", okTitle: "Remove", cancelTitle: "Cancel", andHandler: {
            self.callGetCartDataWebService(withServiceName: kMultipleDeleteInCart, andDictData: self.dictParamsDeleteCart, progressHUD: true, withId: 0)
//             self.cartArrData.remove(at: indexPath.row)
//            self.myCartTbl.reloadData()
        }, andCancelHandler: {
            //print("Cancel")
        })
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
extension MyCartViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        switch tableView {
        case myCartTbl:
            
            if let tabItems = tabBarController?.tabBar.items {
                // In this case we want to modify the badge number of the third tab:
                let tabItem = tabItems[4]
                
                if self.cartArrData.count != 0
                {
                    tabItem.badgeValue = "\(self.cartArrData.count)"
                }
                
            }
            
            return cartArrData.count
            
        case tblBottom:
            
            return 10
            
        default:
            return 0
        }
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        switch tableView {
        case myCartTbl:
            
            let cell = myCartTbl.dequeueReusableCell(withIdentifier: CartTVC.cellIdentifier(), for: indexPath) as! CartTVC
            cell.configureCellMyCart(withDaictData: kSharedInstance.getDictionary(cartArrData[indexPath.row]), forIndxPath: indexPath, btnDelete: { (btnDelete : UIButton) in
                let dictData = kSharedInstance.getDictionary(self.cartArrData[indexPath.row])
                self.dictParamsManageCart[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
                self.dictParamsManageCart[kCurrencyCode]   = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
                self.dictParamsManageCart[kCurrencyValue]   = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
                self.dictParamsManageCart[kQuantity] = "1"
                self.dictParamsManageCart[kActiontype] = "delete"
                 self.dictParamsManageCart[kOptionvalueid] = String.getString(dictData["option_value_id"])
                self.dictParamsManageCart[kProductId] = String.getString(dictData["cart_product_id"])
                self.dictParamsManageCart[kOptionid] = String.getString(dictData["option_id"])
                self.showOkAndCancelAlert4(withMessage: "Are you sure you want to remove this item?", andTitle: "Gaurashtra", okTitle: "Remove", cancelTitle: "Cancel", andHandler: {
                    self.callGetCartDataWebService(withServiceName: kManageCart, andDictData: self.dictParamsManageCart, progressHUD: true, withId: 0)
                     self.cartArrData.remove(at: indexPath.row)
                    self.myCartTbl.reloadData()
                }, andCancelHandler: {
                    //print("Cancel")
                })
                
            },btnPlus: { (btnPlus:UIButton) in
                
                let dictData = kSharedInstance.getDictionary(self.cartArrData[indexPath.row])
                
                self.productQtyList.removeAll()
                
                let product_quantity = Int.getInt(dictData["product_quantity"])
                
                for index in 1...product_quantity {
                    
                    self.productQtyList.append(String.getString(index))
                    
                }
                
                
                
                let picker = RSPickerView.init(view: self.view, arrayList: self.productQtyList, keyValue: nil, handler: { (selectedIndex: NSInteger, response: Any?) in
                let qty = self.productQtyList[selectedIndex]
            
                    self.dictParamsManageCart[kOptionvalueid] = String.getString(dictData["option_value_id"])
                    
                    self.dictParamsManageCart[kProductId] = String.getString(dictData["cart_product_id"])
                    
                    self.dictParamsManageCart[kOptionid] = String.getString(dictData["option_id"])
                    
                    self.dictParamsManageCart[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
                    
                    self.dictParamsManageCart[kCurrencyCode]   = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
                           
                    self.dictParamsManageCart[kCurrencyValue]   = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
                           
                    
                    self.dictParamsManageCart[kQuantity] = "\(qty)"
                    
                    self.dictParamsManageCart[kProductId] = String.getString(dictData["cart_product_id"])
                    
                    self.dictParamsManageCart[kActiontype] = "update"
                    self.callGetCartDataWebService(withServiceName: kManageCart, andDictData: self.dictParamsManageCart, progressHUD: true, withId: 0)

                })
                picker.viewContainer.backgroundColor = kWhiteColor
                            }, btnPackOf: { (btnPackOf:UIButton) in
                //print("PackOf")
            }, btnSaveForLetter:  { (btnSaveForLetter:UIButton) in
                 //print("btnSaveForLetter")
                
                let dictData = kSharedInstance.getDictionary(self.cartArrData[indexPath.row])
                
                
                self.dictParamsManageCart[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
                
                self.dictParamsManageCart[kCurrencyCode]   = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
                       
                self.dictParamsManageCart[kCurrencyValue]   = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
                       
                
                self.dictParamsManageCart[kQuantity] = "1"
                
                self.dictParamsManageCart[kActiontype] = "add"
                
                self.dictParamsManageCart[kProductId] = String.getString(dictData["cart_product_id"])
                
                self.dictParamsManageCart[kOptionid] = String.getString(dictData["option_id"])
                
                
                self.callWishListWebService(withDictData: dictData)
             
                
            })
            
            return cell
            
        case tblBottom :
            
            let cell = tblBottom.dequeueReusableCell(withIdentifier: SubTotalTVC.cellIdentifier(), for: indexPath) as! SubTotalTVC
            
            
            switch indexPath.row {
            case 0:
                
               let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
               let valueMoney              = CurrencyDataModel.getCurrencySavedDetails().value
               let currecyDoubleValue = Double.getDouble(valueMoney)
                
                let subTotal = kSharedInstance.getDictionary(self.cartInfoDictData["subTotal"])
                
                cell.lblName.text = String.getString(subTotal["title"])
                
                let value = String.getString(subTotal["value"])
                
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
                
                
                
                
                
            case 1:
                
                //cell.lblName.text = "Shipping"
                
                 let other = kSharedInstance.getDictionary(self.cartInfoDictData["other"])
                 let totalWeight = String.getString(other["totalWeight"])
                let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                let valueMoney              = CurrencyDataModel.getCurrencySavedDetails().value
                let currecyDoubleValue = Double.getDouble(valueMoney)
                
                let shipping = kSharedInstance.getDictionary(self.cartInfoDictData["shipping"])
                
                
                let title = String.getString(shipping["title"])
                
                
                
                cell.lblName.text = "Shipping Charge(Weight:\(totalWeight) gm)"
//                cell.lblName.font = UIFont(name: "Poppins-Regular", size: 12)
//
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
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 12)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                        
                        
                        
                        
                        
                    case 2208://iphone 6+/6S+/7+/8+
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 12)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                        
                        
                        
                        
                        
                    case 2436://iphone X/XS
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 12)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                        
                        //print("iphone XS")
                        
                    case 2688://iphone XS Max
                        
                        //print("iphone XS Max")
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 12)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                        
                    case 1792://iphone XR
                        
                        cell.lblName.font = UIFont(name: "Poppins-Regular", size: 12)
                        
                        cell.lblAmt.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                        
                        
                    default:break
                        //print("unknown")
                        
                        
                    }
                    
                }
           
            case 2:
                
                //   cell.lblName.text = "Coupon"
                
                
                let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                let valueMoney              = CurrencyDataModel.getCurrencySavedDetails().value
                let currecyDoubleValue = Double.getDouble(valueMoney)
                
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
                    let valueMoney              = CurrencyDataModel.getCurrencySavedDetails().value
                    let currecyDoubleValue = Double.getDouble(valueMoney)
                    
                    
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
                   let valueMoney              = CurrencyDataModel.getCurrencySavedDetails().value
                   let currecyDoubleValue = Double.getDouble(valueMoney)
                    
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
                    let valueMoney              = CurrencyDataModel.getCurrencySavedDetails().value
                    let currecyDoubleValue = Double.getDouble(valueMoney)
                                       
                    
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
                    let valueMoney              = CurrencyDataModel.getCurrencySavedDetails().value
                    let currecyDoubleValue = Double.getDouble(valueMoney)
                    
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
               let valueMoney              = CurrencyDataModel.getCurrencySavedDetails().value
               let currecyDoubleValue = Double.getDouble(valueMoney)
                
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
                let valueMoney              = CurrencyDataModel.getCurrencySavedDetails().value
                let currecyDoubleValue = Double.getDouble(valueMoney)
                
                let cartTotal = kSharedInstance.getDictionary(self.cartInfoDictData["cartTotal"])
                
                cell.lblName.text = String.getString(cartTotal["title"])
                
                let value = String.getString(cartTotal["value"])
                
                let valueDbl  = Double.getDouble(value)*currecyDoubleValue
                
                
                let valueFloat    = Double(round(100*valueDbl)/100)
                
                
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           self.selectDeselectCell(tableView: tableView, indexPath: indexPath)
           //print("Selected")
       }
       func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
           self.selectDeselectCell(tableView: tableView, indexPath: indexPath)
           //print("Deselect")
        if Int.getInt(self.selectedData.count) == 0
        {
            self.imgDelete.alpha = 0.4
            self.btnDeleteCart.isUserInteractionEnabled = false
        }
       }
    
    
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch tableView {
        case myCartTbl:
            
            return 135.0
            
        case tblBottom:
            
        
            switch indexPath.row {
            case 0:
                
                
                
                //print("Sub Total")
                
                return 30.0
                
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
    
    //#MARK:-----------callCategoryListWebService---------
    private func callWishListWebService(withDictData dictData : Dictionary<String,Any>)
    {
        
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kManageWishlist, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParamsManageCart, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    
                    
                    strongSelf.dictParamsManageCart[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
                    
                    strongSelf.dictParamsManageCart[kCurrencyCode]   = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
                           
                    strongSelf.dictParamsManageCart[kCurrencyValue]   = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
                           
                    strongSelf.dictParamsManageCart[kQuantity] = "1"
                    
                    strongSelf.dictParamsManageCart[kActiontype] = "delete"
                    
                    strongSelf.dictParamsManageCart[kOptionvalueid] = String.getString(dictData["option_value_id"])
                    
                    strongSelf.dictParamsManageCart[kProductId] = String.getString(dictData["cart_product_id"])
                    
                    strongSelf.dictParamsManageCart[kOptionid] = String.getString(dictData["option_id"])
                    strongSelf.view.makeToast(String.getString(dictResponse[kMessage]), duration: 1.5, position: .center)
                    
                    strongSelf.callGetCartDataWebService(withServiceName: kManageCart, andDictData: strongSelf.dictParamsManageCart, progressHUD: false, withId: 0)
                    
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
    
    
    //#MARK:-----------callGetCartDataWebService---------
    private func callGetCartDataWebService(withServiceName serviceName : String , andDictData dict : Dictionary<String,Any> , progressHUD : Bool, withId : Int)
    {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: serviceName, requestMethod: .post, requestImages: [dictImg], withProgressHUD: progressHUD, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dict, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                strongSelf.bgImageView.removeFromSuperview()
                strongSelf.shimmerImageView.removeFromSuperview()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    strongSelf.myCartTbl.isHidden = false
                    
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    strongSelf.cartArrData = kSharedInstance.getArray(result["cartData"])
                   // strongSelf.callGetCartWebService()
                    let cartArrData = kSharedInstance.getArray(result["cartData"])
                                        
                    if cartArrData.count == 0
                    {
                        strongSelf.imgDataNotFound.isHidden = false
                    }else{
                        
                        strongSelf.imgDataNotFound.isHidden = true
                    }
//                    strongSelf.textLabel.removeFromSuperview()
//                    strongSelf.shimmerTextLabel.removeFromSuperview()
                    strongSelf.myCartTbl.isHidden   = false
                    strongSelf.bottomView.isHidden = false
                    strongSelf.btnProcceed.isHidden = false
                    strongSelf.imgDataNotFound.image = nil
                 
                    strongSelf.showCartCount(withCartCount: "\(cartArrData.count)")
                
                    strongSelf.cartInfoDictData = kSharedInstance.getDictionary(result["cartInfo"])
                    
                    let other = kSharedInstance.getDictionary(strongSelf.cartInfoDictData["other"])
                    
                   let couponData = kSharedInstance.getArray(result["couponData"])
                    
                    //let couponData = strongSelf.arr
                    
                    //print(couponData)
                  
                    let cartInfo = kSharedInstance.getDictionary(result["cartInfo"])
                    
                    let cartTotal = kSharedInstance.getDictionary(cartInfo["cartTotal"])
                    
                    let priceValue = String.getString(cartTotal["value"])
                    
                    let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                    let value              = CurrencyDataModel.getCurrencySavedDetails().value
                    let currecyDoubleValue = Double.getDouble(value)
                    
                     let price = Double.getDouble(priceValue)*currecyDoubleValue
                    
                     let priceFloat    = Double(round(100*price)/100)
                    
                    //print(priceFloat)
                    strongSelf.lblTotalAmt.text       =  "\(symbol)\(priceFloat)"
                    strongSelf.lblTotal.text          =  "Total"
                    
                    
//                    if couponData.count != 0
//                    {
//                         strongSelf.couponListArr = couponData
//
//
////                         strongSelf.lblTotal.isHidden     = true
////                         strongSelf.lblTotalAmt.isHidden  = true
////                         strongSelf.lblTotalAmt.text      =  ""
////                         strongSelf.lblTotal.text         =  ""
//
//                        strongSelf.bottomViewHeightConstraint.constant = 100
//
//
//                    }else{
//
//
////                         strongSelf.lblTotal.isHidden     = false
////                         strongSelf.lblTotalAmt.isHidden  = false
//
//
//                        strongSelf.bottomViewHeightConstraint.constant = 150
//                    }
//
                    let arrCount = kSharedInstance.getArray(result["cartData"])
                    
                    
                      strongSelf.showCartCount(withCartCount: "\(arrCount.count)")
               
                     for dict in arrCount
                     {
                        let dictData1 = kSharedInstance.getDictionary(dict)

                        let option_id = String.getString(dictData1["option_id"])
                        if Int.getInt(option_id) != 0
                        {
                            let option_quantity = String.getString(dictData1["option_quantity"])
                            if Int.getInt(option_quantity) == 0
                            {
                                //strongSelf.outOfStockArr.append(dictData1)
                                strongSelf.btnProcceed.isUserInteractionEnabled = false
                                strongSelf.btnProcceed.setTitle("Please Delete out of Stock Product(s) ", for: .normal)

                            }
                        }else{
                            let product_quantity = String.getString(dictData1["product_quantity"])
                            if Int.getInt(product_quantity) == 0
                            {

                                strongSelf.outOfStockArr.append(dictData1)
                                strongSelf.btnProcceed.isUserInteractionEnabled = false
                                strongSelf.btnProcceed.setTitle("Please Delete out of Stock Product(s) ", for: .normal)
                            }
                        }
                     }
                    
                    let cartError = String.getString(other["cartError"])
                    if cartError == "No"
                    {
                        strongSelf.btnProcceed.isEnabled = true
                        strongSelf.btnProcceed.alpha = 1.0
                        
                    }else{
                        
                        strongSelf.btnProcceed.isEnabled = false
                        strongSelf.btnProcceed.alpha = 0.7
                        
                    }
                    
                    strongSelf.myCartTbl.reloadData()
                    strongSelf.tblBottom.reloadData()
                    
                }else{
                    //strongSelf.showOkAlert(withMessage: "success 0 : \(strongSelf.indexValue)")
                    strongSelf.myCartTbl.isHidden        = true
                    strongSelf.bottomView.isHidden       = true
                    strongSelf.btnProcceed.isHidden      = true
                    strongSelf.imgDataNotFound.isHidden  = false
                    strongSelf.btnContinueShop2.isHidden = false
                    strongSelf.imgDataNotFound.image     = #imageLiteral(resourceName: "datanotfound")
                    
//                    strongSelf.bottomView.isHidden = true
//                    strongSelf.imgDataNotFound.isHidden = false
//
////                    strongSelf.btnProcceed.isHidden = true
//                    strongSelf.imgDataNotFound.image = #imageLiteral(resourceName: "datanotfound")
//
//
//                    strongSelf.myCartTbl.isHidden = true
//                    strongSelf.imgDelete.alpha = 0.4
//                    strongSelf.btnDeleteCart.isUserInteractionEnabled = false
//                    if withId == 0
//                    {
//                        strongSelf.bottomView.isHidden = false
//
//                        strongSelf.btnProcceed.isHidden = false
//                        strongSelf.imgDataNotFound.image = nil
//
//                    }else{
//
//                        strongSelf.bottomView.isHidden = true
//                        strongSelf.imgDataNotFound.isHidden = false
//
//                        strongSelf.btnProcceed.isHidden = true
//                        strongSelf.imgDataNotFound.image = #imageLiteral(resourceName: "datanotfound")
//
//                    }
//
//                   if let tabItems = strongSelf.tabBarController?.tabBar.items {
//                               // In this case we want to modify the badge number of the third tab:
//                     let tabItem = tabItems[4]
//
//                     tabItem.badgeValue = nil
//
//
//                   }
//
//                     strongSelf.imgDataNotFound.isHidden = false
//                    strongSelf.bgImageView.removeFromSuperview()
//                    strongSelf.shimmerImageView.removeFromSuperview()
//                    strongSelf.bottomView.isHidden = true
//
//
//                    strongSelf.view.makeToast(String.getString(dictResponse[kMessage]), duration: 1.5, position: .center)
//
                   
                    
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
    

    
    //#MARK:-----------callLoginWebService---------
       private func callGetCurrencyListWebServiceHM()
       {
           
           let dictImg:[String : Any] = ["image" : UIImage(),
                                         "imageName" : "uploaded_file"]
           TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetCurrencyList, requestMethod: .post, requestImages: [dictImg], withProgressHUD: false, withProgessHUDTitle: "", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
               guard let strongSelf = self else { return }
               if errorType == .requestSuccess
               {
                   UIApplication.shared.endIgnoringInteractionEvents()
                   
                   let dictResponse = kSharedInstance.getDictionary(response)
                
                 //titleStr codeStr valueStr symbolStr
                   strongSelf.titleStr.removeAll()
                   strongSelf.codeStr.removeAll()
                   strongSelf.valueStr.removeAll()
                   strongSelf.symbolStr.removeAll()
                
                   if Int.getInt(dictResponse["success"]) == 1
                   {
                       let result = kSharedInstance.getDictionary(dictResponse["result"])
                       let currencyData = kSharedInstance.getArray(result["currencyData"])
                        for currData in currencyData
                       {
                          let dictData = kSharedInstance.getDictionary(currData)
                          strongSelf.titleStr.append(String.getString(dictData["title"]))
                          strongSelf.codeStr.append(String.getString(dictData["code"]))
                          strongSelf.valueStr.append(String.getString(dictData["value"]))
                          strongSelf.symbolStr.append(String.getString(dictData["symbol"]))
                        }
                   }else{
                   }
               }
               else if errorType == .requestFailed
               {
               }
               else
               {
               }
           })
           
       }
    
    //#MARK:-----------callGetCurrencyDetailsWebServiceHM---------
       private func callGetCurrencyDetailsWebServiceHM()
       {
           
           let dictImg:[String : Any] = ["image" : UIImage(),
                                         "imageName" : "uploaded_file"]
           TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetCurrencyDetails, requestMethod: .post, requestImages: [dictImg], withProgressHUD: false, withProgessHUDTitle: "", requestVideos: [String:  Any](), requestData: dictParamsCurr, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
               guard let strongSelf = self else { return }
               if errorType == .requestSuccess
               {
                   UIApplication.shared.endIgnoringInteractionEvents()
                   
                   let dictResponse = kSharedInstance.getDictionary(response)
                   
                   if Int.getInt(dictResponse["success"]) == 1
                   {
                       let result = kSharedInstance.getDictionary(dictResponse["result"])
                     let currencyData = kSharedInstance.getDictionary(result["currencyData"])
                    //print(currencyData)
                    kSharedUserDefaults.setCurrencyDetails(currencyDetails: currencyData)
                    kSharedUserDefaults.setCurrencySavedIn(currencySavedIn: true)
                  //  kSharedUserDefaults.setLoggedInUserDetails(loggedInUserDetails: userData)
                  //  kSharedUserDefaults.setUserLoggedIn(userLoggedIn: true)
                    
                  //   kSharedUserDefaults.
                       
                   }else{
                   }
               }
               else if errorType == .requestFailed
               {
               }
               else
               {
               }
           })
       }
}
extension MyCartViewController
{
    func selectDeselectCell(tableView:UITableView , indexPath : IndexPath)
    {
       
        if let arr = tableView.indexPathsForSelectedRows
        {
           // print("arr:\(arr)")
            for indx in arr
            {
                let dictData = kSharedInstance.getDictionary(self.cartArrData[indx.row])
                let  productId = String.getString(dictData["cart_product_id"])
                
                let option_value_id = String.getString(dictData["option_value_id"])
               let option_id = String.getString(dictData["option_id"])
                var newDict : Dictionary<String,Any> = ["":""]
                if Int.getInt(option_value_id) != 0 && Int.getInt(option_id) != 0
                {
                    newDict["productid"]     = "\(productId)"
                    newDict["optionid"]      = "\(option_id)"
                    newDict["optionvalueid"] = "\(option_value_id)"
                }else{
                    newDict["productid"] = "\(productId)"
                    newDict.removeValue(forKey: "optionid")
                    newDict.removeValue(forKey: "optionvalueid")
                }
               // debugPrint("newDict:\(newDict)")
                self.indexValue.append(indx.row)
                self.selectedData.append(newDict)
                
            }
           // debugPrint("self.selectedData_sunish:\(self.selectedData.count)")
            if Int.getInt(self.selectedData.count) > 0
            {
                self.imgDelete.alpha = 1.0
                self.btnDeleteCart.isUserInteractionEnabled = true
            }
            let dict = self.selectedData
            
            if let json = try? JSONSerialization.data(withJSONObject: dict, options: []) {
                if let content = String(data: json, encoding: String.Encoding.utf8) {
                    self.dictParamsDeleteCart[kProductData] =  content
                }
            }
            
        }
    }
}

