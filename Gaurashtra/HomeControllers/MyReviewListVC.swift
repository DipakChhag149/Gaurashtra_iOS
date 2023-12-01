//
//  MyReviewListVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 30/01/20.
//  Copyright © 2020 Gaurashtra. All rights reserved.
//

import UIKit

class MyReviewListVC: GaurashtraBaseVC {

    private var dictParams   =  [kUserId        : ""]
      
    @IBOutlet weak var tblReviews: UITableView!
    
      var myReview : [Any] = []
      
      override func viewDidLoad() {
          super.viewDidLoad()

        
        self.tblReviews.estimatedRowHeight = 180
        self.tblReviews.rowHeight          = UITableView.automaticDimension
          
          self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
          
          if isInternetAvailable()
          {
            self.callGetProductWithReviewRatingWebService(withProgressHUD: true)
          }else{
              
              showOkAlert(withMessage: kNetworkErrorAlert)
              
          }
          
      }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isInternetAvailable()
         {
            self.callGetProductWithReviewRatingWebService(withProgressHUD: false)
         }else{
             
             showOkAlert(withMessage: kNetworkErrorAlert)
             
         }
    }
     
}
extension MyReviewListVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return myReview.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblReviews.dequeueReusableCell(withIdentifier: MyReviewListTVC.cellIdentifier(), for: indexPath) as! MyReviewListTVC
        
        cell.configureCell(withDictData: kSharedInstance.getDictionary(self.myReview[indexPath.row]), forIndxPath: indexPath, btnEdit: {(btnEdit:UIButton) in
            //print("Edit")
            
            
            let dictData = kSharedInstance.getDictionary(self.myReview[indexPath.row])
            //print(dictData)
            
          // let reviewId = String.getString(dictData["reviewId"])
           self.reviewVC(withDictData: dictData, reviewId: String.getString(dictData["reviewId"]))
            
        })
        
        return cell
        
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 220
//    }
    
    //#MARK:-----------callGetProductWithReviewRatingWebService---------
    private func callGetProductWithReviewRatingWebService(withProgressHUD progressHUD : Bool)
       {
           
           
           let dictImg:[String : Any] = ["image" : UIImage(),
                                         "imageName" : "uploaded_file"]
           
           TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetProductWithReviewRating, requestMethod: .post, requestImages: [dictImg], withProgressHUD: progressHUD, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
               guard let strongSelf = self else { return }
               if errorType == .requestSuccess
               {
                   UIApplication.shared.endIgnoringInteractionEvents()
                   
                   let dictResponse = kSharedInstance.getDictionary(response)
                   
                   if Int.getInt(dictResponse["success"]) == 1
                   {
                       let result = kSharedInstance.getDictionary(dictResponse["result"])
                       
                    let orderData = kSharedInstance.getDictionary(result["orderData"])
                    
                    
                       let myReview = kSharedInstance.getArray(orderData["myReview"])
                       
                    if myReview.count != 0
                    {
                        strongSelf.myReview = kSharedInstance.getArray(orderData["myReview"])
                    }
                     
                    strongSelf.tblReviews.reloadData()
                       
                       
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
    
    
    func reviewVC(withDictData dictData : Dictionary<String,Any>, reviewId : String)
    {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextVC = sb.instantiateViewController(withIdentifier: ReviewVC.storyboardId()) as! ReviewVC
        
        nextVC.productData = dictData
        nextVC.reviewId    = reviewId
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
}
