//
//  SignUpViewController.swift
//  Gaurashtra
//
//  Created by abc on 24/09/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class SignUpViewController: GaurashtraBaseVC {

    @IBOutlet weak var signUpTbl: UITableView!
    
    fileprivate var dictParams =  [kFirstName   : "",
                                   kLastName    : "",
                                   kTelephone   : "",
                                   kEmail       : "",
                                   kPassword    : "",
                                   kDeviceType  : "",
                                   kDeviceId    : "",
                                   kConPassword : ""]
    
    
    
    @IBOutlet weak var upperView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getDevice()
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
       // self.navigationController?.popViewController(animated: true)
        
         kSharedAppDelegate.showSideMenu()
         self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func tapToSignUp(_ sender: UIButton) {
        self.dictParams[kDeviceType] = kIOS
        let deviceToken = String.getString(kSharedUserDefaults.string(forKey: "deviceToken"))
        if String.getLength(deviceToken) != 0
        {
            self.dictParams[kDeviceId]   = deviceToken
            
        }else{
            
            self.dictParams[kDeviceId]   = "yuu75k6j4h3k36k336l3h6l363"
        }
        self.checkValidation()
    }
    @IBAction func tapToLogin(_ sender: UIButton) {
        
        kSharedAppDelegate.showloginView()
    }
    
    
    
    func getDevice()
    {
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                upperView.frame.size.height = 120
                //   self.logoLbl.font = UIFont(name: "Marker Felt Thin", size: 50)
                
            case 1334:
                print("iPhone 6/6S/7/8")
                upperView.frame.size.height = 130
                //  self.logoLbl.font = UIFont.init(name: "Marker Felt Wide", size: 50.0)
                
                
            case 2208:
                print("iPhone 6+/6S+/7+/8+")
                upperView.frame.size.height = 150
                //   self.logoLbl.font = UIFont(name: "Marker Felt Thin", size: 60)
                
            case 2436:
                print("iPhone X")
                upperView.frame.size.height = 170
                // self.logoLbl.font = UIFont(name: "Marker Felt Thin", size: 60)
                
            default:
                upperView.frame.size.height = 170
                print("unknown")
            }
            
        }
        
    }
    
    
    //#MARK:-------checkValidation------------
    private func checkValidation()
    {
        if String.getLength(dictParams[kEmail]) == 0 || !String.getString(dictParams[kEmail]).isEmail()
        {
            showOkAlert(withMessage: kEnterValidEmail)
            
        }else if String.getLength(dictParams[kFirstName]) == 0
        {
            showOkAlert(withMessage: kEnterFirstName)
            
            
            
        }else if String.getLength(dictParams[kLastName]) == 0
        {
            showOkAlert(withMessage: kEnterLastName)
            
            
            
        }else  if String.getLength(dictParams[kTelephone]) == 0  || !String.getString(dictParams[kTelephone]).isPhoneNumber()
        {
            showOkAlert(withMessage: kEnterValidMobileNumber)
            
            
            
        } else  if String.getLength(dictParams[kPassword]) == 0
        {
            showOkAlert(withMessage: kEnterPassword)
            
            
            
        }else  if String.getLength(dictParams[kPassword]) <= 5
        {
            showOkAlert(withMessage: kEnterMinimumPassword)
            
            
            
        } else  if String.getLength(dictParams[kConPassword]) == 0
        {
            showOkAlert(withMessage: kEnterConPassword)
            
            
            
        }else if String.getString(dictParams[kPassword]) !=  String.getString(dictParams[kConPassword]) {
            
            
            showOkAlert(withMessage: kPasswordNotMatch)
            
        } else{
            
            if isInternetAvailable()
            {
                UIApplication.shared.beginIgnoringInteractionEvents()
                
                self.dictParams.removeValue(forKey:kConPassword)
                self.callGetRegistrationWebService()
                
            }
            else{
                
                showOkAlert(withMessage: kNetworkErrorAlert)
                
            }
            
        }
    }
    
    
    
}
//#MARK:  UITableViewDataSource,UITableViewDelegate 

extension SignUpViewController : UITableViewDataSource,UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SignUpCellType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row
        {
        case SignUpCellType.firstname.rawValue,SignUpCellType.lastname.rawValue,SignUpCellType.phone.rawValue,SignUpCellType.email.rawValue,SignUpCellType.password.rawValue,SignUpCellType.confirmPassword.rawValue:
            
            return getTextFieldTableCell(forIndexPath: indexPath)
            
        default:
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        switch indexPath.row
        {
         case SignUpCellType.firstname.rawValue,SignUpCellType.lastname.rawValue,SignUpCellType.phone.rawValue,SignUpCellType.email.rawValue,SignUpCellType.password.rawValue,SignUpCellType.confirmPassword.rawValue:
            return 55.0
            
        default:
            return 0.0
        }
    }
    
    
    //#MARK:--getTextFieldTableCell--
    private func getTextFieldTableCell(forIndexPath indexPath: IndexPath) -> SignUpTVC
    {
        let cellTVTextField = self.signUpTbl.dequeueReusableCell(withIdentifier: SignUpTVC.cellIdentifier()) as! SignUpTVC
        
        
        
        cellTVTextField.configureCell(withData: dictParams, forIndexPath: indexPath, getTextField: { (textField: UITextField) in
            
            switch textField.tag
            {
            case SignUpCellType.firstname.rawValue:
                self.dictParams[kFirstName] = String.getString(textField.text)
                
            case SignUpCellType.lastname.rawValue:
                self.dictParams[kLastName] = String.getString(textField.text)
                
            case SignUpCellType.phone.rawValue:
                self.dictParams[kTelephone] = String.getString(textField.text)
                
            case SignUpCellType.email.rawValue:
                self.dictParams[kEmail] = String.getString(textField.text)
                
            case SignUpCellType.password.rawValue:
                self.dictParams[kPassword] = String.getString(textField.text)
                
         
                
            case SignUpCellType.confirmPassword.rawValue:
                self.dictParams[kConPassword] = String.getString(textField.text)
                
                
            default:
                break
            }
            
            
            print(self.dictParams)
            
        })
        
        return cellTVTextField
    }
    //http://localhost/gaurashtra/api/getRegistration
    //#MARK:-----------callGetRegistrationWebService---------
    private func callGetRegistrationWebService()
    {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetRegistration, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
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
                    
                   kSharedAppDelegate.showloginView()
                    
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

