//
//  ReviewVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 29/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit

class ReviewVC: GaurashtraBaseVC,UITextViewDelegate {

    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var lblProductName: UILabel!
    
    @IBOutlet weak var btn1: UIButton!
    
    @IBOutlet weak var btn2: UIButton!
    
    
    @IBOutlet weak var btn3: UIButton!
    
    @IBOutlet weak var btn4: UIButton!
    
    @IBOutlet weak var btn5: UIButton!
    
    @IBOutlet weak var txtView: UITextView!
    var reviewId : String = ""
    //userid, productId, review, rating
    
    var productData : Dictionary<String,Any> = ["":""]
    
    fileprivate var dictParams = [kUserId     : "",
                                  kProdId     : "",
                                  kReview     : "",
                                  kRating     : "",
                                  kReviewType : "",
                                  kReviewId   : ""]
                                  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDevice()
        let productName = String.getString(productData["productName"])
        
        self.lblProductName.text = productName
        
        
        let img = String.getString(productData["productImage"])
        
        let replacedURL = img.replacingOccurrences(of: ".jpg", with: "-300x300.jpg")
        
        let imageUrl2 = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL)
        guard let urlBrand3 = URL.init(string: imageUrl2) else { return }
        self.imgView.af_setImage(withURL: urlBrand3, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
        
        
        
        txtView.delegate = self
        txtView.text = "Tell us, what you like dislike about this product "
        txtView.textColor = UIColor.lightGray
       
    }//reviewRating reviewText
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print(productData)
        if reviewId == "0"
        {
            self.lblHeader.text          = "Write a Review"
            self.dictParams[kReviewType] = "add"
        }else{
            self.lblHeader.text          = "Edit Review"
            self.dictParams[kReviewType] = "edit"
            self.dictParams[kRating]     = String.getString(productData["reviewRating"])
            self.txtView.text = String.getString(productData["reviewText"])
            self.txtView.textColor = UIColor.darkText
            self.dictParams[kReviewId]   = reviewId
            self.showRating(withRatingValue: String.getString(productData["reviewRating"]))
        }
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
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtView.textColor == UIColor.lightGray {
            txtView.text = nil
            txtView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtView.text.isEmpty {
            txtView.text = "Tell us, What you Like Dislike About This Product "
            txtView.textColor = UIColor.lightGray
        }
    }

   
    @IBAction func tapToStar1(_ sender: UIButton) {
        
        self.btn1.setImage(UIImage(named: "star"), for: .normal)
        self.btn2.setImage(UIImage(named: "starLess"), for: .normal)
        self.btn3.setImage(UIImage(named: "starLess"), for: .normal)
        self.btn4.setImage(UIImage(named: "starLess"), for: .normal)
        self.btn5.setImage(UIImage(named: "starLess"), for: .normal)
        self.dictParams[kRating] = "1"
        
    }
    @IBAction func tapToStar2(_ sender: UIButton) {
        
        self.btn1.setImage(UIImage(named: "star"), for: .normal)
        self.btn2.setImage(UIImage(named: "star"), for: .normal)
        self.btn3.setImage(UIImage(named: "starLess"), for: .normal)
        self.btn4.setImage(UIImage(named: "starLess"), for: .normal)
        self.btn5.setImage(UIImage(named: "starLess"), for: .normal)
        self.dictParams[kRating] = "2"
        
    }
    
    @IBAction func tapToBtn3(_ sender: UIButton) {
        
        self.btn1.setImage(UIImage(named: "star"), for: .normal)
        self.btn2.setImage(UIImage(named: "star"), for: .normal)
        self.btn3.setImage(UIImage(named: "star"), for: .normal)
        self.btn4.setImage(UIImage(named: "starLess"), for: .normal)
        self.btn5.setImage(UIImage(named: "starLess"), for: .normal)
        self.dictParams[kRating] = "3"
        
    }
    
    @IBAction func tapToStar4(_ sender: UIButton) {
        
        self.btn1.setImage(UIImage(named: "star"), for: .normal)
        self.btn2.setImage(UIImage(named: "star"), for: .normal)
        self.btn3.setImage(UIImage(named: "star"), for: .normal)
        self.btn4.setImage(UIImage(named: "star"), for: .normal)
        self.btn5.setImage(UIImage(named: "starLess"), for: .normal)
        self.dictParams[kRating] = "4"
        
    }
    
    @IBAction func tapToBtn5(_ sender: UIButton) {
        
        self.btn1.setImage(UIImage(named: "star"), for: .normal)
        self.btn2.setImage(UIImage(named: "star"), for: .normal)
        self.btn3.setImage(UIImage(named: "star"), for: .normal)
        self.btn4.setImage(UIImage(named: "star"), for: .normal)
        self.btn5.setImage(UIImage(named: "star"), for: .normal)
        
        self.dictParams[kRating] = "5"
        
    }
    func showRating(withRatingValue ratingValue: String)
    {
        if ratingValue == "1"
        {
            self.btn1.setImage(UIImage(named: "star"), for: .normal)
            self.btn2.setImage(UIImage(named: "starLess"), for: .normal)
            self.btn3.setImage(UIImage(named: "starLess"), for: .normal)
            self.btn4.setImage(UIImage(named: "starLess"), for: .normal)
            self.btn5.setImage(UIImage(named: "starLess"), for: .normal)
        }else if ratingValue == "2"
        {
            self.btn1.setImage(UIImage(named: "star"), for: .normal)
            self.btn2.setImage(UIImage(named: "star"), for: .normal)
            self.btn3.setImage(UIImage(named: "starLess"), for: .normal)
            self.btn4.setImage(UIImage(named: "starLess"), for: .normal)
            self.btn5.setImage(UIImage(named: "starLess"), for: .normal)
        }else if ratingValue == "3"
        {
             self.btn1.setImage(UIImage(named: "star"), for: .normal)
             self.btn2.setImage(UIImage(named: "star"), for: .normal)
             self.btn3.setImage(UIImage(named: "star"), for: .normal)
             self.btn4.setImage(UIImage(named: "starLess"), for: .normal)
             self.btn5.setImage(UIImage(named: "starLess"), for: .normal)
        }else if ratingValue == "4"
        {
            self.btn1.setImage(UIImage(named: "star"), for: .normal)
            self.btn2.setImage(UIImage(named: "star"), for: .normal)
            self.btn3.setImage(UIImage(named: "star"), for: .normal)
            self.btn4.setImage(UIImage(named: "star"), for: .normal)
            self.btn5.setImage(UIImage(named: "starLess"), for: .normal)
        }else if ratingValue == "5"
        {
            self.btn1.setImage(UIImage(named: "star"), for: .normal)
            self.btn2.setImage(UIImage(named: "star"), for: .normal)
            self.btn3.setImage(UIImage(named: "star"), for: .normal)
            self.btn4.setImage(UIImage(named: "star"), for: .normal)
            self.btn5.setImage(UIImage(named: "star"), for: .normal)
        }
    }
    
    @IBAction func tapToSubmit(_ sender: UIButton) {
        
      //  kUserId kProdId kReview
        
        self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        
        self.dictParams[kProdId] = String.getString(self.productData["productId"])
        
         if txtView.textColor != UIColor.lightGray {
             self.dictParams[kReview] = String.getString(txtView.text)
        }
   
        //print(self.dictParams)
        
        self.checkValidation()
    }
    
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    //#MARK:-------checkValidation------------
    private func checkValidation()
    {
        if String.getLength(dictParams[kRating]) == 0
        {


            showOkAlert(withMessage: kGiveRating )


        } else if String.getLength(dictParams[kReview]) == 0 || txtView.textColor == UIColor.lightGray
        {

            showOkAlert(withMessage: kEnterReview )


        } else {

            if isInternetAvailable()
            {

               
                self.callSetProductReviewRatingWebService()


            }
            else{

                showOkAlert(withMessage: kNetworkErrorAlert)

            }

        }
    }
    
    
    //#MARK:-----------callAddReviewWebService---------
    private func callSetProductReviewRatingWebService()
    {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kSetProductReviewRating, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    
//                    strongSelf.txtView.text = nil
//
//                    strongSelf.btn1.setImage(UIImage(named: "starLess"), for: .normal)
//                    strongSelf.btn2.setImage(UIImage(named: "starLess"), for: .normal)
//                    strongSelf.btn3.setImage(UIImage(named: "starLess"), for: .normal)
//                    strongSelf.btn4.setImage(UIImage(named: "starLess"), for: .normal)
//                    strongSelf.btn5.setImage(UIImage(named: "starLess"), for: .normal)
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
