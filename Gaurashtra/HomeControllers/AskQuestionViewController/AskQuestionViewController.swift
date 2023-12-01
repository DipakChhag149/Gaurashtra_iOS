//
//  AskQuestionViewController.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 26/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class AskQuestionViewController: GaurashtraBaseVC,UITextViewDelegate {

    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var nameTxtField: UITextField!
    
    @IBOutlet weak var phoneTxtField: UITextField!
    
    @IBOutlet weak var emailTxtField: UITextField!
    
    
    @IBOutlet weak var msgTxtView: UITextView!
    
    private var dictParams = [kUsername  : "",
                              kEmail     : "",
                              kQuery     : "",
                              kProductId : ""]
    
    
    //username, email, query, productid
    
    var productid : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        self.getDevice()
        msgTxtView.delegate = self
        msgTxtView.text = "Message"
        msgTxtView.textColor = UIColor.lightGray
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if msgTxtView.textColor == UIColor.lightGray {
            msgTxtView.text = nil
            msgTxtView.textColor = UIColor.black
        }
    }
    //productOptionsList
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if msgTxtView.text.isEmpty {
            msgTxtView.text = "Message"
            msgTxtView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func tapToSubmit(_ sender: UIButton) {
        
        self.dictParams[kUsername] = String.getString(nameTxtField.text)
        self.dictParams[kEmail] = String.getString(emailTxtField.text)
      
        if msgTxtView.textColor != UIColor.lightGray {
            self.dictParams[kQuery] = String.getString(self.msgTxtView.text)
            
        }
        
        self.checkValidation()
        
        
    }
    
    func checkValidation()
    {
         if String.getLength(self.dictParams[kUsername]) == 0
         {
           
            self.view.makeToast(kEnterUserName, duration: 1.5, position: .center)
            
            
         } else if String.getLength(self.dictParams[kEmail]) == 0 && String.getString(self.dictParams[kEmail]).isEmail()
         {
             self.view.makeToast(kEnterValidEmail, duration: 1.5, position: .center)
          
            
        }else if String.getLength(self.dictParams[kQuery]) == 0 || msgTxtView.textColor == UIColor.lightGray
        {
            self.view.makeToast(kEnterMessage, duration: 1.5, position: .center)
        }else  {
            
            if isInternetAvailable()
            {
                self.callAskAQuestionWebService()
                
            }else{
                
                self.view.makeToast(kNetworkErrorAlert, duration: 1.5, position: .center)
            }
            
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
    //#MARK: callSetOrderReportWebService 
    private func callAskAQuestionWebService()
    {
        
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kAskAQuestion, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Sending...", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
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
