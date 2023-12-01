//
//  MyOrdersViewController.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 21/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class MyOrdersViewController: GaurashtraBaseVC {

    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var orderTbl: UITableView!
    var orderData : [Any] = []
    private var dictParams = [kUserId: ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getDevice()
        self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        if isInternetAvailable(){
            self.callGetOrderListWebService()
            
        }else{
            
            showOkAlert(withMessage: kNetworkErrorAlert)
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
                 print("iphone XS")
                 
             case 2688://iphone XS Max
                 
                 print("iphone XS Max")
                 self.headerViewConstraintH.constant = 84
                 self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
                 
             case 1792://iphone XR
                 self.headerViewConstraintH.constant = 84
                 self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
             default:
                 print("unknown")
                 
                 
             }
             
         }
         
     }
   

}
//#MARK:  UITableViewDelegate,UITableViewDataSource 
extension MyOrdersViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderTbl.dequeueReusableCell(withIdentifier: MyOrderTVC.cellIdentifier(), for: indexPath) as! MyOrderTVC
        cell.configureCell(withDictData: kSharedInstance.getDictionary(orderData[indexPath.row]), forIndxPath: indexPath, btnReport: {(btnReport : UIButton) in
            print("report")
            let dictData = kSharedInstance.getDictionary(self.orderData[indexPath.row])
            self.reportVC(withOrderId: String.getString(dictData["orderId"]))
            
        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dictData = kSharedInstance.getDictionary(orderData[indexPath.row])
        
        self.orderDetail(withOrderId: String.getString(dictData["orderId"]))
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    
    func orderDetail(withOrderId orderId : String)
    {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextVC = sb.instantiateViewController(withIdentifier: OrderDetailsViewController.storyboardId()) as! OrderDetailsViewController
        
        nextVC.orderId = orderId
        self.navigationController?.pushViewController(nextVC, animated: true)
    
    }
    
    func reportVC(withOrderId orderId : String)
    {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextVC = sb.instantiateViewController(withIdentifier: ReportVC.storyboardId()) as! ReportVC
        
        nextVC.orderId = orderId
        //self.navigationController?.pushViewController(nextVC, animated: true)
        
        self.present(nextVC, animated: true, completion: nil)
        
    }
    
    //#MARK:-----------callGetCartDataWebService---------
    private func callGetOrderListWebService()
    {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetOrderList, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                   
                    strongSelf.orderData = kSharedInstance.getArray(result["orderData"])
                    
                    strongSelf.orderTbl.reloadData()
                    
                    
                }else{
                    
                    // strongSelf.showOkAlert(withMessage: String.getString(dictResponse[kMessage]))
                    
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
