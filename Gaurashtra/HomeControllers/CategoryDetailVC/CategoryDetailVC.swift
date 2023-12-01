//
//  CategoryDetailVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 07/01/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit

class CategoryDetailVC: GaurashtraBaseVC {
    
    let bgImageView      = UIImageView(image: #imageLiteral(resourceName: "graybox2"))
    let shimmerImageView = UIImageView(image: #imageLiteral(resourceName: "gaybox1"))
    
    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    
    @IBOutlet weak var tblCategoryDetails: UITableView!
    
    @IBOutlet weak var lblHeader: UILabel!
    
    private var dictParams = [kUserId      : "",
                              kBrandid     : "",
                              kDeviceId    : "",
                              kPageNo      : "",
                              kPerpageData : ""]
    ////kPageNo kPerpageData
    
    private var dictParamsAddCart =    [kUserId        : "",
                                        kQuantity      : "",
                                        kProductId     : "",
                                        kActiontype    : "",
                                        kOptionid      : "",
                                        kOptionvalueid : "",
                                        kCouponCode    : "",
                                        kCurrencyCode  : "",
                                        kCurrencyValue : ""]
    
    //currencyCode, currencyValue
    var arrDataList : [Any] = []
    
    var serviceName : String = ""
    var headerTitle : String = ""
    var idNo        : Int    = 0
    var brandId     : String = ""
    
    var productQtyList : [String] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDevice()
        //print(brandId)
        
        self.lblHeader.text = headerTitle
        
        self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        self.dictParams[kBrandid] = brandId
        self.dictParams[kPageNo]      = "1"
        self.dictParams[kPerpageData] = "15000"
        
        
        let deviceToken = String.getString(kSharedUserDefaults.string(forKey: "deviceToken"))
                            
        if String.getLength(deviceToken) != 0
        {
            self.dictParams[kDeviceId]   = deviceToken
            
        }else{
            
            self.dictParams[kDeviceId]   = "yuu75k6j4h3k36k336l3h6l363"
        }

        
        
        if isInternetAvailable()
        {
            self.callGetRecentlyViewedListWebService(withServiceName: serviceName)
            
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
    
    
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
//#MARK:  UITableViewDelegate,UITableViewDataSource 

extension CategoryDetailVC : UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tblCategoryDetails.dequeueReusableCell(withIdentifier: CategoryDetailTVC.cellIdentifier(), for: indexPath) as! CategoryDetailTVC
        

        cell.configureCellCategoryListTVC(withDictData: kSharedInstance.getDictionary(arrDataList[indexPath.row]), forIndxPath: indexPath, btnAddCart: { (btnAddcart : UIButton) in
            
            let userId = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
            
            if String.getLength(userId) != 0
            {
    
                let dictData = kSharedInstance.getDictionary(self.arrDataList[indexPath.item])
                
                let product_quantity = String.getString(dictData["product_quantity"])
                              
               if Int.getInt(product_quantity) != 0
               {
                
                
                
                
                let option_id = String.getString(dictData["option_id"])
                
                if Int.getInt(option_id) != 0
                {
                    
                                   // let dictData = kSharedInstance.getDictionary(self.productData[indexPath.item])
                   let prodid = String.getString(dictData["product_id"])
                   //print(dictData)
                   //print(prodid)

                   let option_id = String.getString(dictData["option_id"])
                   if option_id != "0"
                   {
                       self.productOptionsVC(withProductId: String.getString(dictData["product_id"]))
                   }

                }else{
                    
                self.dictParamsAddCart[kCurrencyCode] = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
            
                self.dictParamsAddCart[kCurrencyValue] = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
                self.dictParamsAddCart[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
                
                 let selectedQty = String.getString(dictData["selectedQty"])
                
                
                let selecteIndex = Int.getInt(dictData["selecteIndex"])
                                 
                 let selectetag = Int.getInt(dictData["selectetag"])
                 if selecteIndex == indexPath.row && selectetag == 1
                 {
                     self.dictParamsAddCart[kQuantity] = selectedQty
                 }else{
                     
                     self.dictParamsAddCart[kQuantity] = "1"
                 }
            
            //print("AddtoCart")
            
            self.dictParamsAddCart[kActiontype] = "add"
                //kOptionid kOptionvalueid kCouponCode
    
            
            self.dictParamsAddCart[kProductId]  = String.getString(dictData["product_id"])
    
    
           // let option_id = String.getString(dictData["option_id"])
    
            
            self.dictParamsAddCart[kOptionid]  = String.getString(dictData["option_id"])
            self.dictParamsAddCart[kOptionvalueid]  = String.getString(dictData["option_value_id"])
               
            let product_id = String.getString(dictData["product_id"])
                           
            if String.getLength(product_id) != 0
             {
               self.callAddCardOthersProdctsListVCWebServices()
                
             }else{
               
               self.view.makeToast("Something error...")
              }
                
              }
               }else{
                
               
                let dictData = kSharedInstance.getDictionary(self.arrDataList[indexPath.item])
                                   
                self.notifyMeVC(withProductId: String.getString(dictData["product_id"]) )
                
                
                
                }
            
            }else{
                
                self.loginVc()
            }
            
        } , btnPackOff: { (btnPackOff : UIButton) in
            
            
            
           var dictD = kSharedInstance.getDictionary(self.arrDataList[indexPath.item])
                       
               //print(dictD)
               
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
                      
                      

                      self.arrDataList.remove(at: indexPath.row)
                      self.arrDataList.insert(dictD, at: indexPath.row)

                      self.tblCategoryDetails.reloadData()

                  })
                  picker.viewContainer.backgroundColor = kWhiteColor

               }
            
            
            
            
            
            
            
            
            
//            var dictD = kSharedInstance.getDictionary(self.arrDataList[indexPath.item])
//
//            let discount_quantity =  String.getString(dictD["discount_quantity"])
//
//            let packOfQty = "Pack of " + discount_quantity
//
//            if discount_quantity != "0"
//            {
//
//                let picker = RSPickerView.init(view: self.view, arrayList: [packOfQty], keyValue: nil, handler: { (selectedIndex: NSInteger, response: Any?) in
//
//                    dictD["selecteIndex"] = indexPath.row
//                    dictD["selectetag"]   = 1
//
//                    self.arrDataList.remove(at: indexPath.row)
//                    self.arrDataList.insert(dictD, at: indexPath.row)
//
//                    self.tblCategoryDetails.reloadData()
//
//                })
//                picker.viewContainer.backgroundColor = kWhiteColor
//
//            }
            
            
        }, btnView: { (btnView : UIButton) in
            
            let dictData = kSharedInstance.getDictionary(self.arrDataList[indexPath.item])
            let prodid = String.getString(dictData["product_id"])
            //print(dictData)
            //print(prodid)
            
            let option_id = String.getString(dictData["option_id"])
            if option_id != "0"
            {
                self.productOptionsVC(withProductId: String.getString(dictData["product_id"]))
            }
            
            
        })
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dictDataRecom = kSharedInstance.getDictionary(self.arrDataList[indexPath.item])
        self.productDetailsRecentVC(withProductId: String.getString(dictDataRecom["product_id"]))
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         let dictData1 = kSharedInstance.getDictionary(self.arrDataList[indexPath.item])
               
        //print(dictData1)
        
                let product_id = String.getString(dictData1["product_id"])
               
        
        
               if Int.getInt(product_id) != 0
               {
                    return 140
                   
               }else{
                   
                   return 0
               }
    }
    
    func productOptionsVC(withProductId prodId : String)
    {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextVC = sb.instantiateViewController(withIdentifier: ProductOptionsVC.storyboardId()) as! ProductOptionsVC
        
        nextVC.prodId  = prodId
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    
    
    func loginVc()
       {
           
           let sb : UIStoryboard = UIStoryboard(name: kLoginPlaceholder, bundle: nil)
                   
                   let nextVC = sb.instantiateViewController(withIdentifier: LoginViewController.storyboardId()) as! LoginViewController
           
           
                   kSharedUserDefaults.removeObject(forKey: "LoginView")
                   
                   self.present(nextVC, animated: true) { }
       }
    
    //
    //#MARK:-----------callLoginWebService---------
    private func callGetRecentlyViewedListWebService(withServiceName serviceName: String)
    {
        
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: serviceName, requestMethod: .post, requestImages: [dictImg], withProgressHUD: false, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                //print(dictResponse)
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    
                    strongSelf.bgImageView.removeFromSuperview()
                    strongSelf.shimmerImageView.removeFromSuperview()
                    
                    //print(result)
                    
                    switch strongSelf.idNo{
                    case 1:
                        
                        strongSelf.arrDataList = kSharedInstance.getArray(result["topSellingData"])
                    case 2:
                        let todayDeal = kSharedInstance.getDictionary(result["todayDeal"])
                        strongSelf.arrDataList = kSharedInstance.getArray(todayDeal["data"])
                    case 3:
                        
                        let bestOf = kSharedInstance.getDictionary(result["bestOf"])
                        
                        
                        strongSelf.arrDataList = kSharedInstance.getArray(bestOf["data"])
                        
                    case 4:
                        strongSelf.arrDataList = kSharedInstance.getArray(result["recentlyViewData"])
                        
                    case 5:
                        
                        strongSelf.arrDataList = kSharedInstance.getArray(result["recommendedData"])
                        
                    case 6:
                        
                        strongSelf.arrDataList = kSharedInstance.getArray(result["brandProductData"])
                        
                         
                        
                    default:
                        break
                    }
                    
                    
                    
                    strongSelf.tblCategoryDetails.reloadData()
                    
                }else{
                    
                    strongSelf.bgImageView.removeFromSuperview()
                    strongSelf.shimmerImageView.removeFromSuperview()
                    
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
    
    private func callAddCardOthersProdctsListVCWebServices()
    {
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kManageCart, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParamsAddCart, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    
                    let arrCount = kSharedInstance.getArray(result["cartData"])
                    
                    strongSelf.showCartCount(withCartCount: "\(arrCount.count)")
                    
                    strongSelf.view.makeToast(String.getString(dictResponse[kMessage]), duration: 1.5, position: .center)
                    
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
    
    
    func productDetailsRecentVC(withProductId prodId : String)
    {
        
        
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextVC = sb.instantiateViewController(withIdentifier: ProductDetailsViewController.storyboardId()) as! ProductDetailsViewController
        
        nextVC.product_id  = prodId
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
}
