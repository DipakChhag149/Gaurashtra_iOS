//
//  CouponVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 05/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit
import Toast_Swift
protocol CouponVCDelegate : class  {
       func getCouponCode(_ couponCode: String)
   }
class CouponVC: GaurashtraBaseVC {
   
    var delegate:CouponVCDelegate?
    @IBOutlet weak var tblCoupon: UITableView!
    
    var couponList : [Any] = []
    var couponCode : String = ""
    //userid, couponCode, currencyCode, currencyValue
    fileprivate var dictParams = [kUserId        : "",
                                  kCurrencyCode  : "",
                                  kCurrencyValue : "",
                                  kCouponCode    : ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        
        self.tblCoupon.estimatedRowHeight = 100
        self.tblCoupon.rowHeight          = UITableView.automaticDimension
        
        
    }
    
    @IBAction func tapToSubmit(_ sender: UIButton) {
        
       // let dictData = kSharedInstance.getDictionary(<#T##dictData: Any?##Any?#>)
         self.dictParams[kCurrencyCode] = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
        self.dictParams[kCurrencyValue] = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
        self.dictParams[kUserId]        = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        self.dictParams[kEmail] = String.getString(LoginDataModel.getLoggedInUserDetails().email)
        self.checkValidation()
    }
    
    

    @IBAction func tapToDismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func checkValidation()
    {
        
        if String.getLength(dictParams[kCouponCode]) == 0
        {
            self.showOkAlert(withMessage: kSelectCoupon)
            
        }else{
            
            if isInternetAvailable()
            {
                //print(dictParams)
                //UIApplication.shared.beginIgnoringInteractionEvents()
                self.callApplyCouponWebService()
            }
            else{
                
                self.showOkAlert(withMessage: kNetworkErrorAlert)
                
            }
            
            
        }
        
    }
    

}
//#MARK:  UITableViewDelegate,UITableViewDataSource 
extension CouponVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return couponList.count
  
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblCoupon.dequeueReusableCell(withIdentifier: CouponTVC.cellIdentifier(), for: indexPath) as! CouponTVC
        
        cell.configureCell(withDictData: kSharedInstance.getDictionary(self.couponList[indexPath.item]), forIndxPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         let cell = tblCoupon.dequeueReusableCell(withIdentifier: CouponTVC.cellIdentifier(), for: indexPath) as! CouponTVC
        cell.imgView.image = #imageLiteral(resourceName: "dot")
        let dictData = kSharedInstance.getDictionary(self.couponList[indexPath.item])
        self.dictParams[kCouponCode] = String.getString(dictData["coupon_code"])
        self.couponCode = String.getString(dictData["coupon_code"])
        
    }
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//
//        //         let cell = tblCoupon.dequeueReusableCell(withIdentifier: CouponTVC.cellIdentifier(), for: indexPath) as! CouponTVC
//        //
//        //         cell.imgView.image = #imageLiteral(resourceName: "redioUncheck")
//        //
//
//    }
    
    //#MARK:-----------callLoginWebService---------
    private func callApplyCouponWebService()
    {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kApplyCoupon, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                //                strongSelf.imgProfile.image = strongSelf.img
                //                self?.callgetStateWebService()
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    let appliedCouponData = kSharedInstance.getDictionary(result["appliedCouponData"])
                    
                    print(appliedCouponData)
                    
                   // strongSelf.showOkAlert(withMessage: String.getString(appliedCouponData["coupon_message"]))
                    
                    //strongSelf.showOkAlert(withMessage: "Coupon code applied successfully")
                    strongSelf.delegate?.getCouponCode(strongSelf.couponCode)
                    
                    strongSelf.dismiss(animated: true) {
                        
                    }
                   
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
