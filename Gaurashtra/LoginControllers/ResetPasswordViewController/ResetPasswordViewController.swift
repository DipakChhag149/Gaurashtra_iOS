//
//  ResetPasswordViewController.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 07/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class ResetPasswordViewController: GaurashtraBaseVC {

    
    @IBOutlet weak var resetPaswordTbl: UITableView!
    fileprivate var dictParams =  [kPassword     : "",
                                   kConPassword  : "",
                                   kOtp          : ""]
                                  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapToResetPassword(_ sender: UIButton) {
     
       // self.checkValidation()
        self.callResetUserPasswordWebService()
      
    }
    @IBAction func tapToLogin(_ sender: UIButton) {
        kSharedAppDelegate.showloginView()

    }
    func checkValidation()
    {
        if String.getLength(dictParams[kOtp]) == 0
        {
            showOkAlert(withMessage: kPleaseEnterOPT)
            
        }else  if String.getLength(dictParams[kPassword]) == 0
        {
            showOkAlert(withMessage: kEnterPassword)
            
        }else  if String.getLength(dictParams[kPassword]) <= 5
        {
            showOkAlert(withMessage: kEnterMinimumPassword)
            
        } else  if String.getLength(dictParams[kConPassword]) == 0
        {
            showOkAlert(withMessage: kEnterConPassword)
            
        } else  if String.getString(dictParams[kPassword]) != String.getString(dictParams[kConPassword])
        {
            showOkAlert(withMessage: kPasswordNotMatch)
            
        }else{
            
            if isInternetAvailable()
            {
                print(dictParams)
               UIApplication.shared.beginIgnoringInteractionEvents()
                
                self.callResetUserPasswordWebService()
            }
            else{
                showOkAlert(withMessage: kNetworkErrorAlert)
            }
            
            
        }
    }
    
}
//#MARK:  UITableViewDataSource,UITableViewDelegate 

extension ResetPasswordViewController : UITableViewDataSource,UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ResetPassworCellType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row
        {
        case  ResetPassworCellType.otp.rawValue, ResetPassworCellType.password.rawValue,ResetPassworCellType.confirmPassword.rawValue:
            
            return getTextFieldTableCell(forIndexPath: indexPath)
            
        default:
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        switch indexPath.row
        {
        case ResetPassworCellType.otp.rawValue, ResetPassworCellType.password.rawValue,ResetPassworCellType.confirmPassword.rawValue:
            return 55.0
            
        default:
            return 0.0
        }
    }
    
    //#MARK:--getTextFieldTableCell--
    private func getTextFieldTableCell(forIndexPath indexPath: IndexPath) -> ResetPasswordTVC
    {
        let cellTVTextField = self.resetPaswordTbl.dequeueReusableCell(withIdentifier: ResetPasswordTVC.cellIdentifier()) as! ResetPasswordTVC
        
        
        
        cellTVTextField.configureCell(withData: dictParams, forIndexPath: indexPath, getTextField: { (textField: UITextField) in
            
            switch textField.tag
            {
            case ResetPassworCellType.otp.rawValue:
                self.dictParams[kOtp] = String.getString(textField.text)
                
            case ResetPassworCellType.password.rawValue:
                self.dictParams[kPassword] = String.getString(textField.text)
                
                
                
            case ResetPassworCellType.confirmPassword.rawValue:
                self.dictParams[kConPassword] = String.getString(textField.text)
                
                
            default:
                break
            }
           
            
        })
        
        
        
        return cellTVTextField
    }
    //#MARK: -checkValidation--
   
    
    //#MARK:-----------callResetUserPasswordWebService---------
    private func callResetUserPasswordWebService()
    {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetResetPassword, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
               UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                print("hi")
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                  print(result)
                    
                    kSharedAppDelegate.showloginView()
                    
                    
                  strongSelf.view.makeToast(String.getString(dictResponse[kMessage]), duration: 1.5, position: .center)
                    
                    
                    
                }else{
                    
                    strongSelf.view.makeToast(String.getString(dictResponse[kMessage]), duration: 1.5, position: .center)
                    
                    
                }
                
            }//9973454578
            else if errorType == .requestFailed
            {
              //  UIApplication.shared.endIgnoringInteractionEvents()
            }
            else
            {
            }
        })
    }
    
   
}
