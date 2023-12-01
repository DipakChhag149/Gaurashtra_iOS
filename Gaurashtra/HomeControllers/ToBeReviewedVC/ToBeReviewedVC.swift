//
//  ToBeReviewedVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 30/01/20.
//  Copyright © 2020 Gaurashtra. All rights reserved.
//

import UIKit
import Toast_Swift

class ToBeReviewedVC: GaurashtraBaseVC {

    @IBOutlet weak var tblReviewed: UITableView!
    
     private var dictParams   =  [kUserId        : ""]
    
    
    var toBeReviewed : [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        
        if isInternetAvailable()
        {
            self.callGetProductWithReviewRatingWebService()
        }else{
            
            showOkAlert(withMessage: kNetworkErrorAlert)
            
        }
        
    }
    


}
extension ToBeReviewedVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return toBeReviewed.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblReviewed.dequeueReusableCell(withIdentifier: ToBeReviewedTVC.cellIdentifier(), for: indexPath) as! ToBeReviewedTVC
        
        cell.configureCell(withDictData: kSharedInstance.getDictionary(self.toBeReviewed[indexPath.row]), forIndxPath: indexPath, btnWriteReview: {(btnWriteReview : UIButton) in
            
            //print("tap")
            
            let dictData = kSharedInstance.getDictionary(self.toBeReviewed[indexPath.row])
            
            //print(dictData)
            
           self.writeReview(withProdId: String.getString(dictData["productId"]))
            
        })
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func writeReview(withProdId prodId : String)
    {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextVC = sb.instantiateViewController(withIdentifier: WriteReview2VC.storyboardId()) as! WriteReview2VC
         
        nextVC.productId = prodId
        
        self.present(nextVC, animated: true, completion: nil)
        
    }
    
    
    //#MARK:-----------callGetProductWithReviewRatingWebService---------
       private func callGetProductWithReviewRatingWebService()
       {
           
           
           let dictImg:[String : Any] = ["image" : UIImage(),
                                         "imageName" : "uploaded_file"]
           
           TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetProductWithReviewRating, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
               guard let strongSelf = self else { return }
               if errorType == .requestSuccess
               {
                   UIApplication.shared.endIgnoringInteractionEvents()
                   
                   let dictResponse = kSharedInstance.getDictionary(response)
                   
                   if Int.getInt(dictResponse["success"]) == 1
                   {
                       let result = kSharedInstance.getDictionary(dictResponse["result"])
                       
                    let orderData = kSharedInstance.getDictionary(result["orderData"])
                       
                       let toBeReviewed = kSharedInstance.getArray(orderData["toBeReviewed"])
                       
                    if toBeReviewed.count != 0
                    {
                        strongSelf.toBeReviewed = kSharedInstance.getArray(orderData["toBeReviewed"])
                    }
                     
                    strongSelf.tblReviewed.reloadData()
                       
                       
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
