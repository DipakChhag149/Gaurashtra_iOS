//
//  HomeViewController.swift
//  Gaurashtra
//
//  Created by abc on 24/09/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit
import SWRevealViewController
import Toast_Swift



class ProductListViewController: GaurashtraBaseVC {
   
    
    let gradientLayer = CAGradientLayer()
    let bgImageView = UIImageView(image: #imageLiteral(resourceName: "graybox2"))
    let shimmerImageView = UIImageView(image: #imageLiteral(resourceName: "gaybox1"))
    
    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var imgViewNoDataFound: UIImageView!
   
    @IBOutlet weak var lblHeader: UILabel!
    
   // var imgArr3 =  [#imageLiteral(resourceName: "p1"),#imageLiteral(resourceName: "p2"),#imageLiteral(resourceName: "p3"),#imageLiteral(resourceName: "p4"), #imageLiteral(resourceName: "p1"),#imageLiteral(resourceName: "p2"),#imageLiteral(resourceName: "p3"),#imageLiteral(resourceName: "p4")]
//    var dictData : Dictionary<String,Any> = ["":""]
//
//    var subCatData : [Any] = []
//
//    var catId   : String = ""
//    var catName : String = ""
    
    var dictData : Dictionary<String,Any> = ["":""]
    var productData : [Any]  = []
    var subCatData  : [Any]  = []
    var catId       : String = ""
    var catName     : String = ""
    
    var productQtyList : [String] = []
    
     var countStrArr : [String] = []
    
    var data : Dictionary<String,Any> = ["":""]
    
    var selectedQty : String = ""

    
    private var dictParams = [kUserId      : "",
                              kCatid       : "",
                              kPageNo      : "",
                              kPerpageData : ""]
    
    private var dictParamsAddCart =     [kUserId        : "",
                                         kQuantity      : "",
                                         kProductId     : "",
                                         kActiontype    : "",
                                         kOptionid      : "",
                                         kOptionvalueid : "",
                                         kCouponCode    : "",
                                         kCurrencyCode  : "",
                                         kCurrencyValue : ""]
    
    
    
    @IBOutlet weak var productListTbl: UITableView!
    
    
    
    @IBOutlet weak var subCatViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var collectionV: UICollectionView!
    
    //var mainProducts = ["All","Hair Oil","Hair & Care","Hair & Care","Hair & Care","Shampoo","Hair Oil","Hair & Care","Hair & Care","Hair & Care"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDevice()
        self.selectedQty = "1"

        self.registerNib()
        
        self.productListTbl.isHidden = true
        self.topView.isHidden        = true
        
        self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
       //kPageNo kPerpageData

        self.dictParams[kCatid] = String.getString(catId)
        self.dictParams[kPageNo]      = "1"
        self.dictParams[kPerpageData] = "1500"
        

        self.productData.removeAll()
        
        if isInternetAvailable()
        {
            
            self.callGetCategoryProductListWebService(withProgressHUD: false)
            kSharedInstance.setupShimmeringImage(withView: self.view, backGrroundImgV: bgImageView, shimmerImageView: shimmerImageView)
        }else{
            
            showOkAlert(withMessage: kNetworkErrorAlert)
        }
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imgViewNoDataFound.isHidden = false
        
    }
    private func registerNib() -> Void
    {
        let nibCards = UINib(nibName: ProductListCVC.identifier(), bundle: nil)
        self.collectionV.register(nibCards, forCellWithReuseIdentifier: ProductListCVC.identifier())
    }
    
//    fileprivate func setupShimmeringImage() {
//
//        bgImageView.contentMode = .scaleAspectFill
//        // bgImageView.frame = view.frame
//
//        bgImageView.frame = CGRect(x: 0, y: 64, width: Int(kScreenWidth), height: Int(kScreenHeight))
//
//        shimmerImageView.contentMode = .scaleAspectFill
//        // shimmerImageView.frame = view.frame
//
//        // shimmerImageView.frame = CGRect(x: 0, y: 64, width: Int(kScreenWidth), height: 440)
//
//        shimmerImageView.frame = CGRect(x: 0, y: 64, width: Int(kScreenWidth), height: Int(kScreenHeight))
//
//        view.addSubview(shimmerImageView)
//        view.addSubview(bgImageView)
//
//        // let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [
//            UIColor.clear.cgColor, UIColor.clear.cgColor,
//            UIColor.black.cgColor, UIColor.black.cgColor,
//            UIColor.clear.cgColor, UIColor.clear.cgColor
//        ]
//
//        gradientLayer.locations = [0, 0.2, 0.4, 0.6, 0.8, 1]
//
//        let angle = -60 * CGFloat.pi / 180
//        let rotationTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
//        gradientLayer.transform = rotationTransform
//        view.layer.addSublayer(gradientLayer)
//        gradientLayer.frame = view.frame
//
//        bgImageView.layer.mask = gradientLayer
//
//        gradientLayer.transform = CATransform3DConcat(gradientLayer.transform, CATransform3DMakeScale(3, 3, 0))
//
//        let animation = CABasicAnimation(keyPath: "transform.translation.x")
//        animation.duration = 2
//        animation.repeatCount = Float.infinity
//        animation.autoreverses = false
//        animation.fromValue = -3.0 * view.frame.width
//        animation.toValue = 3.0 * view.frame.width
//        animation.isRemovedOnCompletion = false
//        animation.fillMode = CAMediaTimingFillMode.forwards
//        gradientLayer.add(animation, forKey: "shimmerKey")
//    }
    
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    func getDevice()
    {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136://iphone 5/5S/SE
            self.headerViewConstraintH.constant = 64
            case 1334://iphone 6/6S/7/8
                self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
            self.headerViewConstraintH.constant = 64
            case 2208://iphone 6+/6S+/7+/8+
                self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 18)
            self.headerViewConstraintH.constant = 64
            case 2436://iphone X/XS
                self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 17)
            self.headerViewConstraintH.constant = 84
                //print("iphone XS")
                
            case 2688://iphone XS Max
                self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 18)
            self.headerViewConstraintH.constant = 84
            case 1792://iphone XR
                self.lblHeader.font = UIFont(name: "Poppins-Regular", size: 17)
                self.headerViewConstraintH.constant = 84
                //print("iphone XR")
                
            default: break
                //self.headerConstraintH.constant = 84
            }
        }
    }
    
}

//#MARK:  UITableViewDataSource,UITableViewDelegate 
extension ProductListViewController : UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productListTbl.dequeueReusableCell(withIdentifier: ProductListTVC.cellIdentifier(), for: indexPath) as! ProductListTVC
        cell.configureCellProductListTVC(withDictData: kSharedInstance.getDictionary(productData[indexPath.item]), forIndxPath: indexPath, btnAddCart: {(btnAddCart : UIButton) in
            
            let userId = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
            
            //print(userId)
            
            if String.getLength(userId) != 0
            {
                let dictData = kSharedInstance.getDictionary(self.productData[indexPath.item])
                
                let product_quantity = String.getString(dictData["product_quantity"])
               
                if Int.getInt(product_quantity) != 0
                {
               
                let option_id = String.getString(dictData["option_id"])
                
                if Int.getInt(option_id) != 0
                {
                                   // let dictData = kSharedInstance.getDictionary(self.productData[indexPath.item])
                   let prodid = String.getString(dictData["product_id"])
                   //print(dictData)
                   //print(prodid)

                   let option_id = String.getString(dictData["option_id"])
                   if option_id != "0"
                   {
                       self.productOptionsVC(withProductId: String.getString(dictData["product_id"]))
                   }

                }else{
                     let selectedQty = String.getString(dictData["selectedQty"])
                     let selecteIndex = Int.getInt(dictData["selecteIndex"])
                     let selectetag = Int.getInt(dictData["selectetag"])
                     if selecteIndex == indexPath.row && selectetag == 1
                     {
                         self.dictParamsAddCart[kQuantity] = selectedQty
                     }else{
                         
                         self.dictParamsAddCart[kQuantity] = "1"
                     }
                     self.dictParamsAddCart[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
                     self.dictParamsAddCart[kCurrencyCode] = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
                      self.dictParamsAddCart[kCurrencyValue] = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
                     //kCurrencyCode kCurrencyValue
                     self.dictParamsAddCart[kActiontype] = "add"
                     //kOptionid kOptionvalueid kCouponCode
                     self.dictParamsAddCart[kProductId]  = String.getString(dictData["product_id"])
                   //  let option_id = String.getString(dictData["option_id"])
                     self.dictParamsAddCart[kOptionid]  = String.getString(dictData["option_id"])
                     let option_value_id = String.getString(dictData["option_value_id"])
                     self.dictParamsAddCart[kOptionvalueid]  = String.getString(dictData["option_value_id"])
                    let product_id = String.getString(dictData["product_id"])
                   if String.getLength(product_id) != 0
                   {
                       self.callAddCardProdctsListVCWebServices()
                   }else{
                       
                       self.view.makeToast("Something error...")
                   }
              
                 }
                }else{
                    
                    let dictData = kSharedInstance.getDictionary(self.productData[indexPath.item])
                    
                    //print(dictData)
                    
                    self.notifyMeVC(withProductId: String.getString(dictData["product_id"]))
                    
                }
                  
            }else{
                
                
                self.loginVc()
            }
            
            
          
            
            
        }, btnPackOff: {(btnPackOff : UIButton) in
            
            var dictD = kSharedInstance.getDictionary(self.productData[indexPath.item])
            
            //print(dictD)
            
            let product_quantity = Int.getInt(dictD["product_quantity"])
            if product_quantity != 0
            {
                
                self.productQtyList.removeAll()
                                             
               for index in 1...product_quantity {
                 //product_quantity
                   self.productQtyList.append(String.getString(index))

               }
               
               let picker = RSPickerView.init(view: self.view, arrayList: self.productQtyList, keyValue: nil, handler: { (selectedIndex: NSInteger, response: Any?) in

                   dictD["selecteIndex"] = indexPath.row
                   dictD["selectetag"]   = 1
                   
                   dictD["selectedQty"]  =  self.productQtyList[selectedIndex]
                   
                   

                   self.productData.remove(at: indexPath.row)
                   self.productData.insert(dictD, at: indexPath.row)

                   self.productListTbl.reloadData()

               })
               picker.viewContainer.backgroundColor = kWhiteColor

            }
            
     

       
            
        }, btnView: {(btnView : UIButton) in
            
            let dictData = kSharedInstance.getDictionary(self.productData[indexPath.item])
            let prodid = String.getString(dictData["product_id"])
            //print(dictData)
            //print(prodid)
            
            let option_id = String.getString(dictData["option_id"])
            if option_id != "0"
            {
                self.productOptionsVC(withProductId: String.getString(dictData["product_id"]))
            }
            
            
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dictData = kSharedInstance.getDictionary(productData[indexPath.item])
        
         let prodid = String.getString(dictData["product_id"])
       print("dictDataSunish:\(dictData)")
        if Int.getInt(prodid) != 0
        {
            self.productDetailsProdListVC(withProductId: String.getString(dictData["product_id"]), option_value_id: String.getString(dictData["option_value_id"]))
        }else{
            
            showOkAlert(withMessage: "Notify Me")
        }
        
        
       
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
         let dictData1 = kSharedInstance.getDictionary(self.productData[indexPath.item])
        
        
        
         let prodid = String.getString(dictData1["product_id"])
        
        if Int.getInt(prodid) != 0
        {
             return 140
            
        }else{
            
            return 0
        }
        
        
        // self.productData.remove(at: indexPath.row)
        
        
       
    }
    
    //
    
   
    
    
    //product_id
   private func productDetailsProdListVC(withProductId prodId : String,option_value_id : String)
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
    
//    func selectpackof()
//    {
//
//        let picker = RSPickerView.init(view: self.view, arrayList: self.cityNameList, keyValue: nil, handler: { (selectedIndex: NSInteger, response: Any?) in
//
//
////            self.lblCityName.text = self.cityNameList[selectedIndex]
////
////            let cityId = self.cityIdList[selectedIndex]
////
////
////            self.dictParams[kCityId] = String.getString(cityId)
////
////            self.callGetBusinessTripOffersListWebService()
//
//
//        })
//        picker.viewContainer.backgroundColor = kWhiteColor
//
//    }
//
    

}


//#MARK:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout 
extension ProductListViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
       return subCatData.count
      
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionV.dequeueReusableCell(withReuseIdentifier: ProductListCVC.identifier(), for: indexPath) as! ProductListCVC
        cell.configureCellCatData(withDictData: kSharedInstance.getDictionary(self.subCatData[indexPath.item]), forindxPath: indexPath)
       // collectionV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let dictData = kSharedInstance.getDictionary(self.subCatData[indexPath.item])
        
        self.dictParams[kCatid] = String.getString(dictData["category_id"])
        self.dictParams[kPageNo]      = "1"
        self.dictParams[kPerpageData] = "1500"
        self.callGetCategoryProductListWebService(withProgressHUD: true)
        
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        //name
        
        let dictData = kSharedInstance.getDictionary(subCatData[indexPath.item])
        let wdth = String.getString(dictData["name"])
        
        let replacedWidth = wdth.replacingOccurrences(of: "&amp;", with: "&")
        
        let cellWidth = String.getLength(replacedWidth)
        //print(cellWidth)
        
        var lenthFloat : CGFloat = 0.0
        
        
        if cellWidth <= 5
        {
            
            lenthFloat = CGFloat(cellWidth) * CGFloat(cellWidth) + 40.0
            
        }else if cellWidth >= 6 && cellWidth <= 10
        {
            
            lenthFloat = CGFloat(cellWidth) * CGFloat(cellWidth) + 30.0
            
        }else if cellWidth >= 11 && cellWidth <= 14{
            
            lenthFloat = CGFloat(cellWidth) + 110
            
            
        }else if cellWidth >= 15 && cellWidth <= 20
        {
            //              lenthFloat = CGFloat(cellWidth) * CGFloat(cellWidth) - 120
            
            lenthFloat = CGFloat(cellWidth) + 120
            
            
        }else if cellWidth >= 21 && cellWidth <= 25
        {
            lenthFloat = CGFloat(cellWidth) + 180
            
            
        }else if cellWidth >= 26 && cellWidth <= 30
        {
            //            lenthFloat = CGFloat(cellWidth) * CGFloat(cellWidth) - 180
            
            lenthFloat = CGFloat(cellWidth) + 200
            
        }else if cellWidth >= 31 && cellWidth <= 35
        {
            //            lenthFloat = CGFloat(cellWidth) * CGFloat(cellWidth) - 200
            
            lenthFloat = CGFloat(cellWidth)  + 220
            
        }else if cellWidth >= 31 && cellWidth <= 35
        {
            //            lenthFloat = CGFloat(cellWidth) * CGFloat(cellWidth) - 200
            
            lenthFloat = CGFloat(cellWidth)  + 250
            
        }else if cellWidth >= 36 && cellWidth <= 40
        {
            //            lenthFloat = CGFloat(cellWidth) * CGFloat(cellWidth) - 200
            
            lenthFloat = CGFloat(cellWidth)  + 300
            
        }else if cellWidth >= 41 && cellWidth <= 45
        {
            //            lenthFloat = CGFloat(cellWidth) * CGFloat(cellWidth) - 200
            
            lenthFloat = CGFloat(cellWidth)  + 350
            
        }else if cellWidth >= 46 && cellWidth <= 50
        {
            //            lenthFloat = CGFloat(cellWidth) * CGFloat(cellWidth) - 200
            
            lenthFloat = CGFloat(cellWidth)  + 400
            
        }else if cellWidth >= 51 && cellWidth <= 60
        {
            //            lenthFloat = CGFloat(cellWidth) * CGFloat(cellWidth) - 200
            
            lenthFloat = CGFloat(cellWidth)  + 450
            
        }else{
            
            lenthFloat = CGFloat(cellWidth) + 500
        }
        
        let width = (lenthFloat * kScreenWidth) / 320
        // let hight = (130.0 * kScreenWidth) / 320
        
        return CGSize(width: width, height: 39.0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        
        return  8
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        //top //left //bottom // right
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
                    let cartArrData = kSharedInstance.getArray(result["cartData"])
                    
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
    

    
    
    //#MARK:-----------callLoginWebService---------
    private func callGetCategoryProductListWebService(withProgressHUD progressHUD : Bool)
    {
        
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetCategoryProductList, requestMethod: .post, requestImages: [dictImg], withProgressHUD: progressHUD, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                strongSelf.bgImageView.removeFromSuperview()
                strongSelf.shimmerImageView.removeFromSuperview()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
               strongSelf.productData.removeAll()
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    strongSelf.imgViewNoDataFound.isHidden = true
                    strongSelf.productListTbl.isHidden = false
                    strongSelf.topView.isHidden        = false
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    //print(result)
                    let cateProductList = kSharedInstance.getDictionary(result["cateProductList"])
                    let mainCat = kSharedInstance.getDictionary(cateProductList["mainCat"])
                    strongSelf.lblHeader.text = String.getString(mainCat["name"])
                    strongSelf.productData = kSharedInstance.getArray(cateProductList["productData"])
                    strongSelf.subCatData = kSharedInstance.getArray(cateProductList["subCatData"])
                   let subCatData  = kSharedInstance.getArray(cateProductList["subCatData"])
                    if subCatData.count == 0
                    {
                        strongSelf.subCatViewHeight.constant = 0
                    }else{
                        strongSelf.subCatViewHeight.constant = 55
                    }
                    //print(result)
                //strongSelf.view.makeToast(String.getString(dictResponse[kMessage]), duration: 1.5, position: .center)
                    strongSelf.collectionV.reloadData()
                    strongSelf.productListTbl.reloadData()
                }else{
                    strongSelf.imgViewNoDataFound.isHidden = false
                    strongSelf.imgViewNoDataFound.image    = #imageLiteral(resourceName: "datanotfound")
                    strongSelf.productListTbl.isHidden = true
                    strongSelf.topView.isHidden        = true
                    strongSelf.view.makeToast(String.getString(dictResponse[kMessage]), duration: 1.5, position: .center)
                    //                    strongSelf.showOkAlert(withMessage: String.getString(dictResponse[kMessage]))
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


