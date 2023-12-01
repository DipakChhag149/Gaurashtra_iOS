//
//  ProfileViewController.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 06/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class ProfileViewController: GaurashtraBaseVC {
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var txtFieldLastName: UITextField!
    @IBOutlet weak var txtFieldFisrtName: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var txtFieldMobile: UITextField!
    
    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    //userid, firstname, lastname, telephone, email
    private var dictParams =  [  kUserId    : "",
                                 kFirstName : "",
                                 kLastName  : "",
                                 kTelephone : "",
                                 kEmail     : ""]
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDevice()
        let firstName =  String.getString(LoginDataModel.getLoggedInUserDetails().firstName)
        let lastName  =  String.getString(LoginDataModel.getLoggedInUserDetails().lastName)
        let telephone =  String.getString(LoginDataModel.getLoggedInUserDetails().telephone)
        let email =  String.getString(LoginDataModel.getLoggedInUserDetails().email)
        
        self.dictParams[kFirstName] = firstName
        self.dictParams[kLastName]  = lastName
        self.dictParams[kTelephone] = telephone
        self.dictParams[kEmail]     = email
        
        self.txtFieldFisrtName.text = firstName
        self.txtFieldLastName.text  = lastName
        self.txtFieldMobile.text    = telephone
        self.txtEmailAddress.text   = email
        self.txtFieldFisrtName.text = firstName
        
        self.dictParams[kUserId]    = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        
        if isInternetAvailable()
        {
           self.callAddressListWebService()
        }else{
           self.view.makeToast(kNetworkErrorAlert, duration: 3.5, position: .center)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        
    }
    @IBAction func tapToWishList(_ sender: UIButton) {
        
        let sb :UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        let nextViewController = sb.instantiateViewController(withIdentifier: WishListViewController.storyboardId()) as! WishListViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
     
    }
    
    @IBAction func tapToSaveChange(_ sender: UIButton) {
        self.dictParams[kUserId]    = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        let firstName =  String.getString(LoginDataModel.getLoggedInUserDetails().firstName)
        let lastName  =  String.getString(LoginDataModel.getLoggedInUserDetails().lastName)
        let telephone =  String.getString(LoginDataModel.getLoggedInUserDetails().telephone)
        let email =  String.getString(LoginDataModel.getLoggedInUserDetails().email)
       
        if String.getLength(self.txtFieldFisrtName.text) != 0
        {
            self.dictParams[kFirstName] = self.txtFieldFisrtName.text
        }else{
            self.dictParams[kFirstName] = firstName
        }
        if String.getLength(self.txtFieldLastName.text) != 0
        {
           self.dictParams[kLastName]  = self.txtFieldLastName.text
        }else{
           self.dictParams[kLastName]  = lastName
        }
        if String.getLength(self.txtFieldMobile.text) != 0
        {
           self.dictParams[kTelephone] = self.txtFieldMobile.text
        }else{
           self.dictParams[kTelephone] = telephone
        }
        if String.getLength(self.txtEmailAddress.text) != 0
        {
           self.dictParams[kEmail]     = self.txtEmailAddress.text
        }else{
           self.dictParams[kEmail]     = email
        }
      
        if isInternetAvailable()
        {
            self.callEditProfileDataWebService()
        }else{
            self.view.makeToast(kNetworkErrorAlert, duration: 3.5, position: .center)
        }
        
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
                  self.headerViewConstraintH.constant = 84
                  self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
                   
               }
               
           }
           
       }

    
    //#MARK:-----------callLoginWebService---------
    private func callEditProfileDataWebService()
    {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kEditProfileData, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait...", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
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
                   let userData = kSharedInstance.getDictionary(result["userData"])
                   kSharedUserDefaults.setLoggedInUserDetails(loggedInUserDetails: userData)
                   kSharedUserDefaults.setUserLoggedIn(userLoggedIn: true)
                    let fName = String.getString(userData["firstname"])
                    let lastname = String.getString(userData["lastname"])
                    let email = String.getString(userData["email"])
                    let telephone = String.getString(userData["telephone"])
                    
                    strongSelf.txtFieldFisrtName.text = fName
                    strongSelf.txtFieldLastName.text  = lastname
                    strongSelf.txtFieldMobile.text    = telephone
                    strongSelf.txtEmailAddress.text   = email
                    strongSelf.view.makeToast(String.getString(dictResponse[kMessage]), duration: 3.5, position: .center)
     
                }else{
                    
                    //strongSelf.showOkAlert(withMessage: String.getString(dictResponse[kMessage]))
                    
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
    //#MARK:-----------callLoginWebService---------
    private func callAddressListWebService()
    {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetAddressList, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait...", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                //                strongSelf.imgProfile.image = strongSelf.img
                //                self?.callgetStateWebService() 
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    
                    
                    let userAddressData = kSharedInstance.getArray(result["userAddressData"])
                    
                    //print(userAddressData)
                    
                    for dict in userAddressData
                    {
                        let dictData = kSharedInstance.getDictionary(dict)
                        
                        let address_id         = String.getString(dictData["address_id"])
                        let default_address_id = String.getString(dictData["default_address_id"])
                        if default_address_id == address_id
                        {
                            
                            let address_1 = String.getString(dictData["address_1"])
                            let address_2 = String.getString(dictData["address_2"])
                            let city      = String.getString(dictData["city"])
                            let postcode  = String.getString(dictData["postcode"])
                            
                            strongSelf.txtView.text = address_1 + ", " + address_2 + ", " + city + ", " + postcode
                        }
                        
                    }
                    
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
