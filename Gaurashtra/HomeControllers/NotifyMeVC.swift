//
//  NotifyMeVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 29/01/20.
//  Copyright © 2020 Gaurashtra. All rights reserved.
//

import UIKit

class NotifyMeVC: GaurashtraBaseVC,UITextViewDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldName: UITextField!
    var prodId : String = ""
    // //notifyMe username, email, query, productid
    private var dictParams = [kUsername  : "",
                              kEmail     : "",
                              kQuery     : "",
                              kProductId : ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dictParams[kProductId] = prodId
        
        view.isOpaque = false
        view.backgroundColor = .clear
        
        txtView.delegate = self
        txtView.text = "Remarks"
        txtView.textColor = UIColor.lightGray
        
    }
    //notifyMe username, email, query, productid
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtView.textColor == UIColor.lightGray {
            txtView.text = nil
            txtView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtView.text.isEmpty {
            txtView.text = "Remarks"
            txtView.textColor = UIColor.lightGray
        }
    }

    
    func checkValidation()
       {
        //kEmail
        
        if String.getLength(self.dictParams[kUsername]) == 0
        {
            self.showOkAlert(withMessage: kEnterUserName)
            
            
        }else if String.getLength(self.dictParams[kEmail]) == 0 && !String.getString(self.dictParams[kEmail]).isEmail()
        {
            
             self.showOkAlert(withMessage: kEnterValidEmail)
            
            
        }else if String.getLength(self.dictParams[kQuery]) == 0 || txtView.textColor == UIColor.lightGray
        {
            self.view.makeToast(kEnterMessage, duration: 1.5, position: .center)
        }else{
            
            if isInternetAvailable()
            {
                self.callNotifyMeWebService()
                
            }else{
                
                self.view.makeToast(kNetworkErrorAlert, duration: 1.5, position: .center)
            }
            
        }
        
           
           
       }
    
    
    @IBAction func bckAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func tapToNotifyMe(_ sender: UIButton) {
        
        
        self.dictParams[kUsername] = String.getString(self.txtFieldName.text)
        self.dictParams[kEmail] = String.getString(self.txtFieldEmail.text)
        
        if txtView.textColor != UIColor.lightGray {
            self.dictParams[kQuery] = String.getString(self.txtView.text)
            
        }
        
        self.checkValidation()
        
    }
    
    
    
    //#MARK: callSetOrderReportWebService 
     private func callNotifyMeWebService()
     {
         
         
         let dictImg:[String : Any] = ["image" : UIImage(),
                                       "imageName" : "uploaded_file"]
         
         TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kNotifyMe, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Sending...", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
             guard let strongSelf = self else { return }
             if errorType == .requestSuccess
             {
                 UIApplication.shared.endIgnoringInteractionEvents()
                 
                 let dictResponse = kSharedInstance.getDictionary(response)
                 
                 if Int.getInt(dictResponse["success"]) == 1
                 {
                     let result = kSharedInstance.getDictionary(dictResponse["result"])
                     strongSelf.view.makeToast(String.getString(dictResponse[kMessage]), duration: 1.5, position: .center)
                    
                    
                    strongSelf.dismiss(animated: true, completion: nil)
                     
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
