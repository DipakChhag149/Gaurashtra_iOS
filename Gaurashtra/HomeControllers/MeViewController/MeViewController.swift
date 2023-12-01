//
//  MeViewController.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 29/12/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit
import SWRevealViewController

class MeViewController: GaurashtraBaseVC {

    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    
    let bgImageView = UIImageView(image: #imageLiteral(resourceName: "white"))
    let shimmerImageView = UIImageView(image: #imageLiteral(resourceName: "white"))
    
    @IBOutlet weak var lblUserName: UILabel!
    var nameListArr = ["My Profile","My Addresses","My Orders","My Wishlist","My Reviews","Change Password","Wallet"]
    
    // var nameListArr2 = ["Change Password","Change Password","Change Password","Change Password","Change Password","Change Password"]
    
    var imgArr =  [#imageLiteral(resourceName: "profile_settings"),#imageLiteral(resourceName: "address_book"),#imageLiteral(resourceName: "oder_history"),#imageLiteral(resourceName: "bookmark"),#imageLiteral(resourceName: "popular"),#imageLiteral(resourceName: "change_password"),#imageLiteral(resourceName: "wallet")]
    
    private var dictParamsCurr = [kCode   : ""]
       
       
    var titleStr  : [String] = []
    var codeStr   : [String] = []
    var valueStr  : [String] = []
    var symbolStr : [String] = []
    
    @IBOutlet weak var tblMyAccount: UITableView!
    
    @IBOutlet weak var collectionVC: UICollectionView!
    
    @IBOutlet weak var btnSideMenu: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDevice()
        self.callGetCurrencyListWebServiceHM()
        
        self.collectionVC.delegate   = self
        self.collectionVC.dataSource = self
        
        btnSideMenu.target = revealViewController()
        btnSideMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        self.registerNib()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         let userId = LoginDataModel.getLoggedInUserDetails().customer_id
        
        
        
        
        if String.getLength(userId) == 0
        {
            
            if let tabItems = self.tabBarController?.tabBar.items {
                                    // In this case we want to modify the badge number of the third tab:
             let tabItem = tabItems[4]

             tabItem.badgeValue = nil
                
            }
            
            kSharedInstance.setupShimmeringImage(withView: self.view, backGrroundImgV: bgImageView, shimmerImageView: shimmerImageView)

            self.lblUserName.text = "Gaurashtra"
            kSharedUserDefaults.set("MeViewController", forKey: "LoginView")
            self.loginView()
        }else{
            self.shimmerImageView.removeFromSuperview()
            self.bgImageView.removeFromSuperview()
            
            self.lblUserName.text = String.getString(LoginDataModel.getLoggedInUserDetails().firstName) + " " + String.getString(LoginDataModel.getLoggedInUserDetails().lastName)
            
        }
    }
    
    
      private func registerNib() -> Void
       {
           let nibCards = UINib(nibName: MeCVC.identifier(), bundle: nil)
           self.collectionVC.register(nibCards, forCellWithReuseIdentifier: MeCVC.identifier())
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

    @IBAction func tapToCarts(_ sender: UIBarButtonItem) {
        
        
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextViewController = sb.instantiateViewController(withIdentifier: NotificationVC.storyboardId()) as! NotificationVC
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
     
    }
    
    @IBAction func tapToPaytm(_ sender: UIButton) {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        let nv = sb.instantiateViewController(withIdentifier: PaytmVC.storyboardId()) as! PaytmVC
        self.navigationController?.pushViewController(nv, animated: true)
    }
    
    @IBAction func tapToCurrency(_ sender: UIBarButtonItem) {
        if codeStr.count != 0
        {
           let picker = RSPickerView.init(view: self.view, arrayList: self.codeStr, keyValue: nil, handler: { (selectedIndex: NSInteger, response: Any?) in
               
               let codeStr = self.codeStr[selectedIndex]
               
               self.dictParamsCurr[kCode] = "\(codeStr)"
               
               self.callGetCurrencyDetailsWebServiceHM()
               })
           
                picker.viewContainer.backgroundColor = kWhiteColor
                   
               }else{
               
                self.view.makeToast("Loading Please Wait")
               
               }
    }
    
}
//#MARK:   UICollectionViewDataSource, UICollectionViewDelegate  

extension MeViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
      return nameListArr.count
        
         
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
       
        let cell = collectionVC.dequeueReusableCell(withReuseIdentifier: MeCVC.identifier(), for: indexPath) as! MeCVC
                      
       // cell.configureCell(withNameArrData: self.nameListArr, imgArr: self.imgArr, indxPath: indexPath)
   
        cell.lblName.text  = self.nameListArr[indexPath.item]
     //   cell.lbl2.text     = self.nameListArr2[indexPath.item]
        cell.imgView.image = imgArr[indexPath.item]
      
        return cell
      
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
       
        switch indexPath.item {
        
            case 0:
           
                self.myProfileVC()
            
            case 1:
            
                 self.myAddressListVC()
                
                
            
            case 2:
            
                 self.myOrderListVC()
               
            case 3:
            
         
                self.myWishListVC()
            
            
            case 4:
           
            //wishlist
                self.myReviewVC()
            
            case 5:
            
             
                 self.changePasswordVC()
            
            case 6:
            
             
                 self.myWalletVC()
            
        default:
            break
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        let width = (140.0 * kScreenWidth) / 320
                               
        let hight = (150.0 * kScreenWidth) / 320
         return CGSize(width: width, height: 120)

        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
         return 8
      
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
          //return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        
    }
    
    
    func myOrderListVC()
       {
           
           let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
           
           let nextViewController = sb.instantiateViewController(withIdentifier: MyOrdersViewController.storyboardId()) as! MyOrdersViewController
           
           self.navigationController?.pushViewController(nextViewController, animated: true)
       }
       
       func myAddressListVC()
       {
           
           let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
           
           let nextViewController = sb.instantiateViewController(withIdentifier: MyAddresViewController.storyboardId()) as! MyAddresViewController
           
           nextViewController.controllerId = 1
           
           self.navigationController?.pushViewController(nextViewController, animated: true)
       }
       
    //MyReviewVC
    func myWalletVC()
          {
              
              let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
              
              let nextViewController = sb.instantiateViewController(withIdentifier: MyWalletVC.storyboardId()) as! MyWalletVC
              
              self.navigationController?.pushViewController(nextViewController, animated: true)
          }
    
       func changePasswordVC()
       {
           
           let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
           
           let nextViewController = sb.instantiateViewController(withIdentifier: ChangePasswordVC.storyboardId()) as! ChangePasswordVC
           
           self.navigationController?.pushViewController(nextViewController, animated: true)
       }
    
    
        func myReviewVC()
          {
              
              let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
              
              let nextViewController = sb.instantiateViewController(withIdentifier: MyReviewVC.storyboardId()) as! MyReviewVC
              
              self.navigationController?.pushViewController(nextViewController, animated: true)
          }
       
       func myProfileVC()
       {
           
           let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
           
           let nextViewController = sb.instantiateViewController(withIdentifier: ProfileViewController.storyboardId()) as! ProfileViewController
           
           self.navigationController?.pushViewController(nextViewController, animated: true)
       }
       
       
       func myWishListVC()
       {
           
           let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
           
           let nextViewController = sb.instantiateViewController(withIdentifier: WishListViewController.storyboardId()) as! WishListViewController
           
           self.navigationController?.pushViewController(nextViewController, animated: true)
       }
       
   
    
    //#MARK:-----------callLoginWebService---------
          private func callGetCurrencyListWebServiceHM()
          {
              
              let dictImg:[String : Any] = ["image" : UIImage(),
                                            "imageName" : "uploaded_file"]
              TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetCurrencyList, requestMethod: .post, requestImages: [dictImg], withProgressHUD: false, withProgessHUDTitle: "", requestVideos: [String:  Any](), requestData: dictParamsCurr, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
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
       
       
    
    
}

