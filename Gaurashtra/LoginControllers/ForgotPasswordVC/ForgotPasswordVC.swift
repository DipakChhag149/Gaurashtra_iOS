//
//  ForgotPasswordVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 01/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class ForgotPasswordVC: GaurashtraBaseVC {

    
    @IBOutlet weak var txtField: UITextField!
    fileprivate var dictParams =  [kEmail : ""]
    @IBOutlet weak var upperView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapToForgotPassword(_ sender: UIButton) {
      
        self.dictParams[kEmail] = self.txtField.text
        self.checkValidation()
      
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
     //   self.navigationController?.popViewController(animated: true)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func checkValidation()
    {
        if String.getLength(dictParams[kEmail]) == 0 || !String.getString(dictParams[kEmail]).isEmail()
        {
            
            showOkAlert(withMessage: kEnterValidEmail)
            
        }else{
            
            if isInternetAvailable()
            {
                print(dictParams)
                UIApplication.shared.beginIgnoringInteractionEvents()
                self.callForgotPasswordWebService()
                
            }
            else{
                showOkAlert(withMessage: kNetworkErrorAlert)
            }
            
            
        }
    }
    
    
    //#MARK:-----------callUpdateAccountWebService---------
    private func callForgotPasswordWebService()
    {
        //kGetResetPassword kGetForgotPassword
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetForgotPassword, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
            
                if Int.getInt(dictResponse["success"]) == 1
                {
                    
                   strongSelf.resetPasswordVC()
                    
                    
                    
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
    
    func resetPasswordVC()
    {
        let sb : UIStoryboard = UIStoryboard(name: kLoginPlaceholder, bundle: nil)
        let nextViewController = sb.instantiateViewController(withIdentifier: ResetPasswordViewController.storyboardId()) as! ResetPasswordViewController
     //   self.navigationController?.pushViewController(nextViewController, animated: true)
        
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    
}
