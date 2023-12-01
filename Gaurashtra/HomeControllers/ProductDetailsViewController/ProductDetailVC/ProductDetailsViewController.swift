//
//  ProductDetailsViewController.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 22/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit
import Toast_Swift

class ProductDetailsViewController: GaurashtraBaseVC{

    @IBOutlet weak var avlblOfferConstraintH: NSLayoutConstraint!
    @IBOutlet weak var activity2: UIActivityIndicatorView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var topImgIconView: UIView!
    @IBOutlet weak var lblMainScreen: UILabel!
    @IBOutlet weak var tblOffer: UITableView!
    let gradientLayer = CAGradientLayer()
    let bgImageView = UIImageView(image: #imageLiteral(resourceName: "graybox2"))
    let shimmerImageView = UIImageView(image: #imageLiteral(resourceName: "gaybox1"))
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    
    @IBOutlet weak var btnRating: UIButton!
    
    @IBOutlet weak var lblQty2: UILabel!
    
    @IBOutlet weak var packOfView2: UIView!
    
    @IBOutlet weak var tblProdDetail: UITableView!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var lblQty: UILabel!
    
    @IBOutlet weak var lblQtyTitle: UILabel!
    
    @IBOutlet weak var lblQtyTitle2: UILabel!
    
   
    
    @IBOutlet weak var btnAddCart: UIButton!
    
    @IBOutlet weak var lblPackOff: UILabel!
    @IBOutlet weak var btnCheckPincode: UIButton!
    @IBOutlet weak var btnDropLine: UIButton!
    @IBOutlet weak var constraintHAskQues: NSLayoutConstraint!
    
    @IBOutlet weak var lblProdPrice: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgWishList: UIImageView!
    
  //  @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var starView: UIView!
    
    @IBOutlet weak var arrowImgConstraintH: NSLayoutConstraint!
    
    @IBOutlet weak var topCollectionV: UICollectionView!
    @IBOutlet weak var upperCollectionView: UICollectionView!
    
    @IBOutlet weak var lblSpecialPrice: UILabel!
    @IBOutlet weak var lblPercentageOff: UILabel!
    
    @IBOutlet weak var lblProdPriceLine: UILabel!
    //imgViewNoDataFound
   
    @IBOutlet weak var imgViewNoDataFound: UIImageView!
    
    @IBOutlet weak var lblCheckPincode: UILabel!
    @IBOutlet weak var lblAvgRating: UILabel!
    @IBOutlet weak var lblRatingCount: UILabel!
  //  @IBOutlet weak var lblOffer: UILabel!
    
    @IBOutlet weak var lblProdName: UILabel!
    
    @IBOutlet weak var lblAvailability: UILabel!
    
    @IBOutlet weak var bottomConstraintH: NSLayoutConstraint!
    
    @IBOutlet weak var packOfView1: UIView!
    @IBOutlet weak var txtField: UITextField!
    
    @IBOutlet weak var imgViewContent1: UIImageView!
    
    @IBOutlet weak var imgViewContent2: UIImageView!
    
    
    @IBOutlet weak var imgViewContent3: UIImageView!
    @IBOutlet weak var lblContent1: UILabel!
    
    @IBOutlet weak var lblContent2: UILabel!
    @IBOutlet weak var lblBrandName: UILabel!
    
    @IBOutlet weak var lblTitle2: UILabel!
    
    @IBOutlet weak var lblContent3: UILabel!
    
    @IBOutlet weak var qtyView2: UIView!
    
   
    @IBOutlet weak var qtyView: UIView!
    @IBOutlet weak var lblTitle3: UILabel!
    @IBOutlet weak var lblTitle1: UILabel!
    
    var product_id      : String = ""
    var option_value_id : String = ""
    
    
    var dictData : Dictionary<String,Any> = ["":""]
    
    var product_quantity : String = ""
    
    var discount_quantity : String = ""
    
    var reviewDataList : [Any] = []
    
    var mapListdata    : [Any]  = []
    
    var arrData : [Any] = ["1"]
    
    var productQtyList : [String] = []
    
    var prodQty : String = ""
   
    private var dictParams = [kUserId        : "",
                              kProductId     : "",
                              kOptionvalueid : ""]
    
    private var dictParamsPin = [kUserId       : "",
                                 kPostcode     : ""]
    
    private var dictParamsAddCart = [kUserId        : "",
                                     kQuantity      : "",
                                     kProductId     : "",
                                     kActiontype    : "",
                                     kOptionid      : "",
                                     kOptionvalueid : "",
                                     kCouponCode    : "",
                                     kCurrencyCode  : "",
                                     kCurrencyValue : ""]
   
    
    
    var prodDecs              : String = ""
    var askQuestion           : [Any] = []
    var relatedProduct        : [Any] = []
    var recentlyPurchasedData :[Any] = []
    var data : Dictionary<String,Any> = ["":""]
    var imgListArr : [String] = []
    var staticContent : [Any] = []
    //buttomCollectionVIew
    var identifyCell : Int = 0
    
    var seoUrl : String = ""
   
    @IBOutlet weak var btnViewAllReview: UIButton!
    
    @IBOutlet weak var btnDecs: UIButton!
    
    @IBOutlet weak var btnReviews: UIButton!
    
    @IBOutlet weak var btnAskQuestion: UIButton!
    
    
    @IBOutlet weak var buttomCollectionView: UICollectionView!
    
    @IBOutlet weak var imgSubView: UIView!
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var img2: UIImageView!
    
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var orderTimeView: UIView!
    
    
    @IBOutlet weak var indexBtn1: UIButton!
    
    @IBOutlet weak var indexBtn2: UIButton!
    
    
    @IBOutlet weak var indexBtn3: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnViewAllReview.isHidden = true

        self.getDevice()
        self.bottomView.isHidden = false
        
         self.identifyCell = 1
    

        self.btnDropLine.isHidden        = true
        
        
        self.constraintHAskQues.constant   = 0
        self.arrowImgConstraintH.constant  = 0
        
         txtField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.btnCheckPincode.isEnabled = false
        self.btnCheckPincode.alpha     = 0.4
        
        self.self.img1.layer.borderWidth = 1
        self.img1.layer.borderColor = UIColor(red:176/255, green:166/255, blue:210/255, alpha: 1).cgColor
        
         kSharedInstance.setShadow(withSubView: orderTimeView, cornerRedius: 0)
        
        self.registerNib()
        self.registerNib2()
        self.configureView()
        self.registerNibDecs()

        
        self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        
         self.dictParams[kProductId]    = String.getString(product_id)
        self.dictParams[kOptionvalueid] = String.getString(option_value_id)
        
        if isInternetAvailable()
        {
            //self.callGetProductDetailsWebService(withProgressHUD: false)
            self.tblProdDetail.isHidden    = true
            self.bottomView.isHidden       = true
            self.callGetProductDetailsWebService1(withProgressHUD: true)
            
//            self.setupShimmeringImage()
            
           // kSharedInstance.setupShimmeringImage(withView: self.view, backGrroundImgV: bgImageView, shimmerImageView: shimmerImageView)
            
        }else{
            showOkAlert(withMessage: kNetworkErrorAlert)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.packOfView1.isHidden  = true
        self.packOfView2.isHidden  = true
        
        self.imgViewNoDataFound.isHighlighted = true
        self.imgViewNoDataFound.isUserInteractionEnabled = false
        self.getDevice2()
        
    }
    
    @IBAction func tapToQty(_ sender: UIButton) {
        self.selectQnty()
        
    }
    
    
    @IBAction func tapToPackOf(_ sender: UIButton) {
    }
    
    @IBAction func tapToCheckPincode(_ sender: UIButton) {
        
        self.dictParamsPin[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        
        self.dictParamsPin[kPostcode] = String.getString(txtField.text)
        
        if isInternetAvailable()
        {
            self.callCheckOnlyPincodeWebService()
        }else{
            
            showOkAlert(withMessage: kNetworkErrorAlert)
        }
        
    }
    
  
    
    fileprivate func configureView()
    {
        
        
        btnDecs.isSelected = true
        btnReviews.isSelected = false
        btnAskQuestion.isSelected = false
        if btnDecs.isSelected
        {
            btnDecs.backgroundColor = UIColor(red: 46.0/255.0, green: 50.0/255.0, blue: 74.0/255.0, alpha: 1.0)
            btnReviews.backgroundColor = UIColor.white
            btnAskQuestion.backgroundColor = UIColor.white
            
        }
        
        
    }
    fileprivate func setButtonSelected(_ sender: UIButton)
    {
        for button in [btnDecs, btnReviews, btnAskQuestion]
        {
            if button == sender
            {
                sender.isSelected = true
                
            }
            else
            {
                button?.isSelected = false
            }
        }
        
    }

    @IBAction func tapToDescriptions(_ sender: UIButton) {
        
        if !sender.isSelected
        {
            self.btnViewAllReview.isHidden = true
            btnDecs.isSelected = true
            btnReviews.isSelected = false
            btnAskQuestion.isSelected = false
            
            btnReviews.backgroundColor = UIColor.white
            btnDecs.backgroundColor = UIColor(red: 46.0/255.0, green: 50.0/255.0, blue: 74.0/255.0, alpha: 1.0)
            btnAskQuestion.backgroundColor = UIColor.white
            self.registerNibDecs()
            self.identifyCell = 1
             self.topCollectionV.reloadData()
            self.constraintHAskQues.constant = 0
            self.arrowImgConstraintH.constant  = 0
            self.btnDropLine.isHidden        = true
          
        }
        
    }
    
    
    
    
    @IBAction func tapToReviews(_ sender: UIButton) {
        if !sender.isSelected
        {
            self.btnViewAllReview.isHidden = false
            btnDecs.isSelected = false
            btnReviews.isSelected = true
            btnAskQuestion.isSelected = false

            btnReviews.backgroundColor =  UIColor(red: 46.0/255.0, green: 50.0/255.0, blue: 74.0/255.0, alpha: 1.0)
            btnDecs.backgroundColor = UIColor.white
            btnAskQuestion.backgroundColor = UIColor.white
            self.registerNibReviews()
            self.identifyCell = 2
            self.topCollectionV.reloadData()
            self.constraintHAskQues.constant = 0
            self.arrowImgConstraintH.constant  = 0
            self.btnDropLine.isHidden        = true
        }
        
      
    }
    
    
    @IBAction func tapToAskQuestions(_ sender: UIButton) {
        
        if !sender.isSelected
        {
            self.btnViewAllReview.isHidden = true
            btnDecs.isSelected = false
            btnReviews.isSelected = false
            btnAskQuestion.isSelected = true
            
            btnReviews.backgroundColor = UIColor.white
            btnDecs.backgroundColor = UIColor.white
            btnAskQuestion.backgroundColor = UIColor(red: 46.0/255.0, green: 50.0/255.0, blue: 74.0/255.0, alpha: 1.0)
            self.registerNibAskQues()
            self.identifyCell = 3
            self.constraintHAskQues.constant = 50
            self.arrowImgConstraintH.constant  = 16
            self.btnDropLine.isHidden        = false
            self.topCollectionV.reloadData()
            
        }
        
    }
    
    
    
    private func registerNib() -> Void
    {
        let nibCards = UINib(nibName: UpperCVC.identifier(), bundle: nil)
        self.upperCollectionView.register(nibCards, forCellWithReuseIdentifier: UpperCVC.identifier())
    }
    
    private func registerNib2() -> Void
    {
        let nibCards = UINib(nibName: ButtomCVC.identifier(), bundle: nil)
        self.buttomCollectionView.register(nibCards, forCellWithReuseIdentifier: ButtomCVC.identifier())
    }
    
    private func registerNibDecs() -> Void
    {
        let nibCards = UINib(nibName: DescriptionCVC.identifier(), bundle: nil)
        self.topCollectionV.register(nibCards, forCellWithReuseIdentifier: DescriptionCVC.identifier())
    }
    private func registerNibReviews() -> Void
    {
        let nibCards = UINib(nibName: ReviewsCVC.identifier(), bundle: nil)
        self.topCollectionV.register(nibCards, forCellWithReuseIdentifier: ReviewsCVC.identifier())
    }
    private func registerNibAskQues() -> Void
    {
        let nibCards = UINib(nibName: AskQuestionCVC.identifier(), bundle: nil)
        self.topCollectionV.register(nibCards, forCellWithReuseIdentifier: AskQuestionCVC.identifier())
    }
    
 
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    @IBAction func tapToImgBtn(_ sender: UIButton) {
        
        let product = kSharedInstance.getDictionary(dictData["product"])
        
        let imageArr = kSharedInstance.getArray(product["image"])
        
       // //print(strongSelf.imgListArr[0])
        
        if self.imgListArr.count != 0
        {
            let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
            let nextVC = sb.instantiateViewController(withIdentifier: ImageViewController.storyboardId()) as! ImageViewController
            nextVC.imgArr = self.imgListArr
            
            self.present(nextVC, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func tapToBtn1(_ sender: UIButton) {
       
//        let product = kSharedInstance.getDictionary(dictData["product"])
//
//        let imageArr = kSharedInstance.getArray(product["image"])
        
        //
        if self.imgListArr.count != 0
        {
             let imgURL = String.getString(self.imgListArr[0])
                 
             let replacedURL = imgURL.replacingOccurrences(of: ".jpg", with: "-1100x1100.jpg")
            //https://www.gaurashtra.com/image/cache/catalog/cow-products/Gaurashtra-Gomay-Lohban-Cow-Dung-Dhoop-Cones-60x60.jpg
             let imageUrl = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL)
            //print(imageUrl)
             guard let urlBrand = URL.init(string: imageUrl) else { return }
             self.imgView.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
             
             self.img1.layer.borderWidth = 1
             self.img1.layer.borderColor = UIColor(red:176/255, green:166/255, blue:210/255, alpha: 1).cgColor
             self.img2.layer.borderWidth = 0
             self.img3.layer.borderWidth = 0
        }
        
     
        
       
        
    }
    
    @IBAction func tapToBtn2(_ sender: UIButton) {
        
//        let product = kSharedInstance.getDictionary(dictData["product"])
//
//        let imageArr = kSharedInstance.getArray(product["image"])
        
         if self.imgListArr.count >= 2
         {
           let imgURL = String.getString(self.imgListArr[1])
                //-60x80
//           let replacedURL = imgURL.replacingOccurrences(of: ".jpg", with: "-300x300.jpg")
            let replacedURL = imgURL.replacingOccurrences(of: ".jpg", with: "-1100x1100.jpg")
           //https://www.gaurashtra.com/image/cache/catalog/cow-products/panchagavya-medicine/triphala-powder/Gaurashtra-Triphala-Powder-3-2-1-Ratio-2-300x300.jpg
           let imageUrl = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL)
            //print(imageUrl)
            //
            //print(replacedURL)
           guard let urlBrand = URL.init(string: imageUrl) else { return }
           self.imgView.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
           self.img2.layer.borderWidth = 1
           self.img2.layer.borderColor = UIColor(red:176/255, green:166/255, blue:210/255, alpha: 1).cgColor
           self.img1.layer.borderWidth = 0
           self.img3.layer.borderWidth = 0
        }
    }
    
    @IBAction func tapToBrand(_ sender: UIButton) {
        
         let product = kSharedInstance.getDictionary(dictData["product"])
        //print(product)//data
        let data = kSharedInstance.getDictionary(product["data"])
        
        self.categoryDetailVC2(withserviceName: kGetBrandProductList, HeaderTitle: String.getString(data["brand_name"]), withId: 6, brandId: String.getString(data["brand_id"]))
    }
    
    
    @IBAction func tapToShare(_ sender: UIButton) {
        //let link = seoUrl
        let activityViewController = UIActivityViewController(activityItems: [self.seoUrl], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        self.present(activityViewController, animated: true, completion: nil)
    }
    @IBAction func tapToAddWishList(_ sender: UIButton) {
        
        self.dictParamsAddCart[kActiontype]   = "add"
        
        self.dictParamsAddCart[kUserId]     = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        
        self.dictParamsAddCart[kCurrencyCode]     = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
        
        self.dictParamsAddCart[kCurrencyValue]     = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
        
        
        
         //kCurrencyCode kCurrencyValue
   
        self.dictParamsAddCart[kQuantity]  = "1"
        
        self.dictParamsAddCart[kProductId]  = String.getString(product_id)
        
        if isInternetAvailable()
        {
            self.callWishListWebService()
        }else{
            
            showOkAlert(withMessage: kNetworkErrorAlert)
        }
        
        
    }
    

    
    @IBAction func txtFieldPincodeLenght(_ sender: UITextField) {
        
        let lenght = txtField.text?.count
        let txtStr = txtField.text
        if (lenght! >= 6)
        {
            let indx = txtStr?.index((txtStr?.startIndex)!, offsetBy: 6)
            txtField.text = txtField.text?.substring(to: indx!)
            
        }
        
    }
    
    
    @IBAction func tapToDropYourLine(_ sender: UIButton) {
        
        
        let userId = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        
        self.askQuestionVC()
        
//        if String.getLength(userId) != 0
//        {
//            self.askQuestionVC()
//        }else{
//            
//            self.loginVc()
//        }
        
        
        
    }
    
    
    @IBAction func tapToBtn3(_ sender: UIButton) {
   
//        let product = kSharedInstance.getDictionary(dictData["product"])
//
//        let imageArr = kSharedInstance.getArray(product["image"])
        if self.imgListArr.count >= 3
        {
            let imgURL = String.getString(self.imgListArr[2])
                   
            let replacedURL = imgURL.replacingOccurrences(of: ".jpg", with: "-1100x1100.jpg")
           
            let imageUrl = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL)
            guard let urlBrand = URL.init(string: imageUrl) else { return }
            self.imgView.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
            self.img3.layer.borderWidth = 1
            self.img3.layer.borderColor = UIColor(red:176/255, green:166/255, blue:210/255, alpha: 1).cgColor
            self.img1.layer.borderWidth = 0
            self.img2.layer.borderWidth = 0
        }
        
       
        
    }
    
    
    @IBAction func tapToAddCart(_ sender: UIButton) {
        //kProductId,kOptionid,kOptionvalueid,kCouponCode
         //print(self.prodQty)
        //
        let userId = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        if String.getLength(userId) != 0
        {
            let product_quantity = String.getString(self.data["product_quantity"])
            if Int.getInt(product_quantity) != 0
            {
                let option_id = String.getString(self.data["option_id"])
                //print(option_id)
               if Int.getInt(option_id) != 0
               {
                // let dictData = kSharedInstance.getDictionary(self.productData[indexPath.item])
                let prodid = String.getString(self.data["product_id"])
                //print(self.dictData)
                //print(prodid)
                let option_id = String.getString(self.data["option_id"])
                 if option_id != "0"
                 {
                   self.productOptionsVC(withProductId: String.getString(self.data["product_id"]))
                 }
               }else{
                
                 self.dictParamsAddCart[kActiontype]   = "add"
                 self.dictParamsAddCart[kCurrencyCode]     = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
                 self.dictParamsAddCart[kCurrencyValue]     = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
                 self.dictParamsAddCart[kUserId]     = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
                 if String.getLength(self.prodQty) != 0
                 {
                   self.dictParamsAddCart[kQuantity]   = String.getString(self.prodQty)
                 }else{
                   self.dictParamsAddCart[kQuantity]   = "1"
                   
                 }
                 self.dictParamsAddCart[kProductId]  = String.getString(product_id)
                 self.dictParamsAddCart[kOptionid]   = String.getString(self.data["option_id"])
                 self.dictParamsAddCart[kOptionvalueid] = String.getString(self.data["option_value_id"])
                 self.dictParamsAddCart[kOptionid] = String.getString(self.data["option_id"])
                 self.callAddCardProdctsListVCWebServices()
                }
            }else{
                
                self.notifyMeVC(withProductId: String.getString(data["product_id"]))
            }
        }else{
             self.loginVc()
        }
    }
    @IBAction func tapToQty2(_ sender: UIButton) {
        self.selectQnty()
    }
    func selectQnty()
    {
        let picker = RSPickerView.init(view: self.view, arrayList: self.productQtyList, keyValue: nil, handler: { (selectedIndex: NSInteger, response: Any?) in
            //print(self.productQtyList)
            let qty = self.productQtyList[selectedIndex]
            self.prodQty = String.getString(qty)
            self.lblQty.text = qty
            self.lblQty2.text = qty
        })
        picker.viewContainer.backgroundColor = kWhiteColor
    }
    @IBAction func tapToRating(_ sender: UIButton) {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        let nextVC = sb.instantiateViewController(withIdentifier: ReviewsCV.storyboardId()) as! ReviewsCV
        nextVC.reviewList = self.reviewDataList
        self.present(nextVC, animated: true) { }
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
    
    @IBAction func tapToViewAllReview(_ sender: UIButton) {
        
        
        if reviewDataList.count != 0
        {
            self.productReviewVC(withReviewList: self.reviewDataList)
        }
    }
    
    
    
    func productReviewVC(withReviewList reviewList : [Any])
    {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextVC = sb.instantiateViewController(withIdentifier: ReviewsCV.storyboardId()) as! ReviewsCV
        
        nextVC.reviewList  = reviewList
        nextVC.vcId        = 1
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    @IBAction func tapToPackOff(_ sender: UIButton) {
    }
    
    
    //#MARK:-----------callCategoryListWebService---------
    private func callWishListWebService()
    {
        
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kManageWishlist, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParamsAddCart, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                strongSelf.view.makeToast(String.getString(dictResponse[kMessage]), duration: 1.5, position: .center)
                 
                    strongSelf.callGetProductDetailsWebService(withProgressHUD: false)
                    
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


extension ProductDetailsViewController : UITextFieldDelegate
{
    @objc func textFieldDidChange(textField:UITextField)
    {
        let text = textField.text
        
        if (text?.utf16.count)! > 5
        {
            
            self.btnCheckPincode.isEnabled = true
            
            self.btnCheckPincode.alpha = 1.0
            
            
        }else{
            
            self.btnCheckPincode.isEnabled = false
            self.btnCheckPincode.alpha = 0.4
            
            
        }
        
    }
    
}
extension ProductDetailsViewController : UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
          case self.tblProdDetail:
              return arrData.count
          case self.tblOffer:
            return staticContent.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        
        switch tableView {
          case self.tblProdDetail:
            let cell = tblProdDetail.dequeueReusableCell(withIdentifier: ProductDetailTVC.cellIdentifier(), for: indexPath) as! ProductDetailTVC
                   cell.configureCell(withDictData: self.data, AndAddCart: {(btnCart : UIButton) in
                       //print("tap")
                     
                      let userId = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
                      if String.getLength(userId) != 0
                      {
                          let product_quantity = String.getString(self.data["product_quantity"])
                          if Int.getInt(product_quantity) != 0
                          {
                           let option_id = String.getString(self.data["option_id"])
                           //print(option_id)
                           if Int.getInt(option_id) != 0
                           {
                                             // let dictData = kSharedInstance.getDictionary(self.productData[indexPath.item])
                               let prodid = String.getString(self.data["product_id"])
                              
                             //print(prodid)
                               let option_id = String.getString(self.data["option_id"])
                             if option_id != "0"
                             {
                               self.productOptionsVC(withProductId: String.getString(self.data["product_id"]))
                             }
                           }else{
                               self.dictParamsAddCart[kActiontype]   = "add"
                               self.dictParamsAddCart[kCurrencyCode]     = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
                               self.dictParamsAddCart[kCurrencyValue]     = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
                               self.dictParamsAddCart[kUserId]     = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
                               if String.getLength(self.prodQty) != 0
                               {
                                   self.dictParamsAddCart[kQuantity]   = String.getString(self.prodQty)
                               }else{
                                   self.dictParamsAddCart[kQuantity]   = "1"
                               }
                               self.dictParamsAddCart[kProductId]      = String.getString(self.product_id)
                               self.dictParamsAddCart[kOptionid]       = String.getString(self.data["option_id"])
                               self.dictParamsAddCart[kOptionvalueid]  = String.getString(self.data["option_value_id"])
                               self.dictParamsAddCart[kOptionid]       = String.getString(self.data["option_id"])
                               self.callAddCardProdctsListVCWebServices()
                           }
                          }else{
                           //print(self.dictData)
                           self.notifyMeVC(withProductId: String.getString(self.data["product_id"]))
                          }
                      }else{
                           self.loginVc()
                      }
                   })
                   return cell
          case self.tblOffer:
            
            let cell = tblOffer.dequeueReusableCell(withIdentifier: OffersShowTVC.cellIdentifier(), for: indexPath) as! OffersShowTVC
            cell.configureCell(withDictData: kSharedInstance.getDictionary(self.staticContent[indexPath.row]), forIndxPath: indexPath)
            return cell
            
        default:
            return UITableViewCell()
        }
        
        
       
    }
    //staticContentData
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case tblProdDetail:
            return 66
        case tblOffer:
            if self.staticContent.count > 1
            {
                return 90
//                self.avlblOfferConstraintH.constant = 230
            }else{
//                self.avlblOfferConstraintH.constant = 130
                return 130
            }
          //  return 90
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == self.arrData.count - 1
        {
            self.bottomView.isHidden = true
            self.bottomConstraintH.constant = -50
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let _ = scrollView as? UITableView {
            self.getDevice(withScrollView: scrollView)
        }
    }
    func getDevice(withScrollView scrollView : UIScrollView)
    {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136://iphone 5/5S/SE
                
                if (scrollView.contentOffset.y < 900.0) {
                    
                    self.bottomView.isHidden = false
                    self.bottomConstraintH.constant = 50
                }
                
            case 1334://iphone 6/6S/7/8
                
                if (scrollView.contentOffset.y < 800.0) {
                    
                    self.bottomView.isHidden = false
                    self.bottomConstraintH.constant = 50
                    
                }
            case 1920://iphone 6/6S/7/8
                           
               if (scrollView.contentOffset.y < 800.0) {
                   
                   self.bottomView.isHidden = false
                   self.bottomConstraintH.constant = 50
                   
               }
                
            case 2208://iphone 6+/6S+/7+/8+
                
                //print(scrollView.contentOffset.y)
                
                if (scrollView.contentOffset.y < 750.0) {
                    
                    
                    self.bottomView.isHidden = false
                    self.bottomConstraintH.constant = 50
                    
                }
                
            case 2436://iphone X/XS  /11 pro
                
                //print(scrollView.contentOffset.y)
                
                
                if scrollView.contentOffset.y  < 690.0
                {
                    self.bottomView.isHidden = false
                    self.bottomConstraintH.constant = 80
                }
            case 2688://iphone XS Max
                if (scrollView.contentOffset.y < 600) {
                    self.bottomView.isHidden = false
                    self.bottomConstraintH.constant = 80
                }
            case 1792://iphone XR
                if (scrollView.contentOffset.y < 800) {
                    self.bottomView.isHidden = false
                    self.bottomConstraintH.constant = 80
                }
            case 2532 :
                if scrollView.contentOffset.y  < 610.0
                {
                    self.bottomView.isHidden = false
                    self.bottomConstraintH.constant = 80
                }
            case 2778 :
                if scrollView.contentOffset.y  < 580.0
                {
                    self.bottomView.isHidden = false
                    self.bottomConstraintH.constant = 80
                }
            case 2340 ://12 mini
                if scrollView.contentOffset.y  < 780.0
                {
                    self.bottomView.isHidden = false
                    self.bottomConstraintH.constant = 80
                }
            default:
                if scrollView.contentOffset.y  < 690.0
                {
                    self.bottomView.isHidden = false
                    self.bottomConstraintH.constant = 80
                }
                
            }
            
        }
        
        
    }
    
    
    func getDevice2()
    {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136://iphone 5/5S/SE
                
                self.bottomConstraintH.constant = 50
                
            case 1334://iphone 6/6S/7/8
                
                self.bottomConstraintH.constant = 50
            case 1920://iphone 6/6S/7/8
                           
               self.bottomConstraintH.constant = 50
                
            case 2208://iphone 6+/6S+/7+/8+
                
                self.bottomConstraintH.constant = 50
                
            case 2436://iphone X/XS
                
                self.bottomConstraintH.constant = 80
                
                
                
            case 2688://iphone XS Max
                
                self.bottomConstraintH.constant = 80

                
            case 1792://iphone XR
                
              self.bottomConstraintH.constant = 80

                
            default: break
                //print("unknown")
            }
            
        }
        
        
    }
    
    func productOptionsVC(withProductId prodId : String)
    {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        let nextVC = sb.instantiateViewController(withIdentifier: ProductOptionsVC.storyboardId()) as! ProductOptionsVC
        nextVC.prodId  = prodId
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    func loginVc()
    {
        let sb : UIStoryboard = UIStoryboard(name: kLoginPlaceholder, bundle: nil)
        let nextVC = sb.instantiateViewController(withIdentifier: LoginViewController.storyboardId()) as! LoginViewController
        kSharedUserDefaults.removeObject(forKey: "LoginView")
         self.present(nextVC, animated: true) { }
    }
   
}

//#MARK: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  
extension ProductDetailsViewController : UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout 
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        switch collectionView {
        case self.topCollectionV:
            
            if identifyCell == 1
            {
                return 1
                
            } else if identifyCell == 2
            {
                
                return self.reviewDataList.count
                
            } else if  identifyCell == 3
            {
                return self.askQuestion.count
                
            }else{
                
                return 0
            }
            
        case self.upperCollectionView:
            
            return relatedProduct.count
            
        case self.buttomCollectionView:
            return recentlyPurchasedData.count
            
        default:
            
            return 0
            
        }
        
        
        
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        //print(identifyCell)
        switch collectionView {
        case self.topCollectionV:
            
            if identifyCell == 1
            {
                
                let descriptionCVUpper = topCollectionV.dequeueReusableCell(withReuseIdentifier: DescriptionCVC.identifier(), for: indexPath) as! DescriptionCVC
                
                descriptionCVUpper.configureProdDecsCell(withStrData: self.prodDecs, forIndxPath: indexPath)
                
                return descriptionCVUpper
            }else if identifyCell == 2
            {
                let reviewsCVUpper = topCollectionV.dequeueReusableCell(withReuseIdentifier: ReviewsCVC.identifier(), for: indexPath) as! ReviewsCVC
                
                reviewsCVUpper.configureCell(withDictData: kSharedInstance.getDictionary(self.reviewDataList[indexPath.item]), indxpath: indexPath)
                
                return reviewsCVUpper
                
            }else if identifyCell == 3
            {
                let askQuesCVUpper = topCollectionV.dequeueReusableCell(withReuseIdentifier: AskQuestionCVC.identifier(), for: indexPath) as! AskQuestionCVC
                 askQuesCVUpper.configureAskQuestionCell(withDictData: kSharedInstance.getDictionary(self.askQuestion[indexPath.item]), forindxPath: indexPath)
                
                return askQuesCVUpper
                
            }else{
                
                return UICollectionViewCell()
            }
            
            
        case self.upperCollectionView:
            
            let cellCVUpper = upperCollectionView.dequeueReusableCell(withReuseIdentifier: UpperCVC.identifier(), for: indexPath) as! UpperCVC
            
           cellCVUpper.configureReLatedProdCell(withDictData: kSharedInstance.getDictionary(self.relatedProduct[indexPath.item]), forIndxPath: indexPath)
            
            
            return cellCVUpper
            
        case self.buttomCollectionView:
            let cellCVButtom = buttomCollectionView.dequeueReusableCell(withReuseIdentifier: ButtomCVC.identifier(), for: indexPath) as! ButtomCVC
            cellCVButtom.configureRecentlyPurchasedCell(withDictData: kSharedInstance.getDictionary(self.recentlyPurchasedData[indexPath.item]), forindxPath: indexPath)
            return cellCVButtom
            
        default:
            
            return UICollectionViewCell()
            
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        switch collectionView {
        case self.topCollectionV:
            
            break
            
        case self.upperCollectionView:
            
            let dictData = kSharedInstance.getDictionary(self.relatedProduct[indexPath.item])
            
            let prodId = String.getString(dictData["product_id"])
            
            //print(prodId)
            
            self.productDetailsSelfVC(withProductId: prodId, option_value_id: String.getString(dictData["option_value_id"]))
            
        case self.buttomCollectionView:
            
            let dictData = kSharedInstance.getDictionary(self.recentlyPurchasedData[indexPath.item])
            
            let prodId = String.getString(dictData["product_id"])
            
            self.productDetailsSelfVC(withProductId: prodId, option_value_id: String.getString(dictData["option_value_id"]))
            
            
        default:
            
            break
            
        }
        
        
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        switch collectionView {
            
        case self.topCollectionV:
            
            
            if identifyCell == 1
            {
                
                let width = (320 * kScreenWidth) / 320
                let hight = (300 * kScreenWidth) / 320
                
                return CGSize(width: width, height: hight)
            }else if identifyCell == 2
            {
                
                let dictData = kSharedInstance.getDictionary(reviewDataList[indexPath.item])
                
                
                let review_content = String.getString(dictData["review_content"])
                
                let cellHeight = String.getLength(review_content)
                
                if indexPath.item == 3
                {
                    
                    //print(cellHeight)
                    
                }
                
                var lenthFloat : CGFloat = 0.0
                
                if cellHeight <= 40
                {
                    lenthFloat = 120.0
                    
                }else if cellHeight >= 41 && cellHeight <= 60 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) + 60
                    
                }else if cellHeight >= 61 && cellHeight <= 80 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) + 40
                }else if cellHeight >= 81 && cellHeight <= 100 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) + 30
                    
                }else if cellHeight >= 101 && cellHeight <= 120 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) + 20
                }else if cellHeight >= 121 && cellHeight <= 140 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) + 10
                    
                }else if cellHeight >= 141 && cellHeight <= 160 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight)
                    
                }else if cellHeight >= 161 && cellHeight <= 180 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight)
                    
                }else if cellHeight >= 181 && cellHeight <= 200 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) - 20
                }else if cellHeight >= 201 && cellHeight <= 220 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) - 25
                    
                    
                }else if cellHeight >= 221 && cellHeight <= 240 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) - 30
                }else if cellHeight >= 241 && cellHeight <= 260 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) - 35
                }else if cellHeight >= 261 && cellHeight <= 300 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) - 40
                }else if cellHeight >= 301 && cellHeight <= 350 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) - 50
                }else if cellHeight >= 351 && cellHeight <= 400 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) - 60
                }else if cellHeight >= 401 && cellHeight <= 500 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) - 80
                }else if cellHeight >= 501 && cellHeight <= 600 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) - 100
                }else if cellHeight >= 501 && cellHeight <= 600 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) - 150
                }else if cellHeight >= 601 && cellHeight <= 700 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) - 200
                }else if cellHeight >= 701 && cellHeight <= 800 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) - 300
                }else if cellHeight >= 801 && cellHeight <= 900 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) - 350
                }else if cellHeight >= 901 && cellHeight <= 1000 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) - 400
                }else if cellHeight >= 1001 && cellHeight <= 1100 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) - 500
                }else if cellHeight >= 1101 && cellHeight <= 1200 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) - 600
                }else{
                    
                    lenthFloat = CGFloat(cellHeight) - 700
                }
                
                let width = (320 * kScreenWidth) / 320
                // let hight = (lenthFloat * kScreenWidth) / 320
                
                return CGSize(width: width, height: lenthFloat)
                
                
            }else if identifyCell == 3
            {
                let width = (320 * kScreenWidth) / 320
                let hight = (100 * kScreenWidth) / 320
                
                let dictData = kSharedInstance.getDictionary(self.askQuestion[indexPath.item])
                
                
                let questioner_content = String.getString(dictData["questioner_content"])
                
                let replayer_content = String.getString(dictData["replayer_content"])
                
                let questioner_contentLenght = String.getLength(questioner_content)
                
                let replayer_contentLenght = String.getLength(replayer_content)
                
                
                
                let cellHeight : Int = questioner_contentLenght + replayer_contentLenght
                
                if indexPath.item == 7
                {
                    //print(cellHeight)
                }
                
                
                var lenthFloat : CGFloat = 0.0
                
                if cellHeight <= 40
                {
                    lenthFloat = 200.0
                    
                }else if cellHeight >= 41 && cellHeight <= 60 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) + 140
                    
                }else if cellHeight >= 61 && cellHeight <= 80 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) + 140
                }else if cellHeight >= 81 && cellHeight <= 100 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) + 120
                    
                }else if cellHeight >= 101 && cellHeight <= 120 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) + 100
                    
                }else if cellHeight >= 121 && cellHeight <= 140 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) + 80
                    
                }else if cellHeight >= 141 && cellHeight <= 160 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) + 60
                    
                }else if cellHeight >= 161 && cellHeight <= 180 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) + 40
                    
                }else if cellHeight >= 181 && cellHeight <= 200 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight)
                }else if cellHeight >= 201 && cellHeight <= 220 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight)
                    
                    
                }else if cellHeight >= 221 && cellHeight <= 240 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight)
                    
                }else if cellHeight >= 241 && cellHeight <= 260 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight)
                }else if cellHeight >= 261 && cellHeight <= 300 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight)
                }else if cellHeight >= 301 && cellHeight <= 400 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight)
                }else if cellHeight >= 401 && cellHeight <= 460 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) - 200
                }else if cellHeight >= 461 && cellHeight <= 600 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) - 250
                }else if cellHeight >= 601 && cellHeight <= 800 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) - 300
                }else if cellHeight >= 801 && cellHeight <= 1000 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) - 350
                }else if cellHeight >= 1001 && cellHeight <= 1501 {
                    lenthFloat = 0.0
                    lenthFloat = CGFloat(cellHeight) - 650
                }else{
                    
                    lenthFloat = CGFloat(cellHeight)
                }
                
                
                
                return CGSize(width: width, height: lenthFloat)
                
                
                
                
            }else{
                
                return CGSize(width: 0.0, height: 0.0)
            }
            
        case self.upperCollectionView:
            
            let width = (120 * kScreenWidth) / 320
            let hight = (185 * kScreenWidth) / 320
            
            return CGSize(width: width, height: hight)
            
        case self.buttomCollectionView:
            let width = (120 * kScreenWidth) / 320
            let hight = (185 * kScreenWidth) / 320
            
            return CGSize(width: width, height: hight)
            
        default:
            
            return CGSize(width: 0.0, height: 0.0)
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        
        switch collectionView {
        case self.topCollectionV:
            
                return 0
          
            
        case self.upperCollectionView:
            
            return 16
            
        case self.buttomCollectionView:
            return 16
            
        default:
            
            return 0
            
        }
    
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        switch collectionView {
        case self.topCollectionV:
            
            return 0
            
        case self.upperCollectionView:
            
            return 0
            
        case self.buttomCollectionView:
            return 0
            
        default:
            
            return 0
            
        }
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        switch collectionView {
        case self.topCollectionV:
            
             return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
        case self.upperCollectionView:
            
            return UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16)
            
        case self.buttomCollectionView:
            return UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16)
            
        default:
            
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
        }
        
       
        
     
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
       // self.bottomView.isHidden = true
        
        
    }
    
    
    //#MARK:---------callketProductDetailsWebService------
    
    private func callGetProductDetailsWebService(withProgressHUD progressHUD : Bool)
    {
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetProductDetails, requestMethod: .post, requestImages: [dictImg], withProgressHUD: progressHUD, withProgessHUDTitle: "Please Wait...", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                strongSelf.bgImageView.removeFromSuperview()
                strongSelf.shimmerImageView.removeFromSuperview()
                if Int.getInt(dictResponse["success"]) == 1
                {
       
                    strongSelf.imgListArr.removeAll()
                    strongSelf.imgViewNoDataFound.isHidden = true
                    
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    
                    strongSelf.dictData = kSharedInstance.getDictionary(dictResponse["result"])

                    //print(result)
                    let prodData = kSharedInstance.getDictionary(result["data"])
                    let seo_url = String.getString(prodData["seo_url"])
                    //print(seo_url)
                    
                    strongSelf.seoUrl = seo_url
                    
                   // strongSelf.showData(withDictData: result)
                    strongSelf.showData2(withDictData: result)
                    
                    let product = kSharedInstance.getDictionary(result["product"])
                    
                    strongSelf.data = kSharedInstance.getDictionary(product["data"])
                    
                    let product_quantity = String.getString(kSharedInstance.getDictionary(product["data"])["product_quantity"])
                        

                    
                         
                    if Int.getInt(product_quantity) != 0
                         {
                             strongSelf.qtyView.isHidden = false
                             strongSelf.qtyView2.isHidden = false
                            
                            strongSelf.lblQtyTitle.isHidden = false
                            
                            strongSelf.lblQtyTitle2.isHidden = false
                            
                             strongSelf.btnAddCart.setTitle("Add to Cart", for: .normal)
                             strongSelf.btnAddCart.backgroundColor = UIColor(red: 254.0/255.0, green: 85.0/255.0, blue: 22.0/255.0, alpha: 1.0)
                         }else{
                             
                             strongSelf.qtyView.isHidden = true
                             strongSelf.qtyView2.isHidden = true
                        
                             strongSelf.lblQtyTitle.isHidden = true
                                                  
                            strongSelf.lblQtyTitle2.isHidden = true
                        
                              strongSelf.btnAddCart.setTitle("Notify Me", for: .normal)
                              strongSelf.btnAddCart.backgroundColor = UIColor(red: 176.0/255.0, green: 223.0/255.0, blue: 229.0/255.0, alpha: 1.0)
                         }
                    
                    let discount_quantity = String.getString(kSharedInstance.getDictionary(product["data"])["discount_quantity"])
                    
                    strongSelf.discount_quantity = discount_quantity
                    
                    strongSelf.product_quantity = String.getString(kSharedInstance.getDictionary(product["data"])["product_quantity"])
                    
                    if String.getString(discount_quantity) == "0"
                    {
                        strongSelf.packOfView1.isHidden  = true
                        strongSelf.packOfView2.isHidden  = true
                    }else if String.getString(discount_quantity) != "0"{
                        
                        strongSelf.packOfView1.isHidden  = false
                        strongSelf.packOfView2.isHidden  = false
                    }
                  
                    let review = kSharedInstance.getDictionary(product["review"])
                    //print(review)
                    
                     let proData = kSharedInstance.getDictionary(product["data"])
                    
                    let product_image = String.getString(proData["product_image"])
                    strongSelf.imgListArr.insert(product_image, at: 0)
                    
                    let imageArr = kSharedInstance.getArray(product["image"])
                    //print(imageArr.count)
                    if imageArr.count == 1
                    {
                        let dictData = kSharedInstance.getDictionary(imageArr[0])
                        let img = String.getString(dictData["image_url"])
                        strongSelf.imgListArr.insert(img, at: 1)
                    }else if imageArr.count > 1{
                        for indx in 1...imageArr.count - 1
                        {
                            let dictData = kSharedInstance.getDictionary(imageArr[indx])
                            let img = String.getString(dictData["image_url"])
                            strongSelf.imgListArr.insert(img, at: indx)
                        }
                    }
                    strongSelf.relatedProduct = kSharedInstance.getArray(result["relatedProductData"])
                    strongSelf.recentlyPurchasedData = kSharedInstance.getArray(result["recentlyPurchasedData"])
                    
                    strongSelf.productQtyList.removeAll()
                    
                    let product_quantity2 = Int.getInt(strongSelf.data["product_quantity"])
                    
                    if Int.getInt(product_quantity2) != 0
                    {
                        for index in 1...product_quantity2 {
                       strongSelf.productQtyList.append(String.getString(index))
                           
                       }
                    }
                    
                    strongSelf.upperCollectionView.reloadData()
                    strongSelf.buttomCollectionView.reloadData()
                    
                    if strongSelf.imgListArr.count != 0
                    {
                       // let dict = kSharedInstance.getDictionary(imageArr[0])
                        
                        let img = strongSelf.imgListArr[0]
                        
                        let replacedURL = img.replacingOccurrences(of: ".jpg", with: "-1100x1100.jpg")
                        
                        let imageUrl = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL)
                        //print(imageUrl)
                        guard let urlBrand = URL.init(string: imageUrl) else { return }
                        
                        strongSelf.imgView.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
                        
                        
                        if strongSelf.imgListArr.count == 1
                        {
                            strongSelf.indexBtn2.isEnabled = false
                            
                            strongSelf.indexBtn3.isEnabled = false
                            
                        //    let dict1 = kSharedInstance.getDictionary(strongSelf.imgListArr[0])
                            let img1 = strongSelf.imgListArr[0]
                            //print(img1)
                           // let img1 = String.getString(dict1["image_url"])
                            let replacedURL1 = img1.replacingOccurrences(of: ".jpg", with: "-60x80.jpg")
                            let imageUrl1 = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL1)
                            guard let urlBrand1 = URL.init(string: imageUrl1) else { return }
                            strongSelf.img1.af_setImage(withURL: urlBrand1, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
                            
                            
                            
                        }else if strongSelf.imgListArr.count == 2
                        {
                            strongSelf.indexBtn2.isEnabled = true
                            
                            strongSelf.indexBtn3.isEnabled = false
                            
                          //  let dict1 = kSharedInstance.getDictionary(imageArr[0])
                            
                          //  let dict2 = kSharedInstance.getDictionary(imageArr[1])
                            
                            let img1 = strongSelf.imgListArr[0]
                            
                            let replacedURL1 = img1.replacingOccurrences(of: ".jpg", with: "-60x80.jpg")
                            
                            let imageUrl1 = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL1)
                            
                            guard let urlBrand1 = URL.init(string: imageUrl1) else { return }
                            strongSelf.img1.af_setImage(withURL: urlBrand1, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
                            
                            let img2 = strongSelf.imgListArr[1]
                            
                            let replacedURL2 = img2.replacingOccurrences(of: ".jpg", with: "-60x80.jpg")
                            
                            let imageUrl2 = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL2)
                            //print(imageUrl2)
                            guard let urlBrand2 = URL.init(string: imageUrl2) else { return }
                            strongSelf.img2.af_setImage(withURL: urlBrand2, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
                            
                            
                            
                        }else if strongSelf.imgListArr.count > 2
                        {
                            strongSelf.indexBtn2.isEnabled = true
                            
                            strongSelf.indexBtn3.isEnabled = true
                            
//                            let dict1 = kSharedInstance.getDictionary(imageArr[0])
//
//                            let dict2 = kSharedInstance.getDictionary(imageArr[1])
//
//                            let dict3 = kSharedInstance.getDictionary(imageArr[2])
                            
                            let img1 = strongSelf.imgListArr[0]
                            
                            
                            let replacedURL1 = img1.replacingOccurrences(of: ".jpg", with: "-60x80.jpg")
                            
                            let imageUrl1 = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL1)
                            guard let urlBrand1 = URL.init(string: imageUrl1) else { return }
                            strongSelf.img1.af_setImage(withURL: urlBrand1, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
                            
                            
                            
                            let img2 = strongSelf.imgListArr[1]
                            
                            let replacedURL2 = img2.replacingOccurrences(of: ".jpg", with: "-60x80.jpg")
                            
                            let imageUrl2 = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL2)
                            guard let urlBrand2 = URL.init(string: imageUrl2) else { return }
                            strongSelf.img2.af_setImage(withURL: urlBrand2, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
                            
                            
                            let img3 = strongSelf.imgListArr[2]
                            
                            let replacedURL3 = img3.replacingOccurrences(of: ".jpg", with: "-60x80.jpg")
                            
                            let imageUrl3 = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL3)
                            guard let urlBrand3 = URL.init(string: imageUrl3) else { return }
                            strongSelf.img3.af_setImage(withURL: urlBrand3, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
                            
                        }
                        
                    }
                    
                    
                }else{
                    strongSelf.imgViewNoDataFound.isHidden = false
                    strongSelf.imgViewNoDataFound.isHighlighted = true
                    strongSelf.imgViewNoDataFound.isUserInteractionEnabled = false
                    strongSelf.imgViewNoDataFound.image = #imageLiteral(resourceName: "datanotfound")
                strongSelf.view.makeToast(String.getString(dictResponse[kMessage]), duration: 1.5, position: .center)
                 //   strongSelf.showOkAlert(withMessage: String.getString(dictResponse[kMessage]))
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
    
    //#MARK:---------callketProductDetailsWebService------
        
        private func callGetProductDetailsWebService2(withProgressHUD progressHUD : Bool)
        {
            let dictImg:[String : Any] = ["image" : UIImage(),
                                          "imageName" : "uploaded_file"]
            TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetProductOtherDetails, requestMethod: .post, requestImages: [dictImg], withProgressHUD: progressHUD, withProgessHUDTitle: "Please Wait...", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                guard let strongSelf = self else { return }
                if errorType == .requestSuccess
                {
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    let dictResponse = kSharedInstance.getDictionary(response)
                    
                    strongSelf.bgImageView.removeFromSuperview()
                    strongSelf.shimmerImageView.removeFromSuperview()
                    if Int.getInt(dictResponse["success"]) == 1
                    {
                        
                        strongSelf.reviewDataList.removeAll()
                        strongSelf.imgViewNoDataFound.isHidden = true
                        strongSelf.activity.stopAnimating()
                        strongSelf.activity.isHidden = true
                        
                        strongSelf.activity2.stopAnimating()
                        strongSelf.activity2.isHidden = true
                        //activity2
                        
                        let result = kSharedInstance.getDictionary(dictResponse["result"])
                        let product = kSharedInstance.getDictionary(result["product"])
                        strongSelf.askQuestion = kSharedInstance.getArray(product["askQuestion"])
                        let review = kSharedInstance.getDictionary(product["review"])
                        let reviewList = kSharedInstance.getArray(review["data"])
                       
//                        if reviewList.count > 5
//                        {
//                            for i in 0...4
//                            {
//                                let dictData = kSharedInstance.getDictionary(reviewList[i])
//                                strongSelf.reviewDataList.append(dictData)
//                            }
//
//                        }else{
//                            strongSelf.reviewDataList = reviewList
//                        }
                        
                         
                     
                      
                      // let proData = kSharedInstance.getDictionary(product["data"])
                      strongSelf.reviewDataList = kSharedInstance.getArray(review["data"])
                      
                      
                      strongSelf.relatedProduct = kSharedInstance.getArray(result["relatedProductData"])
                      strongSelf.recentlyPurchasedData = kSharedInstance.getArray(result["recentlyPurchasedData"])
                        
                        strongSelf.upperCollectionView.reloadData()
                        strongSelf.buttomCollectionView.reloadData()
                        
                      
                        
                        
                    }else{
                        strongSelf.imgViewNoDataFound.isHidden = false
                        strongSelf.imgViewNoDataFound.isHighlighted = true
                        strongSelf.imgViewNoDataFound.isUserInteractionEnabled = false
                        strongSelf.imgViewNoDataFound.image = #imageLiteral(resourceName: "datanotfound")
                    strongSelf.view.makeToast(String.getString(dictResponse[kMessage]), duration: 1.5, position: .center)
                     //   strongSelf.showOkAlert(withMessage: String.getString(dictResponse[kMessage]))
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
    
    
      
    
    //#MARK:---------callCheckOnlyPincodeWebService------
    
    private func callCheckOnlyPincodeWebService()
    {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kCheckOnlyPincode, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParamsPin, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    
                      let postcodCheckMessage = String.getString(result["postcodCheckMessage"])
                    
                    
                    strongSelf.showOkAlert(withMessage: postcodCheckMessage)
                
                    //strongSelf.lblCheckPincode.text = String.getString(result["postcodCheckMessage"])
                    
                    
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
    
     private func callGetProductDetailsWebService1(withProgressHUD progressHUD : Bool)
     {
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetProductDataDetails, requestMethod: .post, requestImages: [dictImg], withProgressHUD: progressHUD, withProgessHUDTitle: "Please Wait...", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                strongSelf.bgImageView.removeFromSuperview()
                strongSelf.shimmerImageView.removeFromSuperview()
                strongSelf.tblProdDetail.isHidden    = false
                strongSelf.lblMainScreen.isHidden    = false
                if Int.getInt(dictResponse["success"]) == 1
                {
                  strongSelf.callGetProductDetailsWebService2(withProgressHUD: false)
                    strongSelf.activity.isHidden = false
                    strongSelf.activity.startAnimating()
                    
                    strongSelf.activity2.isHidden = false
                    strongSelf.activity2.startAnimating()

                    strongSelf.bottomView.isHidden = false
                    strongSelf.imgListArr.removeAll()
                    strongSelf.imgViewNoDataFound.isHidden = true
                    
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    
                  let staticContentData =   kSharedInstance.getArray(result["staticContentData"])
                    
                    if staticContentData.count != 0
                    {
                        strongSelf.staticContent = staticContentData
                    }
                    strongSelf.tblOffer.reloadData()
                    //print(result)
                    strongSelf.dictData = kSharedInstance.getDictionary(dictResponse["result"])
                    strongSelf.showData(withDictData: result)//showData2
                    strongSelf.showData2(withDictData: result)

                    let product = kSharedInstance.getDictionary(result["product"])
                    
                    let prodData = kSharedInstance.getDictionary(product["data"])
                    //print(prodData)
                    let seo_url = String.getString(prodData["seo_url"])
                   
                    
                    strongSelf.seoUrl = seo_url
                    
                    
                    let product_description = String.getString(prodData["product_description"])
//                     //print(prodData)
//                     //print(product_description)
                     strongSelf.prodDecs = String.getString(prodData["product_description"])
                    
                     strongSelf.topCollectionV.reloadData()
                    //print(prodData)
                    
                    let review = kSharedInstance.getDictionary(product["review"])
                    
                    //print(review)
                            
                    let count = String.getString(review["count"])
                    
                    let average = String.getString(review["average"])
                    
                    
                    
                    if Int.getInt(count) == 0
                    {
                        strongSelf.starView.isHidden   = true
                        strongSelf.lblAvgRating.text   = ""
                        strongSelf.lblRatingCount.text = ""
                        strongSelf.btnRating.isHidden  = true
                        
                        
                    }else{
                        
                        strongSelf.btnRating.isHidden  = false
                        strongSelf.starView.isHidden   = false
                        
                        
                        strongSelf.lblAvgRating.text   = average
                        strongSelf.lblRatingCount.text = "\(count) ratings"
                        strongSelf.btnRating.setTitle("\(count) ratings", for: .normal)
                       // self.btnRating.titleLabel?.textColor = .clear
                    }
                    
                // let product = kSharedInstance.getDictionary(result["product"])
                    
                    strongSelf.data = kSharedInstance.getDictionary(product["data"])
                    
                    let product_quantity = String.getString(prodData["product_quantity"])
                        
                     //print(product_quantity)
                    

                    
                         
                    if Int.getInt(product_quantity) != 0
                         {
                             strongSelf.qtyView.isHidden = false
                             strongSelf.qtyView2.isHidden = false
                            
                            strongSelf.lblQtyTitle.isHidden = false
                            
                            strongSelf.lblQtyTitle2.isHidden = false
                            
                             strongSelf.btnAddCart.setTitle("Add to Cart", for: .normal)
                             strongSelf.btnAddCart.backgroundColor = UIColor(red: 254.0/255.0, green: 85.0/255.0, blue: 22.0/255.0, alpha: 1.0)
                         }else{
                             
                             strongSelf.qtyView.isHidden = true
                             strongSelf.qtyView2.isHidden = true
                        
                             strongSelf.lblQtyTitle.isHidden = true
                                                  
                            strongSelf.lblQtyTitle2.isHidden = true
                        
                              strongSelf.btnAddCart.setTitle("Notify Me", for: .normal)
                              strongSelf.btnAddCart.backgroundColor = UIColor(red: 176.0/255.0, green: 223.0/255.0, blue: 229.0/255.0, alpha: 1.0)
                         }
                    
                    let discount_quantity = String.getString(prodData["discount_quantity"])
                    
                    strongSelf.discount_quantity = discount_quantity
                    
                    strongSelf.product_quantity = String.getString(prodData["product_quantity"])
                    
                    //print(discount_quantity)
                    
                    if String.getString(discount_quantity) == "0"
                    {
                        strongSelf.packOfView1.isHidden  = true
                        strongSelf.packOfView2.isHidden  = true
                    }else if String.getString(discount_quantity) != "0"{
                        
                        strongSelf.packOfView1.isHidden  = false
                        strongSelf.packOfView2.isHidden  = false
                    }
                  let proData = kSharedInstance.getDictionary(product["data"])
                    let product_image = String.getString(proData["product_image"])
                    strongSelf.imgListArr.insert(product_image, at: 0)
                    
                    let imageArr = kSharedInstance.getArray(product["image"])
                    //print(imageArr.count)
                    if imageArr.count == 1
                    {
                        let dictData = kSharedInstance.getDictionary(imageArr[0])
                        let img = String.getString(dictData["image_url"])
                        strongSelf.imgListArr.insert(img, at: 1)
                    }else if imageArr.count > 1{
                        for indx in 1...imageArr.count - 1
                        {
                            let dictData = kSharedInstance.getDictionary(imageArr[indx])
                            let img = String.getString(dictData["image_url"])
                            strongSelf.imgListArr.insert(img, at: indx)
                        }
                    }
                   
                    //Second Api data
                    
                    
                    strongSelf.productQtyList.removeAll()
                    
                    let product_quantity2 = Int.getInt(strongSelf.data["product_quantity"])
                    
                    if Int.getInt(product_quantity2) != 0
                    {
                        for index in 1...product_quantity2 {
                       strongSelf.productQtyList.append(String.getString(index))
                           
                       }
                    }
                    
                    strongSelf.upperCollectionView.reloadData()
                    strongSelf.buttomCollectionView.reloadData()
                    
                    if strongSelf.imgListArr.count != 0
                    {
                       // let dict = kSharedInstance.getDictionary(imageArr[0])
                        
                        let img = strongSelf.imgListArr[0]
                        
                        let replacedURL = img.replacingOccurrences(of: ".jpg", with: "-1100x1100.jpg")
                        
                        let imageUrl = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL)
                        //print(imageUrl)
                        guard let urlBrand = URL.init(string: imageUrl) else { return }
                        
                        strongSelf.imgView.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
                        
                        if strongSelf.imgListArr.count > 1
                        {
                            strongSelf.topImgIconView.isHidden = false
                        }else{
                            strongSelf.topImgIconView.isHidden = true
                        }
                        
                        if strongSelf.imgListArr.count == 1
                        {
                            strongSelf.indexBtn2.isEnabled = false
                            
                            strongSelf.indexBtn3.isEnabled = false
                            
                        //    let dict1 = kSharedInstance.getDictionary(strongSelf.imgListArr[0])
                            let img1 = strongSelf.imgListArr[0]
                            //print(img1)
                           // let img1 = String.getString(dict1["image_url"])
                            let replacedURL1 = img1.replacingOccurrences(of: ".jpg", with: "-60x80.jpg")
                            let imageUrl1 = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL1)
                            guard let urlBrand1 = URL.init(string: imageUrl1) else { return }
                            strongSelf.img1.af_setImage(withURL: urlBrand1, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
                            
                            
                            
                        }else if strongSelf.imgListArr.count == 2
                        {
                            strongSelf.indexBtn2.isEnabled = true
                            
                            strongSelf.indexBtn3.isEnabled = false
                            
                          //  let dict1 = kSharedInstance.getDictionary(imageArr[0])
                            
                          //  let dict2 = kSharedInstance.getDictionary(imageArr[1])
                            
                            let img1 = strongSelf.imgListArr[0]
                            
                            let replacedURL1 = img1.replacingOccurrences(of: ".jpg", with: "-60x80.jpg")
                            
                            let imageUrl1 = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL1)
                            
                            guard let urlBrand1 = URL.init(string: imageUrl1) else { return }
                            strongSelf.img1.af_setImage(withURL: urlBrand1, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
                            
                            let img2 = strongSelf.imgListArr[1]
                            
                            let replacedURL2 = img2.replacingOccurrences(of: ".jpg", with: "-60x80.jpg")
                            
                            let imageUrl2 = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL2)
                            //print(imageUrl2)
                            guard let urlBrand2 = URL.init(string: imageUrl2) else { return }
                            strongSelf.img2.af_setImage(withURL: urlBrand2, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
                            
                            
                            
                        }else if strongSelf.imgListArr.count > 2
                        {
                            strongSelf.indexBtn2.isEnabled = true
                            
                            strongSelf.indexBtn3.isEnabled = true
                            
//                            let dict1 = kSharedInstance.getDictionary(imageArr[0])
//
//                            let dict2 = kSharedInstance.getDictionary(imageArr[1])
//
//                            let dict3 = kSharedInstance.getDictionary(imageArr[2])
                            
                            let img1 = strongSelf.imgListArr[0]
                            
                            
                            let replacedURL1 = img1.replacingOccurrences(of: ".jpg", with: "-60x80.jpg")
                            
                            let imageUrl1 = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL1)
                            guard let urlBrand1 = URL.init(string: imageUrl1) else { return }
                            strongSelf.img1.af_setImage(withURL: urlBrand1, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
                            
                            
                            
                            let img2 = strongSelf.imgListArr[1]
                            
                            let replacedURL2 = img2.replacingOccurrences(of: ".jpg", with: "-60x80.jpg")
                            
                            let imageUrl2 = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL2)
                            guard let urlBrand2 = URL.init(string: imageUrl2) else { return }
                            strongSelf.img2.af_setImage(withURL: urlBrand2, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
                            
                            
                            let img3 = strongSelf.imgListArr[2]
                            
                            let replacedURL3 = img3.replacingOccurrences(of: ".jpg", with: "-60x80.jpg")
                            
                            let imageUrl3 = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL3)
                            guard let urlBrand3 = URL.init(string: imageUrl3) else { return }
                            strongSelf.img3.af_setImage(withURL: urlBrand3, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
                            
                        }
                        
                    }
                    
                    
                    
                }else{
                    strongSelf.imgViewNoDataFound.isHidden = false
                    strongSelf.imgViewNoDataFound.isHighlighted = true
                    strongSelf.imgViewNoDataFound.isUserInteractionEnabled = false
                    strongSelf.imgViewNoDataFound.image = #imageLiteral(resourceName: "datanotfound")
                strongSelf.view.makeToast(String.getString(dictResponse[kMessage]), duration: 1.5, position: .center)
                 //   strongSelf.showOkAlert(withMessage: String.getString(dictResponse[kMessage]))
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
            
    
   
    
    
    func showData(withDictData dictData : Dictionary<String,Any>)
    {
        //print(dictData)
        let offerText = kSharedInstance.getDictionary(dictData["offerText"])
        
        let content = String.getString(offerText["content"])
        
//        if String.getLength(content) != 0
//        {
//            //self.lblOffer.text = content
//            self.lblOffer.font = UIFont(name: "Poppins-Regular", size: 12)
//            
//        }else{
//            
//            //self.lblOffer.text = "Gaurashtra"
//            self.lblOffer.font = UIFont(name: "Poppins-Bold", size: 15)
//        }
        
        let product = kSharedInstance.getDictionary(dictData["product"])
        
        
        
        let productData = kSharedInstance.getDictionary(product["data"])
        
        //print(productData)
        
        self.lblHeader.text = String.getString(productData["product_name"])
        
        let imageArr = kSharedInstance.getArray(product["image"])
        
        if imageArr.count > 1
        {
            let dict1 = kSharedInstance.getDictionary(imageArr[0])
            
            let img1 = String.getString(dict1["image_url"])
            
            
            let replacedURL = img1.replacingOccurrences(of: ".jpg", with: "-60x80.jpg")
            
            let imageUrl = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL)
            
            guard let urlBrand = URL.init(string: imageUrl) else { return }
            
            self.img1.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
            
            
        }else if imageArr.count > 2
        {
            
            
            let dict1 = kSharedInstance.getDictionary(imageArr[0])
            
            let dict2 = kSharedInstance.getDictionary(imageArr[1])
            
            
            
            
            let img1 = String.getString(dict1["image_url"])
            
            
            let replacedURL = img1.replacingOccurrences(of: ".jpg", with: "-60x80.jpg")
            
            let imageUrl = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL)
            guard let urlBrand = URL.init(string: imageUrl) else { return }
            self.img1.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
            
            //print(imageUrl)
            
            let img2 = String.getString(dict2["image_url"])
            
            let replacedURL2 = img2.replacingOccurrences(of: ".jpg", with: "-60x80.jpg")
            
            let imageUrl2 = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL2)
            
            //print(imageUrl2)
            
            guard let urlBrand2 = URL.init(string: imageUrl2) else { return }
            self.img2.af_setImage(withURL: urlBrand2, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
            
        }else if imageArr.count > 3
        {
            
            let dict1 = kSharedInstance.getDictionary(imageArr[0])
            
            let dict2 = kSharedInstance.getDictionary(imageArr[1])
            
            let dict3 = kSharedInstance.getDictionary(imageArr[2])
            
            let img1 = String.getString(dict1["image_url"])
            
            
            let replacedURL = img1.replacingOccurrences(of: ".jpg", with: "-60x80.jpg")
            
            let imageUrl = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL)
            guard let urlBrand = URL.init(string: imageUrl) else { return }
            self.img1.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
            
            
            
            let img2 = String.getString(dict2["image_url"])
            
            let replacedURL2 = img2.replacingOccurrences(of: ".jpg", with: "-60x80.jpg")
            
            let imageUrl2 = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL2)
            guard let urlBrand2 = URL.init(string: imageUrl2) else { return }
            self.img2.af_setImage(withURL: urlBrand2, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
            
            
            let img3 = String.getString(dict3["image_url"])
            
            let replacedURL3 = img3.replacingOccurrences(of: ".jpg", with: "-60x80.jpg")
            
            let imageUrl3 = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL3)
            guard let urlBrand3 = URL.init(string: imageUrl3) else { return }
            self.img3.af_setImage(withURL: urlBrand3, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
            
        }
        
        
        let staticContentData = kSharedInstance.getArray(dictData["staticContentData"])
               
              // for i in 0...staticContentData.count - 1
//               {
//                   if i == 0
//                   {
//                       let dict1 = kSharedInstance.getDictionary(staticContentData[0])
//
//                       let title1 = String.getString(dict1["title"])
//
//                       let content1 = String.getString(dict1["content"])
//
//                       let image1 = String.getString(dict1["image"])
//
////                       self.lblTitle1.text   = title1
////                       self.lblContent1.text = content1
//
//                     //  guard let urlBrand = URL.init(string: image1) else { return }
//                      // self.imgViewContent1.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "fast-shipping"))
//                   }else if i == 1
//                   {
//                       let dict2 = kSharedInstance.getDictionary(staticContentData[1])
//
//                       let title2 = String.getString(dict2["title"])
//
//                       let content2 = String.getString(dict2["content"])
//
//                       let image2 = String.getString(dict2["image"])
//
//                       self.lblTitle2.text   = title2
//                       self.lblContent2.text = content2
//
//                       guard let urlBrand = URL.init(string: image2) else { return }
//                       self.imgViewContent2.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "fast-shipping"))
//
//                   }else if i == 2
//                   {
//
//                       let dict3 = kSharedInstance.getDictionary(staticContentData[2])
//
//                       let title3 = String.getString(dict3["title"])
//
//                       let content3 = String.getString(dict3["content"])
//
//                       let image3 = String.getString(dict3["image"])
//
//                       self.lblTitle3.text   = title3
//                       self.lblContent3.text = content3
//
//                       guard let urlBrand = URL.init(string: image3) else { return }
//                       self.imgViewContent3.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "fast-shipping"))
//                   }
//
//               }
        
        
        
        
        //changehere 555555
        
       
        
    }
    
    func showData2(withDictData dictData : Dictionary<String,Any>)
          {
           let product = kSharedInstance.getDictionary(dictData["product"])
           
           
           let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                  let value              = CurrencyDataModel.getCurrencySavedDetails().value
                  let currecyDoubleValue = Double.getDouble(value)
                         
                  
           
                 let productData = kSharedInstance.getDictionary(product["data"])
                  
                  let product_price = String.getString(productData["product_price"])
                  
                  let special_price = String.getString(productData["special_price"])
                  
                  let price = Double.getDouble(product_price)*currecyDoubleValue
                  
                  let specialPrice = Double.getDouble(special_price)*currecyDoubleValue
                  
           
                  let tax_rate      = Double.getDouble(productData["tax_rate"])
           
                //print("SunishTaxrate:\(dictData)")
           
                  let priceRate     = Double(round(100*((price*tax_rate)/100))/100)
                 
                 let specialPriceRate = Double(round(100*((specialPrice*tax_rate)/100))/100)
                 // let specialPriceFlt = Double(round(100*specialPrice)/100) +
                 
                  
                  //print("Sunish1:\(priceRate)")
                  //print("Sunish2:\(price)")
                  
                  let priceFloat    = Double(round(100*price)/100) + priceRate
                  
                  let dicountedAmt = price - specialPrice
                  
                  let disountedPec = ( dicountedAmt * 100.00) / price
                  
                 // let priceFloat    = Double(round(100*price)/100)
                  
                  let specialPriceFlt = Double(round(100*specialPrice)/100) + specialPriceRate
                  
                  self.lblProdPrice.text =  "\(symbol)\(priceFloat)"
                  self.lblPrice.text     =  "\(symbol)\(priceFloat)"
                  
                  self.lblProdPriceLine.text = "\(symbol)\(priceFloat)"
                  let per = Double(round(100*disountedPec)/100)
                  
        self.lblProdName.text = String.getString(productData["product_name"]).replacingOccurrences(of: "&amp;", with: "")
                  self.lblBrandName.text =  String.getString(productData["brand_name"])
                  
                  let product_quantity = Int.getInt(productData["product_quantity"])
        
                  
                  let addedWishlist = String.getString(productData["addedWishlist"])
                  
                  if addedWishlist == "Y"
                  {
                      self.imgWishList.image = #imageLiteral(resourceName: "addedWishlist")
                  }else{
                      
                      self.imgWishList.image = #imageLiteral(resourceName: "blackHeart")
                  }
                  
                  if product_quantity > 0
                  {
                      self.lblAvailability.text = "In Stock"
                  } else if product_quantity == 0 {
                      
                      self.lblAvailability.text = "Out of Stock"
                  }
                  
                  
                  if special_price == "0.0000"
                  {
                      self.lblProdPriceLine.isHidden       = true
                      self.lblSpecialPrice.isHidden        = true
                      self.lblPercentageOff.isHidden       = true
                      self.lblProdPrice.isHidden           = true
                      self.lblPrice.isHidden               = false
                      
                  }else  if special_price != "0.0000"{
                      
                      self.lblProdPriceLine.isHidden       = false
                      self.lblSpecialPrice.isHidden        = false
                      self.lblPercentageOff.isHidden       = false
                      self.lblProdPrice.isHidden           = false
                      self.lblPrice.isHidden               = true
                      
                      self.lblPercentageOff.text  = "\(per)%"
                      self.lblSpecialPrice.text   = "\(symbol)\(specialPriceFlt)"
                      
                  }
                  
           
       }
       
    
    
    private func callAddCardProdctsListVCWebServices()
    {
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kManageCart, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParamsAddCart, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    //print(result)
                    let cartArrData = kSharedInstance.getArray(result["cartData"])
                    
                    //print(cartArrData.count)
                    
                    strongSelf.showCartCount(withCartCount: "\(cartArrData.count)")
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
    
    func askQuestionVC()
    {
        
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        let nextVc = sb.instantiateViewController(withIdentifier: AskQuestionViewController.storyboardId()) as! AskQuestionViewController
        
        nextVc.productid = self.product_id
        
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        // transition.subtype = CATransitionSubtype.fromBottom
        transition.subtype = CATransitionSubtype.fromTop
        self.navigationController!.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(nextVc, animated: false)
    }
    
    func productDetailsSelfVC(withProductId prodId : String,option_value_id : String)
    {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextVC = sb.instantiateViewController(withIdentifier: ProductDetailsViewController.storyboardId()) as! ProductDetailsViewController
        if String.getLength(option_value_id) != 0
        {
            nextVC.option_value_id = option_value_id
        }
        nextVC.product_id  = prodId
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    func categoryDetailVC2(withserviceName serviceName : String, HeaderTitle title: String, withId id : Int , brandId : String)
    {
        
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextViewController = sb.instantiateViewController(withIdentifier: CategoryDetailVC.storyboardId()) as! CategoryDetailVC
        
        nextViewController.headerTitle = title
        nextViewController.serviceName = serviceName
        nextViewController.idNo        = id
        nextViewController.brandId     = brandId
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

  
        
}
////#MARK:  UITableViewDelegate,UITableViewDataSource 
//extension ProductDetailsViewController : UITableViewDelegate,UITableViewDataSource
//{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.staticContent.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tblOffer.dequeueReusableCell(withIdentifier: OffersShowTVC.cellIdentifier(), for: indexPath) as! OffersShowTVC
//
//        cell.configureCell(withDictData: kSharedInstance.getDictionary(self.staticContent[indexPath.row]), forIndxPath: indexPath)
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //self.brandDetailVC()
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 90.0
//    }
//
//
////    func brandDetailVC()
////    {
////        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
////
////        let nextViewController = sb.instantiateViewController(withIdentifier: BrandDetailVC.storyboardId()) as! BrandDetailVC
////
////        self.navigationController?.pushViewController(nextViewController, animated: true)
////    }
//
//}
//
