//
//  NotificationVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 29/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit

class NotificationVC: GaurashtraBaseVC {

    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    @IBOutlet weak var tblNotification: UITableView!
    
    fileprivate var dictParams = [kUserId   : ""]
    
    var notificationList : [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDevice()
        self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        
        
        let userId = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        
       
        
        if isInternetAvailable()
        {
            if String.getLength(userId) != 0
            {
                self.callGetNotificationListWebService()
            }
            
       
          }else{
        
           showOkAlert(withMessage: kNetworkErrorAlert)
      
          }
        
        
       }
    


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let userId = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        
        if String.getLength(userId) != 0
        {
            self.tblNotification.isHidden = false
        }else{
            
            self.tblNotification.isHidden = true
            
        }
        
        
        
    }
    
    
    @IBAction func tapToSignIn(_ sender: UIButton) {
        
        self.loginView()
        
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
    
    
    func loginView()
    {
        let sb : UIStoryboard  = UIStoryboard(name: kLoginPlaceholder, bundle: nil)
        
        let nextVc = sb.instantiateViewController(withIdentifier: LoginViewController.storyboardId()) as! LoginViewController
        
        //self.navigationController?.pushViewController(nextVc, animated: true)
        
        self.present(nextVc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
    
    }
    
}
extension NotificationVC : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblNotification.dequeueReusableCell(withIdentifier: NotificationTVC.cellIdentifier()) as! NotificationTVC
        
        cell.configureNotCell(withDictData: kSharedInstance.getDictionary(notificationList[indexPath.row]), forIndxPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dictData = kSharedInstance.getDictionary(notificationList[indexPath.row])
        
        self.readNotificationsVC(withDictData: dictData)
    }
    
    func readNotificationsVC(withDictData dictData : Dictionary<String,Any>)
    {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextVC = sb.instantiateViewController(withIdentifier: ReadNotificationVC.storyboardId()) as! ReadNotificationVC
      
        nextVC.dictData = dictData
        
        self.present(nextVC, animated: true) { }
            
        
        
    }
    
    //#MARK:-----------callGetNotificationListWebServi---------
    private func callGetNotificationListWebService()
    {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetNotificationList, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    
                  strongSelf.notificationList  = kSharedInstance.getArray(result["notificationData"])
                    
                    strongSelf.tblNotification.reloadData()
                    
                    
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
