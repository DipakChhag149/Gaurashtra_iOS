//
//  LoginViewController.swift
//  Gaurashtra
//
//  Created by abc on 24/09/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit
//import FBSDKCoreKit
//import FBSDKLoginKit


import GoogleUtilities
//GIDSignInUIDelegate

class LoginViewController: GaurashtraBaseVC {//GIDSignInDelegate {
    @IBOutlet weak var lowerView: UIView!
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassord: UITextField!
    @IBOutlet weak var imgChecked: UIImageView!
    @IBOutlet weak var loginWithH2: NSLayoutConstraint!
    
    @IBOutlet weak var orLoginWithH1: NSLayoutConstraint!
    
    @IBOutlet weak var loginTbl: UITableView!
   
    fileprivate var dictParams =  [kEmail      : "",
                                   kPassword   : "",
                                   kDeviceType : "",
                                   kDeviceId   : ""]
    
    @IBOutlet weak var upperView: UIView!
    var isSave : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let deviceToken = String.getString(kSharedUserDefaults.string(forKey: "deviceToken"))
        
        if String.getLength(deviceToken) != 0
        {
            self.dictParams[kDeviceId]   = deviceToken
            
        }else{
            
            self.dictParams[kDeviceId]   = "yuu75k6j4h3k36k336l3h6l363"
        }
        
        self.dictParams[kDeviceType] = kIOS
        
        
       // GIDSignIn.sharedInstance()?.presentingViewController = self

        self.getDevice()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let loginEmail        = String.getString(kSharedUserDefaults.string(forKey: "LoginEmail"))
        print(loginEmail)
        self.txtEmail.text    = String.getString(loginEmail)
    }
    
    
    @IBAction func home(_ sender: UIButton) {
        
        kSharedAppDelegate.showSideMenu()
        
    }
    
    
    func getDevice()
    {
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                upperView.frame.size.height = 240
                
                lowerView.frame.size.height = 338
            
                self.orLoginWithH1.constant = 35
                
                self.loginWithH2.constant = 35
                
                
            case 1334:
                print("iPhone 6/6S/7/8")
                upperView.frame.size.height = 250
                lowerView.frame.size.height = 340
                
                 self.loginWithH2.constant  = 60
                
                 self.orLoginWithH1.constant = 60
                
               
                
               
                
            case 2208:
                print("iPhone 6+/6S+/7+/8+")
                upperView.frame.size.height = 270
             
                //lowerView.frame.size.height = 340
                
                self.loginWithH2.constant  = 60
                
                self.orLoginWithH1.constant = 60
               
            case 2436:
                print("iPhone X")
                upperView.frame.size.height = 300
               // self.logoLbl.font = UIFont(name: "Marker Felt Thin", size: 60)
                self.loginWithH2.constant  = 60
                
                self.orLoginWithH1.constant = 60
         
                
                
            case 2688://iphone XS Max
                
                print("iphone XS Max")
                
                self.loginWithH2.constant  = 60
                
                self.orLoginWithH1.constant = 60
                upperView.frame.size.height = 340
                
            case 1792://iphone XR
                
                print("iphone XR")
                
               upperView.frame.size.height = 350
                
                self.loginWithH2.constant  = 60
                
                self.orLoginWithH1.constant = 60
                
                
            default:
                print("unknown")
            }
            
        }
        
    }
    
    
    @IBAction func tapToSignUp(_ sender: UIButton) {
        
        let sb : UIStoryboard = UIStoryboard(name: kLoginPlaceholder, bundle: nil)
        let nextviewController = sb.instantiateViewController(withIdentifier: SignUpViewController.storyboardId()) as! SignUpViewController
        //self.navigationController?.pushViewController(nextviewController, animated: true)
        
        self.present(nextviewController, animated: true, completion: nil)
      
    }
    
    @IBAction func tapToRemember(_ sender: UIButton) {
        
        self.isSave = !self.isSave
        
        if Bool.getBool(isSave) == true
        {
           self.imgChecked.image = #imageLiteral(resourceName: "checked")
           kSharedUserDefaults.set(self.txtEmail.text, forKey: "LoginEmail")
            
        }else{
            self.imgChecked.image = #imageLiteral(resourceName: "check")
            kSharedUserDefaults.set("", forKey: "LoginEmail")
        }
        
    }
    
    
    @IBAction func tapToForgotPassword(_ sender: UIButton) {
        let sb : UIStoryboard = UIStoryboard(name: kLoginPlaceholder, bundle: nil)
        let nextviewController = sb.instantiateViewController(withIdentifier: ForgotPasswordVC.storyboardId()) as! ForgotPasswordVC
       // self.navigationController?.pushViewController(nextviewController, animated: true)
        
        self.present(nextviewController, animated: true, completion: nil)
    }
    
    
    @IBAction func tapToFacebokLogin(_ sender: UIButton) {
        //self.facebookIntegration()
    }
    
    
    //MARK:- ----------facebookIntegration----------
//    func facebookIntegration(){
//
//        //fetch Login data from facebook
//        RSFacebookHelper.sharedInstance.logIn(fromViewController: self)
//        {(dictData: Dictionary<String, Any>) in
//            let dataDict = kSharedInstance.getDictionary(kSharedInstance.getDictionary(dictData["picture"])["data"])
//
//            let url = String.getString(dataDict["url"])
//
//            guard let urlBrand = URL.init(string: url) else { return }
//
//
//
//            let userName = String.getString(dictData["first_name"]) + " " + String.getString(dictData["last_name"])
//            print(userName)
//
//            //            self.dictParamsFacebook[kUserName] = String.getString(userName)
//            //            self.dictParamsFacebook[kUserEmail] = String.getString(dictData["email"])
//            //            self.dictParamsFacebook[kNetworkId] = String.getString(Int.getInt(dictData["id"]))
//            //            self.callSocialLogInWebService(withDictParams: self.dictParamsFacebook)
//
//        }
//
//    }
    
    @IBAction func tapToGoogleLogin(_ sender: UIButton) {
        
       // GIDSignIn.sharedInstance().uiDelegate = self
        
//        GIDSignIn.sharedInstance().delegate = self
//        GIDSignIn.sharedInstance().signIn()
        
    }
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
//              withError error: Error!) {
//        if let error = error {
//            print("\(error.localizedDescription)")
//        } else {
//            print(user.profile.name)
//            print(user.profile.email)
//     
//            
//        }
//    }
//    
//    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
//              withError error: Error!) {
//        // Perform any operations when the user disconnects from app here.
//        // ...
//    }
//    
    @IBAction func backAction(_ sender: UIButton) {
        let viewControllerName = String.getString(kSharedUserDefaults.string(forKey: "LoginView"))
      
        if String.getString(viewControllerName) == "MeViewController" || String.getString(viewControllerName) == "MyCartViewContoller" || String.getString(viewControllerName) == "SideMenuViewController"
        {
            kSharedAppDelegate.showSideMenu()
            self.dismiss(animated: true, completion: nil)
        }else{
             self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func tapToLogin(_ sender: UIButton) {
        if Bool.getBool(isSave) == true
       {
           self.imgChecked.image = #imageLiteral(resourceName: "checked")
           kSharedUserDefaults.set(self.txtEmail.text, forKey: "LoginEmail")
       }else{
           self.imgChecked.image = #imageLiteral(resourceName: "check")
           kSharedUserDefaults.set("", forKey: "LoginEmail")
       }
        self.dictParams[kEmail] = String.getString(self.txtEmail.text)
        
         self.dictParams[kPassword] = String.getString(self.txtPassord.text)
        self.checkValidation()
    }
    
    //#MARK: -checkValidation--
    func checkValidation()
    {
        if String.getLength(dictParams[kEmail]) == 0 || !String.getString(dictParams[kEmail]).isEmail()
        {
            
            showOkAlert(withMessage: kEnterValidEmail)
            
        } else  if String.getLength(dictParams[kPassword]) == 0
        {
            showOkAlert(withMessage: kEnterPassword)
            
        }else{
            
            if isInternetAvailable()
            {
                print(dictParams)
                UIApplication.shared.beginIgnoringInteractionEvents()
                self.callLoginWebService()
            }
            else{
                showOkAlert(withMessage: kNetworkErrorAlert)
            }
        }
    }
    
     //#MARK:-----------callLoginWebService---------
        private func callLoginWebService()
        {
            
            let dictImg:[String : Any] = ["image" : UIImage(),
                                          "imageName" : "uploaded_file"]
            
            TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetLogin, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Logging...", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
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
                        
                        
                        let viewControllerName = String.getString(kSharedUserDefaults.string(forKey: "LoginView"))
                              
                             
                              
                              if String.getString(viewControllerName) == "MeViewController" || String.getString(viewControllerName) == "MyCartViewContoller" || String.getString(viewControllerName) == "SideMenuViewController"
                              {
                                  kSharedAppDelegate.showSideMenu()
                                  strongSelf.dismiss(animated: true, completion: nil)
                              }else{
                                  
                                 
                                   strongSelf.dismiss(animated: true, completion: nil)
                              }
                        
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
//#MARK:  UITableViewDataSource,UITableViewDelegate 

//extension LoginViewController : UITableViewDataSource,UITableViewDelegate
//{
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return LoginCellType.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        switch indexPath.row
//        {
//        case LoginCellType.emailId.rawValue,LoginCellType.password.rawValue:
//
//            return getTextFieldTableCell(forIndexPath: indexPath)
//
//        default:
//            return UITableViewCell()
//        }
//
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
//    {
//
//        switch indexPath.row
//        {
//        case LoginCellType.emailId.rawValue,LoginCellType.password.rawValue:
//            return 55.0
//
//        default:
//            return 0.0
//        }
//    }
//
//
//    //#MARK:--getTextFieldTableCell--
//    private func getTextFieldTableCell(forIndexPath indexPath: IndexPath) -> LoginTVC
//    {
//        let cellTVTextField = self.loginTbl.dequeueReusableCell(withIdentifier: LoginTVC.cellIdentifier()) as! LoginTVC
//
//
//
//        cellTVTextField.configureCell(withData: dictParams, forIndexPath: indexPath, getTextField: { (textField: UITextField) in
//
//            switch textField.tag
//            {
//            case LoginCellType.emailId.rawValue:
//                self.dictParams[kEmail] = String.getString(textField.text)
//
//
//
//            case LoginCellType.password.rawValue:
//                self.dictParams[kPassword] = String.getString(textField.text)
//
//
//            default:
//                break
//            }
//
//
//            print(self.dictParams)
//
//        })
//
//        return cellTVTextField
//    }
//
//
//}
