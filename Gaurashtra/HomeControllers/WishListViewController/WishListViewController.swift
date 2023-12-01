//
//  WishListViewController.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 06/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit
//import Toast_Swift

class WishListViewController: GaurashtraBaseVC {

    let gradientLayer = CAGradientLayer()
    let bgImageView = UIImageView(image: #imageLiteral(resourceName: "graybox2"))
    let shimmerImageView = UIImageView(image: #imageLiteral(resourceName: "gaybox1"))
    
    var productQtyList : [String] = []
    
    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var innerView: UIView!
    
    //@IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var wishListTbl: UITableView!
    
    private var dictParams = [kUserId: ""]
    
    private var dictParamsMWL = [kUserId        : "",
                                 kQuantity      : "",
                                 kProductId     : "",
                                 kActiontype    : ""]
                                
    
    var wishListArrData : [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.getDevice()
        let shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                   y: 42,
                                                   width: kScreenWidth,
                                                   height: 2))
//        self.titleLbl.layer.masksToBounds = false
//        self.titleLbl.layer.shadowColor = UIColor(red: 168.0/255.0, green: 210.0/255.0, blue: 223.0/255.0, alpha: 1.0).cgColor
//        self.titleLbl.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        self.titleLbl.layer.shadowOpacity = 0.9
//        self.titleLbl.layer.shadowRadius = 3.0
//        self.titleLbl.layer.shadowPath = shadowPath.cgPath
        
        
        self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        
        if isInternetAvailable()
        {
            self.callWishListWebService(withServiceName: kGetWishlist, dictParms: dictParams, withProgressHUD: false)
            
            
            kSharedInstance.setupShimmeringImage(withView: self.view, backGrroundImgV: bgImageView, shimmerImageView: shimmerImageView)
            
        }else{
            
            showOkAlert(withMessage: kNetworkErrorAlert)
            
        }
  
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
                  ////print("iphone XS")
                  
              case 2688://iphone XS Max
                  
                  ////print("iphone XS Max")
                  self.headerViewConstraintH.constant = 84
                  self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
                  
              case 1792://iphone XR
                  self.headerViewConstraintH.constant = 84
                  self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
              default:
                  ////print("unknown")
                  break
                  
              }
              
          }
          
      }
    

    @IBAction func backAction(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
//#MARK:  UITableViewDelegate,UITableViewDataSource 
extension WishListViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishListArrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = wishListTbl.dequeueReusableCell(withIdentifier: WishListTVC.cellIdentifier(), for: indexPath) as! WishListTVC
        cell.configureWishListCell(withDictData: kSharedInstance.getDictionary(wishListArrData[indexPath.row]), forIndxPath: indexPath, btnPackof: {(btnPackof : UIButton) in
 
              var dictD = kSharedInstance.getDictionary(self.wishListArrData[indexPath.item])
                       
               ////print(dictD)
               
               let product_quantity = Int.getInt(dictD["product_quantity"])
               if product_quantity != 0
               {
                   
                   self.productQtyList.removeAll()
                                                
                  for index in 1...product_quantity {
                    //product_quantity
                      self.productQtyList.append(String.getString(index))

                  }
                  
                  let picker = RSPickerView.init(view: self.view, arrayList: self.productQtyList, keyValue: nil, handler: { (selectedIndex: NSInteger, response: Any?) in

                      dictD["selecteIndex"] = indexPath.row
                      dictD["selectetag"]   = 1
                      
                      dictD["selectedQty"]  =  self.productQtyList[selectedIndex]
                      
                      

                      self.wishListArrData.remove(at: indexPath.row)
                      self.wishListArrData.insert(dictD, at: indexPath.row)

                      self.wishListTbl.reloadData()

                  })
                  picker.viewContainer.backgroundColor = kWhiteColor

               }
           
            
            
        }, btnAddCart: {(btnAddCart : UIButton) in
            
            ////print("btnAddCart")
            
//               let dictData = kSharedInstance.getDictionary(self.wishListArrData[indexPath.row])
//
//            ////print(dictData)
//
//            self.dictParamsMWL[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
//
//            self.dictParamsMWL[kQuantity] = "1"
//            self.dictParamsMWL[kProductId] = String.getString(dictData["product_id"])
//
//            self.dictParamsMWL[kOptionvalueid] = String.getString(dictData["option_value_id"])
//
//
//            self.dictParamsMWL[kOptionid] = String.getString(dictData["option_id"])
//
//            self.dictParamsMWL[kActiontype] = "add"
//
//            if isInternetAvailable()
//            {
//                self.callWishListWebService(withServiceName: kManageCart, dictParms: self.dictParamsMWL)
//
//            }else{
//                self.showOkAlert(withMessage: kNetworkErrorAlert)
//            }
            
            
            
            let dictData = kSharedInstance.getDictionary(self.wishListArrData[indexPath.item])
              
              let product_quantity = String.getString(dictData["product_quantity"])
             
              if Int.getInt(product_quantity) != 0
              {
             
                 let option_id = String.getString(dictData["option_id"])
              
                  if Int.getInt(option_id) != 0
                  {
                  
                                 // let dictData = kSharedInstance.getDictionary(self.productData[indexPath.item])
                 let prodid = String.getString(dictData["product_id"])
                 ////print(dictData)
                 ////print(prodid)

                 let option_id = String.getString(dictData["option_id"])
                 if option_id != "0"
                 {
                     self.productOptionsVC(withProductId: String.getString(dictData["product_id"]))
                 }

              }else{
                  
                  let selectedQty = String.getString(dictData["selectedQty"])
                                   
                   let selecteIndex = Int.getInt(dictData["selecteIndex"])
                   
                   let selectetag = Int.getInt(dictData["selectetag"])
                   if selecteIndex == indexPath.row && selectetag == 1
                   {
                       self.dictParamsMWL[kQuantity] = selectedQty
                   }else{
                       
                       self.dictParamsMWL[kQuantity] = "1"
                   }
                   self.dictParamsMWL[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
                   self.dictParamsMWL[kCurrencyCode] = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
                    self.dictParamsMWL[kCurrencyValue] = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
                   //kCurrencyCode kCurrencyValue
                   self.dictParamsMWL[kActiontype] = "add"
                   //kOptionid kOptionvalueid kCouponCode
                   self.dictParamsMWL[kProductId]  = String.getString(dictData["product_id"])
                 //  let option_id = String.getString(dictData["option_id"])
                   self.dictParamsMWL[kOptionid]  = String.getString(dictData["option_id"])
                   let option_value_id = String.getString(dictData["option_value_id"])
                   
                   self.dictParamsMWL[kOptionvalueid]  = String.getString(dictData["option_value_id"])
                   
                  let product_id = String.getString(dictData["product_id"])
                 
                 if String.getLength(product_id) != 0
                 {
                    self.callWishListWebService(withServiceName: kManageCart, dictParms: self.dictParamsMWL, withProgressHUD: true)
                 }else{
                     
                     self.view.makeToast("Something error...")
                 }
            
               }
              }else{
                  
                  let dictData = kSharedInstance.getDictionary(self.wishListArrData[indexPath.item])
                  
                  ////print(dictData)
                  
                  self.notifyMeVC(withProductId: String.getString(dictData["product_id"]))
                  
              }
            
            
            
            
            
        }, btnDelete: {(btnDelete : UIButton) in
            
            let dictData = kSharedInstance.getDictionary(self.wishListArrData[indexPath.row])
            
            
            self.dictParamsMWL[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
      
             self.dictParamsMWL[kQuantity] = String.getString(dictData["product_quantity"])
             self.dictParamsMWL[kProductId] = String.getString(dictData["product_id"])
            
             self.dictParamsMWL[kActiontype] = "delete"
            
           if isInternetAvailable()
           {
            self.callWishListWebService(withServiceName: kManageWishlist, dictParms: self.dictParamsMWL, withProgressHUD: false)
            
           }else{
            self.showOkAlert(withMessage: kNetworkErrorAlert)
            }
        
            
        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dictData = kSharedInstance.getDictionary(self.wishListArrData[indexPath.row])
        
        self.productDetailsWishListVC(withProductId: String.getString(dictData["product_id"]), option_value_id: String.getString(dictData["option_value_id"]))
    }
    
    //#MARK:-----------callCategoryListWebService---------
    private func callWishListWebService(withServiceName serviceName : String , dictParms : Dictionary<String,Any>, withProgressHUD progressHUD : Bool)
    {
        
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: serviceName, requestMethod: .post, requestImages: [dictImg], withProgressHUD: false, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParms, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                strongSelf.bgImageView.removeFromSuperview()
                strongSelf.shimmerImageView.removeFromSuperview()
                
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                
                    if String.getString(serviceName) != kManageCart
                    {
                        strongSelf.wishListArrData = kSharedInstance.getArray(result["wishlistData"])
                        strongSelf.wishListTbl.reloadData()
                    }
                   
                  //  let cartArrData = kSharedInstance.getArray(result["cartData"])
                    
                   // strongSelf.showCartCount(withCartCount: "\(cartArrData.count)")
                  //  strongSelf.view.makeToast(String.getString(dictResponse[kMessage]), duration: 1.5, position: .center)
                    
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
    
    
    
    func productOptionsVC(withProductId prodId : String)
    {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextVC = sb.instantiateViewController(withIdentifier: ProductOptionsVC.storyboardId()) as! ProductOptionsVC
        
        nextVC.prodId  = prodId
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    func productDetailsWishListVC(withProductId prodId : String ,option_value_id : String)
    {
        
        
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextVC = sb.instantiateViewController(withIdentifier: ProductDetailsViewController.storyboardId()) as! ProductDetailsViewController
        if String.getLength(option_value_id) != 0
        {
            nextVC.option_value_id = option_value_id
        }
        nextVC.product_id  = prodId
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
}
