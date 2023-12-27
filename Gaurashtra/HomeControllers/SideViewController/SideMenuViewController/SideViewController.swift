//
//  SideViewController.swift
//  Gaurashtra
//
//  Created by abc on 24/09/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class SideViewController: GaurashtraBaseVC {

     var overlayView: UIView = UIView()
    
    @IBOutlet weak var logoutView: UIView!
    
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    
    @IBOutlet weak var loginView: UIView!
    
    
    @IBOutlet weak var sideTbl: UITableView!
    
    @IBOutlet weak var lblName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overlayView = UIView(frame: self.view.frame)
        overlayView.backgroundColor = UIColor(red: 63.0/255.0, green: 76.0/255.0, blue: 117.0/255.0, alpha: 1.0)
        overlayView.alpha = 0.5
        overlayView.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!)
        overlayView.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
       
       
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.revealViewController().frontViewController.view.addSubview(overlayView)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let userId = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        
        let fname = String.getString(LoginDataModel.getLoggedInUserDetails().firstName)
               
        let lname = String.getString(LoginDataModel.getLoggedInUserDetails().lastName)
               
        
        //print(userId)
        
        //print(String.getLength(userId))
        
        if String.getLength(userId) != 0
        {
           
            self.logoutView.isHidden = false
            self.btnLogin.isHidden   = true
            self.btnSignUp.isHidden  = true
            self.lblName.text        = "\(fname) \(lname)"
           
            
        }else{
            
             self.logoutView.isHidden = true
             self.btnLogin.isHidden   = false
             self.btnSignUp.isHidden  = false
             self.lblName.text        = "Gaurashtra"
            
        }
        
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.overlayView.removeFromSuperview()
        
        
    }
    
    @IBAction func tapToLogin(_ sender: UIButton) {
        
        self.loginVc()
        
    }
    
    @IBAction func tapToSignUp(_ sender: UIButton) {
        
        self.signUpVc()
        
    }
    
       func logout()
        {
            
             kSharedAppDelegate.showSideMenu()
             kSharedUserDefaults.setUserLoggedIn(userLoggedIn: false)
             let userData : Dictionary<String,Any> = ["":""]
             kSharedUserDefaults.setLoggedInUserDetails(loggedInUserDetails: userData)
            
    //        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
    //        loginManager.logOut()
    //        GIDSignIn.sharedInstance().signOut()
            
        }
    
    
    func signUpVc()
    {
        
        let sb : UIStoryboard = UIStoryboard(name: kLoginPlaceholder, bundle: nil)
                
                let nextVC = sb.instantiateViewController(withIdentifier: SignUpViewController.storyboardId()) as! SignUpViewController
        
        
               kSharedUserDefaults.set("SideMenuViewController", forKey: "signUpViewController")
                
                self.present(nextVC, animated: true) { }
    }

    
    func loginVc()
       {
           
           let sb : UIStoryboard = UIStoryboard(name: kLoginPlaceholder, bundle: nil)
                   
                   let nextVC = sb.instantiateViewController(withIdentifier: LoginViewController.storyboardId()) as! LoginViewController
           
           
                   kSharedUserDefaults.set("SideMenuViewController", forKey: "LoginView")
                   
                   self.present(nextVC, animated: true) { }
       }
    
    
    
    @IBAction func tapToLogout(_ sender: UIButton) {
        self.showActionSheetLogout(withTitle: kAppName, withAlertMessage: kLogoutPlacehoderString, withOptions: ["Logout"]) { (int:Int) in

                self.logout()
        }
    }
    
    @IBAction func btnDelete_Account_Click(_ sender: Any) {
        self.showActionSheetLogout(withTitle: kAppName, withAlertMessage: kDeleteAccountString, withOptions: ["Yes, Delete My Account"]) { (int:Int) in
            self.dismissViewC(withAnimation: true) {
                self.DeleteAccountWebService()
            }
        }
    }
    
    func DeleteAccount() {
          kSharedAppDelegate.showSideMenu()
          kSharedUserDefaults.setUserLoggedIn(userLoggedIn: false)
          let userData : Dictionary<String,Any> = ["":""]
          kSharedUserDefaults.setLoggedInUserDetails(loggedInUserDetails: userData)
     }
    
    func DeleteAccountWebService() {
        let dictData : [String:String] = ["":""]
        print("-*-*-*-**-*-*-*-*-*-*-*-*-*-**-*-*-\(dictData)")
        let apiURL = kBASEURL +  "deleteAccount?userid=\(String.getString(LoginDataModel.getLoggedInUserDetails().customer_id))"
        TANetworkManager.sharedInstance.requestApi(withServiceName: apiURL, requestMethod: .POST, requestParameters: dictData, withProgressHUD: false, withProgressHUDTitle: "Please Wait") { [weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess {
                let dictResponse = kSharedInstance.getDictionary(response)
                print(dictResponse)
                if (Int.getInt(dictResponse["success"]) == 1) {
                    self!.DeleteAccount()
                } else {
                }
            }
            else if errorType == .requestFailed {
                kSharedAppDelegate.h
            }
            else
            {
            }
        }
    }
}
//#MARK:   UITableViewDataSource,UITableViewDelegate  
extension SideViewController : UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SideMenuOptions.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        switch indexPath.row
        {
        case  SideMenuOptions.home.rawValue:
            let cell = sideTbl.dequeueReusableCell(withIdentifier: SideMenuHomeTVC.cellIdentifier(), for: indexPath) as! SideMenuHomeTVC
            return cell
            
            
        case SideMenuOptions.aboutUs.rawValue:
            let cell = sideTbl.dequeueReusableCell(withIdentifier: SideMenuAboutUsTVC.cellIdentifier(), for: indexPath) as! SideMenuAboutUsTVC
            return cell

        case SideMenuOptions.contactUs.rawValue:
            let cell = sideTbl.dequeueReusableCell(withIdentifier: SideMenuContactUsTVC.cellIdentifier(), for: indexPath) as! SideMenuContactUsTVC
            return cell

        case SideMenuOptions.termAndConditions.rawValue:
            let cell = sideTbl.dequeueReusableCell(withIdentifier: SideMenuTermsConditionsTVC.cellIdentifier(), for: indexPath) as! SideMenuTermsConditionsTVC
            return cell

        case SideMenuOptions.returnPolicy.rawValue:
            let cell = sideTbl.dequeueReusableCell(withIdentifier: SideMenuReturnPolicyTVC.cellIdentifier(), for: indexPath) as! SideMenuReturnPolicyTVC
            return cell

        case SideMenuOptions.cancellationPolicy.rawValue:
            let cell = sideTbl.dequeueReusableCell(withIdentifier: SideMenuCancelPolicyTVC.cellIdentifier(), for: indexPath) as! SideMenuCancelPolicyTVC
            return cell
        case SideMenuOptions.faq.rawValue:
            let cell = sideTbl.dequeueReusableCell(withIdentifier: SideMenuFAQTVC.cellIdentifier(), for: indexPath) as! SideMenuFAQTVC
            return cell

            
        default:
            return UITableViewCell()
        }
        
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        switch indexPath.row
        {
        case SideMenuOptions.home.rawValue,
             SideMenuOptions.aboutUs.rawValue,
             SideMenuOptions.contactUs.rawValue,
             SideMenuOptions.termAndConditions.rawValue,
             SideMenuOptions.returnPolicy.rawValue,
             SideMenuOptions.cancellationPolicy.rawValue,
             SideMenuOptions.faq.rawValue:
         
            return 70
            
        default:
            return 0.0
        }
    }
    
    
}
class SideMenuHomeTVC: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class SideMenuAboutUsTVC: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
class SideMenuContactUsTVC: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
class SideMenuTermsConditionsTVC: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
class SideMenuReturnPolicyTVC: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
class SideMenuCancelPolicyTVC: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class SideMenuFAQTVC: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}




