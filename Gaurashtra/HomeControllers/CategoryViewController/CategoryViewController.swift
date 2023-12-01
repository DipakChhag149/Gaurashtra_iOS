//
//  CategoryViewController.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 05/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit
import SWRevealViewController
import Toast_Swift

class CategoryViewController: GaurashtraBaseVC {

    let gradientLayer = CAGradientLayer()
    let bgImageView = UIImageView(image: #imageLiteral(resourceName: "grayline2"))
    let shimmerImageView = UIImageView(image: #imageLiteral(resourceName: "grayline1"))
    
    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    
    @IBOutlet weak var tblCategory: UITableView!
    
    @IBOutlet weak var lblHeader: UILabel!
    
    
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    
    var categoryListArr : [Any] = []
    
    private var dictParamsCurr = [kCode   : ""]
    
    
        var titleStr  : [String] = []
        var codeStr   : [String] = []
        var valueStr  : [String] = []
        var symbolStr : [String] = []
    
    
    private var dictParams = [kUserId: ""]
  
    override func viewDidLoad() {
        super.viewDidLoad()

          self.callGetCurrencyListWebServiceHM()
        
        btnMenu.target = revealViewController()
        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
       
        if isInternetAvailable()
        {
            self.callCategoryListWebService()
            kSharedInstance.setupShimmeringImage(withView: self.view, backGrroundImgV: bgImageView, shimmerImageView: shimmerImageView)
            
        }else{
            
            showOkAlert(withMessage: kNetworkErrorAlert)
            
        }
        
        self.getDevice()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let userId = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
                      
       if String.getLength(userId) == 0
       {
          
          if let tabItems = self.tabBarController?.tabBar.items {
                // In this case we want to modify the badge number of the third tab:
             let tabItem = tabItems[4]

             tabItem.badgeValue = nil
        
                
         }
     }
             
        self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        
        if isInternetAvailable()
        {
          self.callCategoryListWebService()
        
        }else{
            
            showOkAlert(withMessage: kNetworkErrorAlert)
            
        }
        
    }
    
    private func useData(data: String) {
        //print(data)
    }
    
    @IBAction func tapToCurrency(_ sender: UIBarButtonItem) {
        
        
        if codeStr.count != 0
        {
            let picker = RSPickerView.init(view: self.view, arrayList: self.codeStr, keyValue: nil, handler: { (selectedIndex: NSInteger, response: Any?) in
                                    
                                    //fuel_type_id_list fuel_type_name_list
            //                        self.lblHistoryResult.text = kDisplayHistoryResult[selectedIndex]
                
                let codeStr = self.codeStr[selectedIndex]
                
                 self.dictParamsCurr[kCode] = "\(codeStr)"
                
                 self.callGetCurrencyDetailsWebServiceHM()
               
               
                self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
                       
                 let deviceToken = String.getString(kSharedUserDefaults.string(forKey: "deviceToken"))
                                           
                   if String.getLength(deviceToken) != 0
                   {
                       self.dictParams[kDeviceId]   = deviceToken
                       
                   }else{
                       
                       self.dictParams[kDeviceId]   = "yuu75k6j4h3k36k336l3h6l363"
                   }
               
               
               
         
                              
                })
            
                 picker.viewContainer.backgroundColor = kWhiteColor
                    
                }else{
                
                 self.view.makeToast("Loading Please Wait")
                
                }
        
        
        
        
    }
    
    
    
    @IBAction func tapToCarts(_ sender: UIBarButtonItem) {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextViewController = sb.instantiateViewController(withIdentifier: NotificationVC.storyboardId()) as! NotificationVC
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
//    fileprivate func setupShimmeringImage() {
//
//        bgImageView.contentMode = .scaleAspectFill
//        // bgImageView.frame = view.frame
//
//        bgImageView.frame = CGRect(x: 0, y: 64, width: Int(kScreenWidth), height: Int(kScreenHeight))
//
//
//
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
//
//
//
    
    
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
                
            case 2688://iphone XS Max
                
                //print("iphone XS Max")
                self.headerViewConstraintH.constant = 84
                self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
                
            case 1792://iphone XR
                self.headerViewConstraintH.constant = 84
                self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
            default: break
                //print("unknown")
                
                
            }
            
        }
        
    }
    
}
//#MARK:----    -----
extension CategoryViewController : UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tblCategory.dequeueReusableCell(withIdentifier: CategoryTVC.cellIdentifier(), for: indexPath) as! CategoryTVC
        
        if indexPath.row % 2 != 0
        {
            
            cell.subView.backgroundColor =  UIColor(red: 231.0/255.0, green: 240.0/255.0, blue: 241.0/255.0, alpha: 1.0)
            
        }else{
            
            cell.subView.layer.shadowOpacity = 0.9
            cell.subView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            cell.subView.layer.shadowRadius = 3.0
            cell.subView.layer.shadowColor = UIColor(red: 168.0/255.0, green: 210.0/255.0, blue: 223.0/255.0, alpha: 1.0).cgColor
            cell.subView.backgroundColor =  UIColor.white
        }
        
        
        cell.configureCell(withDictData: kSharedInstance.getDictionary(self.categoryListArr[indexPath.row]), forIndxPath: indexPath)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dictData = kSharedInstance.getDictionary(self.categoryListArr[indexPath.row])
        
        self.productListViewController(withCatId: String.getString(dictData["category_id"]), catName: String.getString(dictData["name"]))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //#MARK:-----------callCategoryListWebService---------
    private func callCategoryListWebService()
    {
      
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetCategoryList, requestMethod: .post, requestImages: [dictImg], withProgressHUD: false, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
              
                if Int.getInt(dictResponse["success"]) == 1
                {
                    
                    strongSelf.bgImageView.removeFromSuperview()
                    strongSelf.shimmerImageView.removeFromSuperview()
                    
                    strongSelf.tblCategory.isHidden = false
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    
                   // let resultData = GetResponseFromCategoriesApi(result: result)
                    
                  //  //print(resultData.result)


                    strongSelf.categoryListArr = kSharedInstance.getArray(result["categoryData"])
                    strongSelf.tblCategory.reloadData()
                    
                }else{
                    
                strongSelf.tblCategory.isHidden = true
                    
                    strongSelf.bgImageView.removeFromSuperview()
                    strongSelf.shimmerImageView.removeFromSuperview()
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
          private func callGetCurrencyListWebServiceHM()
          {
              
              let dictImg:[String : Any] = ["image" : UIImage(),
                                            "imageName" : "uploaded_file"]
              TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetCurrencyList, requestMethod: .post, requestImages: [dictImg], withProgressHUD: false, withProgessHUDTitle: "", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                  guard let strongSelf = self else { return }
                  if errorType == .requestSuccess
                  {
                      UIApplication.shared.endIgnoringInteractionEvents()
                      
                      let dictResponse = kSharedInstance.getDictionary(response)
                      
                   
                    //titleStr codeStr valueStr symbolStr
                   
                      strongSelf.titleStr.removeAll()
                      strongSelf.codeStr.removeAll()
                      strongSelf.valueStr.removeAll()
                      strongSelf.symbolStr.removeAll()
                   
                   
                   
                      if Int.getInt(dictResponse["success"]) == 1
                      {
                       
                          let result = kSharedInstance.getDictionary(dictResponse["result"])
                          
                           let currencyData = kSharedInstance.getArray(result["currencyData"])
                       
                           for currData in currencyData
                          {
                             let dictData = kSharedInstance.getDictionary(currData)
                         
                             strongSelf.titleStr.append(String.getString(dictData["title"]))
                             strongSelf.codeStr.append(String.getString(dictData["code"]))
                             strongSelf.valueStr.append(String.getString(dictData["value"]))
                             strongSelf.symbolStr.append(String.getString(dictData["symbol"]))
                           
                           }
                          
                          
                        
                          
                      }else{
                          
                          
                          
                      }
                      
                  }
                  else if errorType == .requestFailed
                  {
                      
                  }
                  else
                  {
                  }
              })
              
              
              
              
          }
    
    
    //#MARK:-----------callGetCurrencyDetailsWebServiceHM---------
       private func callGetCurrencyDetailsWebServiceHM()
       {
           
           let dictImg:[String : Any] = ["image" : UIImage(),
                                         "imageName" : "uploaded_file"]
           TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetCurrencyDetails, requestMethod: .post, requestImages: [dictImg], withProgressHUD: false, withProgessHUDTitle: "", requestVideos: [String:  Any](), requestData: dictParamsCurr, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
               guard let strongSelf = self else { return }
               if errorType == .requestSuccess
               {
                   UIApplication.shared.endIgnoringInteractionEvents()
                   
                   let dictResponse = kSharedInstance.getDictionary(response)
                   
                   if Int.getInt(dictResponse["success"]) == 1
                   {
                       let result = kSharedInstance.getDictionary(dictResponse["result"])
                       
                     let currencyData = kSharedInstance.getDictionary(result["currencyData"])
                    
                    //print(currencyData)
                       
                    kSharedUserDefaults.setCurrencyDetails(currencyDetails: currencyData)
                   
                    
                    
                    kSharedUserDefaults.setCurrencySavedIn(currencySavedIn: true)
                     
                  //  kSharedUserDefaults.setLoggedInUserDetails(loggedInUserDetails: userData)
                  //  kSharedUserDefaults.setUserLoggedIn(userLoggedIn: true)
                    
                  //   kSharedUserDefaults.
                       
                   }else{
                       
                       
                       
                   }
                   
               }
               else if errorType == .requestFailed
               {
                   
               }
               else
               {
               }
           })
           
           
           
           
       }
    
    
    
    func productListViewController(withCatId catId : String , catName name : String)
    {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        let nextViewController = sb.instantiateViewController(withIdentifier: ProductListViewController.storyboardId()) as! ProductListViewController
        nextViewController.catId   = catId
        nextViewController.catName = name
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}
