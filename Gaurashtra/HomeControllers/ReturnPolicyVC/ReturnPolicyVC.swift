//
//  ReturnPolicyVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 03/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit
import SWRevealViewController
import WebKit

class ReturnPolicyVC: GaurashtraBaseVC,WKUIDelegate,WKNavigationDelegate {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var wkView: WKWebView!
    
    
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    
    @IBOutlet weak var containerView: UIView!
    
    
     private var dictParams = [kUserId: ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNeedsStatusBarAppearanceUpdate()
        self.getDevice()
        btnMenu.target = revealViewController()
        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        if isInternetAvailable()
        {
            self.callRefundPlicyWebService()
        }else{
            
            showOkAlert(withMessage: kNetworkErrorAlert)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
       
        
        
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
    //#MARK:-----------callGetCartDataWebService---------
    private func callRefundPlicyWebService()
    {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kRefundCancellationPolicy, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    
                    let dictData = kSharedInstance.getDictionary(result["refundCancellationPolicy"])
                    //let title = String.getString(offers["title"])
                    

                    strongSelf.wkView.loadHTMLString(String.getString(dictData["description"]), baseURL: Bundle.main.resourceURL)
                    
                    
                    
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
