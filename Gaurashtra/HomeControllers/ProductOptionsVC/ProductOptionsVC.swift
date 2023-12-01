//
//  ProductOptionsVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 22/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit

class ProductOptionsVC: GaurashtraBaseVC {

    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    @IBOutlet weak var tblProdOption: UITableView!
    
    private var dictParams   =  [kUserId        : "",
                                 kProductId      : ""]
    
    private var dictParamsMWL = [kUserId        : "",
                                 kQuantity      : "",
                                 kProductId     : "",
                                 kActiontype    : "",
                                 kCurrencyCode  : "",
                                 kCurrencyValue : ""]
                                
    
    var productOptionsList : [Any]    = []
    var data : Dictionary<String,Any> = ["":""]
    var prodId : String = ""
    var productQtyList : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getDevice()
        self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        
         self.dictParams[kProductId] = String.getString(prodId)
        
        
        if isInternetAvailable()
        {
            self.callGetProductOptionListService(withServiceName: kGetProductOptionList, dictParms: self.dictParams)
        }else{
            showOkAlert(withMessage: kNetworkErrorAlert)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.dictParamsMWL[kCurrencyCode] = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
        
         self.dictParamsMWL[kCurrencyValue] = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
    }
    

    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
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
extension ProductOptionsVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productOptionsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblProdOption.dequeueReusableCell(withIdentifier: ProductOptionsTVC.cellIdentifier(), for: indexPath) as! ProductOptionsTVC
      
        cell.configureProdOptionCell(withDictData: kSharedInstance.getDictionary(productOptionsList[indexPath.row]), forIndxPath: indexPath, data: self.data, btnAddCart: {(btnAddCart : UIButton) in
            
            //print("btnAddCart")
            
            let userId = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
            
            if String.getLength(userId) != 0
            {
            
            
            let dictData = kSharedInstance.getDictionary(self.productOptionsList[indexPath.row])
            
            //print(dictData)
            
            self.dictParamsMWL[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
            
            
            let selectedQty = String.getString(dictData["selectedQty"])
                             
             let selecteIndex = Int.getInt(dictData["selecteIndex"])
             
             let selectetag = Int.getInt(dictData["selectetag"])
             if selecteIndex == indexPath.row && selectetag == 1
             {
                 self.dictParamsMWL[kQuantity] = selectedQty
             }else{
                 
                 self.dictParamsMWL[kQuantity] = "1"
             }
            
            self.dictParamsMWL[kProductId] = String.getString(self.prodId)
            
            self.dictParamsMWL[kOptionvalueid] = String.getString(dictData["option_value_id"])
            
            
            self.dictParamsMWL[kOptionid] = String.getString(dictData["option_id"])
            
            self.dictParamsMWL[kActiontype] = "add"
            
            if isInternetAvailable()
            {
                self.callAddtoCartWebService(withServiceName: kManageCart, dictParms: self.dictParamsMWL)
                
            }else{
                self.showOkAlert(withMessage: kNetworkErrorAlert)
            }
            }else{
                
                self.loginVc()
                
            }
            
        }, btnQnty: {(btnQnty : UIButton) in
            
            //print("qty")
            
            
            
            var dictD = kSharedInstance.getDictionary(self.productOptionsList[indexPath.item])
                       
           //print(dictD)
           
           let product_quantity = Int.getInt(dictD["option_quantity"])
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
                  
                  

                  self.productOptionsList.remove(at: indexPath.row)
                  self.productOptionsList.insert(dictD, at: indexPath.row)

                  self.tblProdOption.reloadData()

              })
              picker.viewContainer.backgroundColor = kWhiteColor

           }
         
            
        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dictData = kSharedInstance.getDictionary(productOptionsList[indexPath.row])
        self.productDetailsProdListVC(withProductId: prodId, option_value_id: String.getString(dictData["option_value_id"]))
    }
    
    func loginVc()
    {
        
        let sb : UIStoryboard = UIStoryboard(name: kLoginPlaceholder, bundle: nil)
                
                let nextVC = sb.instantiateViewController(withIdentifier: LoginViewController.storyboardId()) as! LoginViewController
        
        
                kSharedUserDefaults.removeObject(forKey: "LoginView")
                
                self.present(nextVC, animated: true) { }
    }
    
    private func productDetailsProdListVC(withProductId prodId : String,option_value_id : String)
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
    //#MARK:-----------callCategoryListWebService---------
    private func callGetProductOptionListService(withServiceName serviceName : String , dictParms : Dictionary<String,Any>)
    {
        
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: serviceName, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParms, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    
                    if String.getString(serviceName) != kManageCart
                    {
                        let productData = kSharedInstance.getDictionary(result["productData"])
                        
                        strongSelf.data = kSharedInstance.getDictionary(productData["data"])
                      
                        strongSelf.productOptionsList = kSharedInstance.getArray(productData["option"])
                        strongSelf.tblProdOption.reloadData()
                    }
                    
                    let cartArrData = kSharedInstance.getArray(result["cartData"])
                    
                    strongSelf.showCartCount(withCartCount: "\(cartArrData.count)")
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
    
    
    //#MARK:-----------callCategoryListWebService---------
    private func callAddtoCartWebService(withServiceName serviceName : String , dictParms : Dictionary<String,Any>)
    {
        
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: serviceName, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParms, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    
                    
                    let cartArrData = kSharedInstance.getArray(result["cartData"])
                    
                    strongSelf.showCartCount(withCartCount: "\(cartArrData.count)")
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
    
}

