//
//  ChangePasswordVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 19/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class ChangePasswordVC:GaurashtraBaseVC{

    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    
   
    @IBOutlet weak var txtFieldCurrentPassword: UITextField!
    
    @IBOutlet weak var txtFieldNewPass: UITextField!
    
    @IBOutlet weak var txtFieldConfirmPass: UITextField!
    
    private var dictParams =  [kUserId     : "",
                              kOldPassword : "",
                              kPassword    : "",
                              kConPassword : ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDevice()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tapToChangePassword(_ sender: UIButton) {
        
        self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
         self.dictParams[kOldPassword] = String.getString(self.txtFieldCurrentPassword.text)
        self.dictParams[kPassword]     = String.getString(self.txtFieldNewPass.text)
        self.dictParams[kConPassword]  = String.getString(self.txtFieldConfirmPass.text)
        
        self.checkValidation()
        
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
    
    //#MARK: -checkValidation--
    func checkValidation()
    {
        if String.getLength(dictParams[kOldPassword]) == 0
        {
            
            showOkAlert(withMessage: kEnterPassword)
            
        } else  if String.getLength(dictParams[kPassword]) == 0
        {
            showOkAlert(withMessage: kNewPassword)
            
        }else  if String.getLength(dictParams[kConPassword]) == 0
        {
            showOkAlert(withMessage: kEnterConPassword)
            
        }else{
            
            if isInternetAvailable()
            {
               
                UIApplication.shared.beginIgnoringInteractionEvents()
                self.callChangePasswordWebService()
            }
            else{
                showOkAlert(withMessage: kNetworkErrorAlert)
            }
            
            
        }
    }
    
    
    
    //#MARK:-----------callLoginWebService---------
    private func callChangePasswordWebService()
    {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetChangePassword, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait...", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
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
