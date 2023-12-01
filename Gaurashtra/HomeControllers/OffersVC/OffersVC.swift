//
//  OffersVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 13/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit
import WebKit
import SWRevealViewController

class OffersVC: GaurashtraBaseVC {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var lblHeader: UILabel!
    

    @IBOutlet weak var btnMenu: UIBarButtonItem!
    
    @IBOutlet weak var webView: UIWebView!
    
    private var dictParams = [kUserId: ""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNeedsStatusBarAppearanceUpdate()
        btnMenu.target = revealViewController()
        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        if isInternetAvailable()
        {
            
            self.callOffersWebService()
        }else{
            
            showOkAlert(withMessage: kNetworkErrorAlert)
        }
        
    }
    
    //#MARK:-----------callCategoryListWebService---------
    private func callOffersWebService()
    {
        
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kOffers, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    
                    let offers = kSharedInstance.getDictionary(result["offers"])
                    
                    strongSelf.lblHeader.text = String.getString(offers["title"])
                    
                    strongSelf.webView.loadHTMLString(String.getString(offers["description"]), baseURL: nil)
                    
                  
                    
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
