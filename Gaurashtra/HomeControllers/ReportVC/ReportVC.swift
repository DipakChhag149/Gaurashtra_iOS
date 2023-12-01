//
//  ReportVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 14/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit
import Toast_Swift

class ReportVC: GaurashtraBaseVC,UITextViewDelegate, UINavigationControllerDelegate {

  //  userid, orderId, comment setOrderReport
    
    var orderId : String = ""
    
    @IBOutlet weak var reportView: UIView!
    
    @IBOutlet weak var txtView: UITextView!
    
    private var dictParams = [kUserId  : "",
                              kOrderId : "",
                              kComment : ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        kSharedInstance.setShadow(withSubView: reportView, cornerRedius: 0)
        txtView.delegate = self
        txtView.text = "Message"
        txtView.textColor = UIColor.lightGray
        
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtView.textColor == UIColor.lightGray {
            txtView.text = nil
            txtView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtView.text.isEmpty {
            txtView.text = "Message"
            txtView.textColor = UIColor.lightGray
        }
    }

    //#MARK: Submit 
    
    @IBAction func tapToSubmit(_ sender: UIButton) {
        
        self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
          self.dictParams[kOrderId] = String.getString(orderId)
        
        if txtView.textColor != UIColor.lightGray {
            self.dictParams[kComment] = String.getString(self.txtView.text)
            
        }
        
        self.checkValidation()
      
        
    }
    
    func checkValidation()
    {
        if String.getLength(self.dictParams[kComment]) == 0 || txtView.textColor == UIColor.lightGray
        {
            self.view.makeToast(kEnterMessage, duration: 1.5, position: .center)
        }else{
            
            if isInternetAvailable()
            {
                self.callSetOrderReportWebService()
                
            }else{
                
                self.view.makeToast(kNetworkErrorAlert, duration: 1.5, position: .center)
            }
            
        }
        
    }
    
    //#MARK: callSetOrderReportWebService 
    private func callSetOrderReportWebService()
    {
        
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kSetOrderReport, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Sending...", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
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
