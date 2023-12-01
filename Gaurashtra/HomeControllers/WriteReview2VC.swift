//
//  WriteReview2VC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 30/01/20.
//  Copyright © 2020 Gaurashtra. All rights reserved.
//

import UIKit

class WriteReview2VC: GaurashtraBaseVC,UITextViewDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txtView: UITextView!
    
    @IBOutlet weak var imgBad: UIImageView!
    @IBOutlet weak var imgTerrible: UIImageView!
    
    @IBOutlet weak var imgOk: UIImageView!
    @IBOutlet weak var imgGood: UIImageView!
    
    @IBOutlet weak var imgGreat: UIImageView!
    
    private var dictParams = [kUserId     : "",
                              kProdId  : "",
                              kReview     : "",
                              kRating     : ""]
    
    //userid, productId, review, rating
    
    var productId : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

         txtView.delegate = self
         txtView.text = "write here..."
         txtView.textColor = UIColor.lightGray
    }
    
    @IBAction func tapDismiss(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func tapToContinue(_ sender: UIButton) {
        
        self.dictParams[kUserId]    = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        self.dictParams[kProdId] = String.getString(productId)
        self.dictParams[kReview]    = String.getString(self.txtView.text)
        
        self.checkValidation()
        
    }
    
    @IBAction func tapToEmoji(_ sender: UIButton) {
        
        switch sender.tag {
            case 1:
            
              self.dictParams[kRating]    = "1"
            
              self.imgTerrible.image = self.imgTerrible.image?.withRenderingMode(.alwaysTemplate)
              self.imgTerrible.tintColor = UIColor(red: 255.0/255.0, green: 97.0/255.0, blue: 33.0/255.0, alpha: 1.0)
            
              
              self.imgBad.image = self.imgBad.image?.withRenderingMode(.alwaysTemplate)
              self.imgBad.tintColor = .lightGray
              
             self.imgOk.image     = self.imgOk.image?.withRenderingMode(.alwaysTemplate)
             self.imgOk.tintColor = .lightGray
              
              
             self.imgGood.image     = self.imgGood.image?.withRenderingMode(.alwaysTemplate)
             self.imgGood.tintColor = .lightGray
              
             self.imgGreat.image     = self.imgGreat.image?.withRenderingMode(.alwaysTemplate)
             self.imgGreat.tintColor = .lightGray
            
            
            
            case 2:
            
               self.dictParams[kRating]    = "2"
            
               self.imgTerrible.image     = self.imgTerrible.image?.withRenderingMode(.alwaysTemplate)
               self.imgTerrible.tintColor = .lightGray
          
            
               self.imgBad.image = self.imgBad.image?.withRenderingMode(.alwaysTemplate)
               self.imgBad.tintColor = UIColor(red: 255.0/255.0, green: 97.0/255.0, blue: 33.0/255.0, alpha: 1.0)
                
               self.imgOk.image     = self.imgOk.image?.withRenderingMode(.alwaysTemplate)
               self.imgOk.tintColor = .lightGray
                
                
               self.imgGood.image     = self.imgGood.image?.withRenderingMode(.alwaysTemplate)
               self.imgGood.tintColor = .lightGray
                
               self.imgGreat.image     = self.imgGreat.image?.withRenderingMode(.alwaysTemplate)
               self.imgGreat.tintColor = .lightGray

            
            
            case 3:
            
            
                self.dictParams[kRating]    = "3"
            
                self.imgTerrible.image     = self.imgTerrible.image?.withRenderingMode(.alwaysTemplate)
                self.imgTerrible.tintColor = .lightGray
           
             
                self.imgBad.image = self.imgBad.image?.withRenderingMode(.alwaysTemplate)
                self.imgBad.tintColor = .lightGray
               
                self.imgOk.image     = self.imgOk.image?.withRenderingMode(.alwaysTemplate)
                self.imgOk.tintColor = UIColor(red: 255.0/255.0, green: 97.0/255.0, blue: 33.0/255.0, alpha: 1.0)
                
                 
                self.imgGood.image     = self.imgGood.image?.withRenderingMode(.alwaysTemplate)
                self.imgGood.tintColor = .lightGray
                 
                self.imgGreat.image     = self.imgGreat.image?.withRenderingMode(.alwaysTemplate)
                self.imgGreat.tintColor = .lightGray
            
            
            
            
            case 4:
            
                 self.dictParams[kRating]    = "4"
            
                 self.imgTerrible.image     = self.imgTerrible.image?.withRenderingMode(.alwaysTemplate)
                 self.imgTerrible.tintColor = .lightGray
            
              
                 self.imgBad.image = self.imgBad.image?.withRenderingMode(.alwaysTemplate)
                 self.imgBad.tintColor = .lightGray
                
                 self.imgOk.image     = self.imgOk.image?.withRenderingMode(.alwaysTemplate)
                 self.imgOk.tintColor = .lightGray
                  
                 self.imgGood.image     = self.imgGood.image?.withRenderingMode(.alwaysTemplate)
                 self.imgGood.tintColor = UIColor(red: 255.0/255.0, green: 97.0/255.0, blue: 33.0/255.0, alpha: 1.0)
                 
                  
                 self.imgGreat.image     = self.imgGreat.image?.withRenderingMode(.alwaysTemplate)
                 self.imgGreat.tintColor = .lightGray
            
            
            case 5:
             
                self.dictParams[kRating]    = "5"
               
                self.imgTerrible.image     = self.imgTerrible.image?.withRenderingMode(.alwaysTemplate)
                self.imgTerrible.tintColor = .lightGray
           
             
                self.imgBad.image = self.imgBad.image?.withRenderingMode(.alwaysTemplate)
                self.imgBad.tintColor = .lightGray
               
                self.imgOk.image     = self.imgOk.image?.withRenderingMode(.alwaysTemplate)
                self.imgOk.tintColor = .lightGray
                 
                self.imgGood.image     = self.imgGood.image?.withRenderingMode(.alwaysTemplate)
                self.imgGood.tintColor = .lightGray
                 
                self.imgGreat.image     = self.imgGreat.image?.withRenderingMode(.alwaysTemplate)
                self.imgGreat.tintColor = UIColor(red: 255.0/255.0, green: 97.0/255.0, blue: 33.0/255.0, alpha: 1.0)
                
            
            
        default:
            break
        }
        
        
        
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
          if txtView.textColor == UIColor.lightGray {
              txtView.text = nil
              txtView.textColor = UIColor.black
          }
      }
      
      func textViewDidEndEditing(_ textView: UITextView) {
          if txtView.text.isEmpty {
              txtView.text = "write here..."
              txtView.textColor = UIColor.lightGray
          }
      }
      
      func checkValidation()
      {
          if String.getLength(self.dictParams[kReview]) == 0 || txtView.textColor == UIColor.lightGray
          {
              self.view.makeToast(kEnterMessage, duration: 1.5, position: .center)
            
          }else if String.getLength(self.dictParams[kRating]) == 0
          {
              self.view.makeToast("Please rate!", duration: 1.5, position: .center)
            
            
          }  else {
              
              if isInternetAvailable()
              {
                  self.callSetProductReviewRatingWebService()
                  
              }else{
                  
                  self.view.makeToast(kNetworkErrorAlert, duration: 1.5, position: .center)
              }
              
          }
          
      }
    
    //#MARK: callSetProductReviewRatingWebService 
    private func callSetProductReviewRatingWebService()
    {
        
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kSetProductReviewRating, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Sending...", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
//                    strongSelf.view.makeToast(String.getString(dictResponse[kMessage]), duration: 1.5, position: .center)
                    
                   
                    
                    strongSelf.showOkAlert(withMessage: String.getString(dictResponse[kMessage])) {
                        
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
