//
//  NoificationVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 09/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit

class NotificationVC: GaurashtraBaseVC {

   
    @IBOutlet weak var tblNotification: UITableView!
    
    var arrList : [String] = ["A table view controller displays structured, repeatable information in a vertical list. You use the UITableViewController class in your iOS app to build a table view controller","Working with a table view controller also means working with a few important iOS development concepts","such as subclassing, the delegation design pattern, and re-using views","In this article I’ll show you step-by-step how table view controllers work, and how you can use ","them. We’ll go into the full gamut of UITableViewController, by diving into Object-Oriented Programming","delegation and the behind-the-scenes mechanisms of table views","It’s important for professional and practical iOS developers (you!) to master working with table view controllers. Once you’ve gotten used to working on such a multifaceted UI component, like UITableViewController, other more complex aspects of iOS development will start to make sense too."]
    
    private var dictParams = [kUserId: ""]
    
    var notificationList : [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tblNotification.rowHeight = UITableView.automaticDimension
//        self.tblNotification.estimatedRowHeight = 120
        
        self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)

        self.callCategoryListWebService()
        
    }
    

    @IBAction func backAction(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}



extension NotificationVC : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblNotification.dequeueReusableCell(withIdentifier: NotificationTVC.cellIdentifier(), for: indexPath) as! NotificationTVC
        
      
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.readNotVC()
        
        print("didselect")
       
        
    }

    func readNotVC()
    {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextVC = sb.instantiateViewController(withIdentifier: ReadNotificationVC.storyboardId()) as! ReadNotificationVC
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        
        
    }
    

    
    //#MARK:-----------callCategoryListWebService---------
    private func callCategoryListWebService()
    {
        
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetCategoryList, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    
                    
                    strongSelf.notificationList = kSharedInstance.getArray(result["categoryData"])
                    strongSelf.tblNotification.reloadData()
                    
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
