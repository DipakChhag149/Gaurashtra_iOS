//
//  HomeViewController.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 27/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//


import UIKit
import SWRevealViewController
import CHIPageControl
import Toast_Swift


class HomeViewController: GaurashtraBaseVC {
  

    var dictData : Dictionary<String,Any> = ["":""]
    
    var bestofProdName : String = ""
    
    var sliderDataArr          : [Any] = []
    var afterSlider            : Dictionary<String,Any> = ["":""]
    var topSellingData         : [Any] = []
    var categoryData           : [Any] = []
    var todayDeal              : Dictionary<String,Any> = ["":""]
    var todayDealArrData       : [Any] = []
    var afterTodayDeal         : [Any] = []
    var afterTodayDealDictData : Dictionary<String,Any> = ["":""]
    var videoDictData          : Dictionary<String,Any> = ["":""]
    var bestOfArray            : [Any] = []
    var bestOfDictData         : Dictionary<String,Any> = ["":""]
    var afterBestOfferBanner   : [Any] = []
    var recentlyViewedArray    : [Any] = []
    var shopByBrandArr         : [Any] = []
    var afterShopByData        : [Any] = []
    var recommendedData        : [Any] = []
    var footerBannerData       :  [Any] = []
    var topSellingCount        : Int   = 0
    var bestOfArrCount         : Int   = 0
    var recentlyViewedCount    : Int   = 0
    var recommendedProdCount   : Int   = 0
    
    
    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var lblOffer: UILabel!
    
    @IBOutlet weak var pageControl: CHIPageControlFresno!
    @IBOutlet weak var viewBanner: UIView!
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var tblHome: UITableView!
    
    @IBOutlet weak var btnMenu: UIBarButtonItem!
  //  let gradientLayer = CAGradientLayer()
    let bgImageView = UIImageView(image: #imageLiteral(resourceName: "bg11"))
    let shimmerImageView = UIImageView(image: #imageLiteral(resourceName: "bg22"))
  
//    "currencyCode" : "INR",
//     "currencyValue" : "1.00000000",
    
        private var dictParams = [kUserId        : "",
                                  kDeviceId      : "",
                                  kCurrencyCode  : "",
                                  kCurrencyValue : ""]
    
//    kCurrencyCode  kCurrencyValue
//
    
        private var dictParamsCurr = [kCode   : ""]
    
    
        var titleStr  : [String] = []
        var codeStr   : [String] = []
        var valueStr  : [String] = []
        var symbolStr : [String] = []
    
        override func viewDidLoad() {
          super.viewDidLoad()
            self.getDevice()
        self.callGetCurrencyListWebServiceHM()
        setNeedsStatusBarAppearanceUpdate()
        btnMenu.target = revealViewController()
        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        //view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.registerNib()
        self.getIphoneDevice()
        self.getIpadDevice()
        self.setupPageControl()
        
        self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        
         let deviceToken = String.getString(kSharedUserDefaults.string(forKey: "deviceToken"))
                                   
              
           if String.getLength(deviceToken) != 0
           {
               self.dictParams[kDeviceId]   = deviceToken

           }else{

               self.dictParams[kDeviceId]   = "yuu75k6j4h3k36k336l3h6l363"
           }
        
        if isInternetAvailable()
        {
            
            
            
             self.callGetHomePageDataWebService()
            
            self.dictParamsCurr[kCode] = "INR"
            self.callGetCurrencyDetailsWebServiceHM()
            
             //self.setupShimmeringImage()
            
            kSharedInstance.setupShimmeringImage(withView: self.view, backGrroundImgV: bgImageView, shimmerImageView: shimmerImageView)
            
             UIApplication.shared.beginIgnoringInteractionEvents()
            
        }else{
            showOkAlert(withMessage:kNetworkErrorAlert)
        }
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        
        let currencyCode = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
        
        //print(currencyCode)
        
        if String.getLength(currencyCode) != 0
        {
             self.dictParams[kCurrencyCode] = String.getString(CurrencyDataModel.getCurrencySavedDetails().code)
        }else{
             self.dictParams[kCurrencyCode] = "INR"
        }
        
        let currencyValue = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
        
        if String.getLength(currencyValue) != 0
        {
            self.dictParams[kCurrencyValue] = String.getString(CurrencyDataModel.getCurrencySavedDetails().value)
        }else{
            self.dictParams[kCurrencyValue] = "1.00000000"
        }
        
        let userId = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        
        if String.getLength(userId) == 0
        {
            
            if let tabItems = self.tabBarController?.tabBar.items {
                  // In this case we want to modify the badge number of the third tab:
               let tabItem = tabItems[4]

               tabItem.badgeValue = nil
          
                  
              }
            
        }
        
        
     //  kCurrencyCode  kCurrencyValue
        
        if String.getString(launch) == "First launch"
        {
            
            let locale = String.getString(Locale.current.regionCode)
                 
            if locale == "IN"
            {
               self.dictParamsCurr[kCode] = "INR"
             }else{
              
               self.dictParamsCurr[kCode] = "USD"
              
             }
             self.callGetCurrencyDetailsWebServiceHM()
            
        }
        
        
       
        
        if isInternetAvailable()
        {
             self.callGetCartDataWebServiceHM()
             self.callGetHomePageDataWebService()
            
        }else{
            showOkAlert(withMessage:kNetworkErrorAlert)
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
                  
              case 2688://iphone XS Max
                  
                  //print("iphone XS Max")
                  self.headerViewConstraintH.constant = 84
                  self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
                  
              case 1792://iphone XR
                  self.headerViewConstraintH.constant = 84
                  self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
              default:
                self.headerViewConstraintH.constant = 84
                self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
                  
              }
              
          }
          
      }
    
    
    
   
    
    
    func setupPageControl()
    {
        //self.pageControl.progress = 0
        
        
        //pageControl.tintColor =  UIColor(red: 193.0/255.0, green: 149.0/255.0, blue: 59.0/255.0, alpha: 1.0)
        
        pageControl.tintColor =  .white
        self.pageControl.progress = 0
       
        pageControl.currentPageTintColor = .orange
        
        self.pageControl.padding = 6
       
        
    }
    
    private func registerNib() -> Void
    {
        let nibCards = UINib(nibName: BannerCVC.identifier(), bundle: nil)
        self.bannerCollectionView.register(nibCards, forCellWithReuseIdentifier: BannerCVC.identifier())
    }
    
    func getIpadDevice()
    {
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.nativeBounds.height {
                
            //lblOffer lblProductDetail
            case 2048 : //ipad mini/ 5th/6th/Air/Air 2 generation /12.9-inch iPad Pro
              viewBanner.frame.size.height = 280
            case 2224://ipad 10.5-inch iPad Pro
               viewBanner.frame.size.height = 320
            case 1668://11-inch iPad Pro
               viewBanner.frame.size.height = 320
            case 2732://iphone 5/5S/SE
             viewBanner.frame.size.height = 320
            default:
                //print("unknown")
             viewBanner.frame.size.height = 320
            }
        }
    }
    func getIphoneDevice()
    {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136://iphone 5/5S/SE
                viewBanner.frame.size.height = 140
            case 1334://iphone 6/6S/7/8
                viewBanner.frame.size.height = 200
            case 2208://iphone 6+/6S+/7+/8+
                viewBanner.frame.size.height = 200
            case 2436://iphone X/XS
                viewBanner.frame.size.height = 200
                //print("iphone XS")
            case 2688://iphone XS Max
                //print("iphone XS Max")
                viewBanner.frame.size.height = 200
            case 1792://iphone XR
                //print("iphone XR")
                viewBanner.frame.size.height = 210
            default:
                viewBanner.frame.size.height = 200
            }
        }
    }
    @IBAction func tapToNotification(_ sender: UIBarButtonItem) {
        
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextViewController = sb.instantiateViewController(withIdentifier: NotificationVC.storyboardId()) as! NotificationVC
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    @IBAction func tapToPaytm(_ sender: UIBarButtonItem) {
      // self.beginPayment()
    }
   
    @IBAction func tapToSelectCurrency(_ sender: UIBarButtonItem) {
        
        //titleStr codeStr valueStr symbolStr
        
        
        if codeStr.count != 0
        {
            let picker = RSPickerView.init(view: self.view, arrayList: self.codeStr, keyValue: nil, handler: { (selectedIndex: NSInteger, response: Any?) in
                                    
                                    //fuel_type_id_list fuel_type_name_list
            //                        self.lblHistoryResult.text = kDisplayHistoryResult[selectedIndex]
                
                let codeStr = self.codeStr[selectedIndex]
                
                 self.dictParamsCurr[kCode] = "\(codeStr)"
                
                 self.callGetCurrencyDetailsWebServiceHM()
               
               
                self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
                let deviceId = String.getString(kSharedUserDefaults.string(forKey: "deviceToken"))
                    if String.getLength(deviceId) != 0
                    {
                         self.dictParams[kDeviceId] = deviceId
                    }else{
                        self.dictParams[kDeviceId] = "4541225555as5s5s4df47r4f5fg4f4f5s56s5"
                }
               
               
               if isInternetAvailable()
               {
                    self.callGetHomePageDataWebService()
                   
                   
               }else{
                self.showOkAlert(withMessage:kNetworkErrorAlert)
               }
                
                })
                 picker.viewContainer.backgroundColor = kWhiteColor
                    
                }else{
                
                 self.view.makeToast("Loading Please Wait")
                
                }
            
    }
        
        
       
    
    
    
    
}
//#MARK:   UITableViewDataSource,UITableViewDelegate  
extension HomeViewController : UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      return HomeOptions.count
    
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        switch indexPath.row
        {
        case  HomeOptions.first.rawValue:
            let cell = tblHome.dequeueReusableCell(withIdentifier: TVC1.cellIdentifier(), for: indexPath) as! TVC1
            
            cell.configureCellForbackgroundImage(withDictData: kSharedInstance.getDictionary(afterSlider["background"]), indxPath: indexPath)
         
            return cell
            
            
        case HomeOptions.topSelling.rawValue:
                let cell = tblHome.dequeueReusableCell(withIdentifier: TopSellingTVC.cellIdentifier(), for: indexPath) as! TopSellingTVC
                cell.configureCell(withDictData: self.dictData, arrDataCount: self.topSellingData, forIndxPath: indexPath) { (buttonViewMore : UIButton) in
                    
                    
                      self.categoryDetailVC(withserviceName: kGetTopSellingList, HeaderTitle: "Top Selling Items", withId: 1)
                    
                    
                }
                return cell
            
        case HomeOptions.otherServices.rawValue:
            let cell = tblHome.dequeueReusableCell(withIdentifier: OtherServicesTVC.cellIdentifier(), for: indexPath) as! OtherServicesTVC
            return cell
        case HomeOptions.bestOffer.rawValue:
            let cell = tblHome.dequeueReusableCell(withIdentifier: BestOfferTVC.cellIdentifier(), for: indexPath) as! BestOfferTVC//bestofProdName
            cell.configureCellBestOffer(withDictData:  self.todayDeal, arrDataCount: todayDealArrData, forIndxPath: indexPath) { (buttonViewMore : UIButton) in
                  self.categoryDetailVC(withserviceName: kGetTodayDealList, HeaderTitle: "Today Deal", withId: 2)
            }
            
            return cell
            
        case HomeOptions.banner2.rawValue:
            let cell = tblHome.dequeueReusableCell(withIdentifier: Banner2TVC.cellIdentifier(), for: indexPath) as! Banner2TVC
//        cell.configureCellBanner2(withBannerData:self.afterTodayDealDictData , andIndxPath: indexPath)
           
            
            return cell
            
        case HomeOptions.videoBanner.rawValue:
            let cell = tblHome.dequeueReusableCell(withIdentifier: VideoBannerTVC.cellIdentifier(), for: indexPath) as! VideoBannerTVC
            cell.configureCellVideoBanner(withBannerData: self.videoDictData, andIndxPath: indexPath, btnSubScribe: {(btnSubScribe : UIButton) in
                //print("Youtube")
             
                let appURL = NSURL(string: "https://www.youtube.com/channel/UCrIIho0FzAoQvG0jBpB1TvQ")!
                let webURL = NSURL(string: "https://www.youtube.com/channel/UCrIIho0FzAoQvG0jBpB1TvQ")!
                
                let application = UIApplication.shared
                
                if application.canOpenURL(appURL as URL) {
                    application.open(appURL as URL)
                } else {
                    // if Youtube app is not installed, open URL inside Safari
                    application.open(webURL as URL)
                }
                
                
            })
            
            return cell
            
            
        case HomeOptions.bestProduct.rawValue:
            let cell = tblHome.dequeueReusableCell(withIdentifier: BestProductTVC.cellIdentifier(), for: indexPath) as! BestProductTVC
            cell.configureCellBestProduct(withDictData: self.dictData, catName: bestofProdName, arrDataCount: self.bestOfArray, forIndxPath: indexPath, itemsCount: self.bestOfArrCount) { (buttonViewMore : UIButton) in
                
                self.categoryDetailVC(withserviceName: kGetBestOfProductList, HeaderTitle: String.getString(self.bestOfDictData["name"]), withId: 3)
               
            }
            
            return cell
            
            
        case HomeOptions.banner3.rawValue:
            let cell = tblHome.dequeueReusableCell(withIdentifier: Banner3TVC.cellIdentifier(), for: indexPath) as! Banner3TVC
            
           // cell.configureCellVideoBanner3(withBannerData: afterBestOfferBanner, andIndxPath: indexPath)
            
            return cell
            //
        case HomeOptions.recentlyViewed.rawValue:
            let cell = tblHome.dequeueReusableCell(withIdentifier: RecentlyViewTVC.cellIdentifier(), for: indexPath) as! RecentlyViewTVC
            cell.configureCellRecentlyViewed(withDictData: self.dictData, arrDataCount: self.recentlyViewedArray, forIndxPath: indexPath) { (buttonViewMore : UIButton) in

                 self.categoryDetailVC(withserviceName: kGetRecentlyViewedList, HeaderTitle: "Recently Viewed", withId: 4)
                
            }
            
            return cell
            
        case HomeOptions.shopByBrand.rawValue:
            let cell = tblHome.dequeueReusableCell(withIdentifier: ShopByBrandTVC.cellIdentifier(), for: indexPath) as! ShopByBrandTVC
            
            cell.configureCellShopByBrand(withDictData: self.dictData, forIndxPath: indexPath) { (buttonViewMore : UIButton) in
                
                self.shopByBrandListVC()
                
            }
            
            return cell
            
        case HomeOptions.doubleBanner.rawValue:
            let cell = tblHome.dequeueReusableCell(withIdentifier: DoubleBannerTVC.cellIdentifier(), for: indexPath) as! DoubleBannerTVC
//            cell.configureCellDoubleBanner(withArrData: self.afterShopByData, forIndxPath: indexPath, button1: { (button1 : UIButton) in
//                let dictData = kSharedInstance.getDictionary(self.afterShopByData[0])
//
//                //print(dictData)
//
//                let linkType = String.getString(dictData["linkType"])
//
//                //print(linkType)
//
//
//                if linkType == "Product"
//                {
//                    //print(dictData)
//                    self.productDetailsHomeVC(withProductId: String.getString(dictData["linkId"]))
//                }else if linkType == "Category"
//                {
//                    self.productListViewControllerHP(withCatId: String.getString(dictData["linkId"]))
//
//                }
//
//
//            }, button2:{ (button2 : UIButton) in
//                //print("Btn2")
//
//
//                let dictData = kSharedInstance.getDictionary(self.afterShopByData[1])
//
//                //print(dictData)
//
//
//
//            })
//
            return cell
            
        case HomeOptions.recommendedProd.rawValue:
            let cell = tblHome.dequeueReusableCell(withIdentifier: RecommendedProductTVC.cellIdentifier(), for: indexPath) as! RecommendedProductTVC
            
            cell.configureCellRecommendedProd(withDictData: self.dictData, arrDataCount: recommendedData, forIndxPath: indexPath) { (buttonViewMore : UIButton) in
                self.categoryDetailVC(withserviceName: kGetRecommendedProductList, HeaderTitle: "Recommended Products", withId: 5)
            }
            
            return cell
            
        case HomeOptions.lastBanner.rawValue:
            let cell = tblHome.dequeueReusableCell(withIdentifier: LastBannerTVC.cellIdentifier(), for: indexPath) as! LastBannerTVC
            // cell.configureCellLastbanner(withBannerData: self.footerBannerDictData, andIndxPath: indexPath)
            
            return cell
            
    
        default:
            return UITableViewCell()
        }
        
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row
        {
        case  HomeOptions.first.rawValue:
            break
          
       
        case HomeOptions.topSelling.rawValue:
            break
           
            
        case HomeOptions.otherServices.rawValue:
            break
            
            
        case HomeOptions.bestOffer.rawValue:
            break
         
            
        case HomeOptions.banner2.rawValue:
            break
//            let sb :UIStoryboard=UIStoryboard(name: kHome, bundle: nil)
//            let nextVC = sb.instantiateViewController(withIdentifier: ProductDetailsViewController.storyboardId()) as!ProductDetailsViewController
//
//            self.navigationController?.pushViewController(nextVC, animated: true)
         
        case HomeOptions.videoBanner.rawValue:
            
//            let cell = tblHome.dequeueReusableCell(withIdentifier: VideoBannerTVC.cellIdentifier(), for: indexPath) as! VideoBannerTVC
//
//            cell.playerView.play()
            
            break
            
            
        case HomeOptions.bestProduct.rawValue:
            break
            
        case HomeOptions.banner3.rawValue:
            break
//            let sb :UIStoryboard=UIStoryboard(name: kHome, bundle: nil)
//            let nextVC = sb.instantiateViewController(withIdentifier: ProductDetailsViewController.storyboardId()) as!ProductDetailsViewController
//
//            self.navigationController?.pushViewController(nextVC, animated: true)
        case HomeOptions.recentlyViewed.rawValue:
            break
            
        case HomeOptions.shopByBrand.rawValue:
            break
            
        case HomeOptions.doubleBanner.rawValue:
            break
            
        case HomeOptions.recommendedProd.rawValue:
            break
        
        case HomeOptions.lastBanner.rawValue:
            break
//            let sb :UIStoryboard=UIStoryboard(name: kHome, bundle: nil)
//            let nextVC = sb.instantiateViewController(withIdentifier: ProductDetailsViewController.storyboardId()) as!ProductDetailsViewController
//
//            self.navigationController?.pushViewController(nextVC, animated: true)
           
           
        default:
             break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row
        {
        case  HomeOptions.first.rawValue:
            let hight = (230.0 * kScreenWidth) / 320 //250
            //  let width = (130.0 * kScreenWidth) / 320
            //            return 352.0
            return hight
        case  HomeOptions.topSelling.rawValue:
            let hight = (240.0 * kScreenWidth) / 320
            return hight
        case HomeOptions.otherServices.rawValue:
            let hight = (80.0 * kScreenWidth) / 320
            return hight
            
        case HomeOptions.bestOffer.rawValue://Today deal
            // let hight = (100.0 * kScreenWidth) / 320
            //todayDeal
            
            let available = String.getString(todayDeal["available"])
            
            
            
            if available == "1"
            {
                return 550.0
                
            }else{
                return 0.0
            }
        case HomeOptions.banner2.rawValue:
//            let hight = (150.0 * kScreenWidth) / 320
//            return hight
            if self.afterTodayDeal.count != 0
           {
               let hight = (130.0 * kScreenWidth) / 320
                return hight
           }else{
              return 0
           }
        case HomeOptions.videoBanner.rawValue:
            let hight = (250.0 * kScreenWidth) / 320
            
            return 0
            
        case HomeOptions.bestProduct.rawValue:
            let hight = (240.0 * kScreenWidth) / 320
            
            return hight
            
        case HomeOptions.banner3.rawValue:
             if self.afterBestOfferBanner.count != 0
              {
                  let hight = (150.0 * kScreenWidth) / 320
                   return hight
              }else{
                            
                 return 0
              }//
            
        case HomeOptions.recentlyViewed.rawValue:
            
            if recentlyViewedArray.count != 0
            {
                let hight = (250.0 * kScreenWidth) / 320
                
                return hight
                
            }else{
                
                return 0.0
            }
            
        case HomeOptions.shopByBrand.rawValue:
            
            let hight = (360.0 * kScreenWidth) / 320
            
            return hight
        case HomeOptions.doubleBanner.rawValue:
            if self.afterShopByData.count != 0
            {
                let hight = (150.0 * kScreenWidth) / 320
                 return hight
            }else{
                          
               return 0
            }//afterTodayDeal
          
        case  HomeOptions.recommendedProd.rawValue:
           
            if self.recommendedData.count != 0
            {
                let hight = (250.0 * kScreenWidth) / 320
                return hight
            }else{
                return 0
            }
           
            
            
        case HomeOptions.lastBanner.rawValue:
           if self.footerBannerData.count != 0
            {
                let hight = (150.0 * kScreenWidth) / 320
                 return hight
            }else{
                          
               return 0
            }//afterTodayDeal
            
        default:
            return 0.0
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        switch indexPath.row
        {
        case  HomeOptions.first.rawValue:
            
            guard let tableViewCell = cell as? TVC1 else { return }
            
            tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
            
            tableViewCell.collectionView1.reloadData()
            
            
            
        case HomeOptions.topSelling.rawValue:
            guard let tableViewCell = cell as? TopSellingTVC else { return }
            
            tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
            
            tableViewCell.collectionView2.reloadData()
            
            
            
        case HomeOptions.otherServices.rawValue:
            
            guard let tableViewCell = cell as? OtherServicesTVC else { return }
            
            tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)

            tableViewCell.otherServicesCV.reloadData()

            
            
        case HomeOptions.bestOffer.rawValue: // today deal
            
            guard let tableViewCell = cell as? BestOfferTVC else { return }
            
            tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)

            tableViewCell.bestOfferCV.reloadData()
            
            
            
            
        case HomeOptions.banner2.rawValue:
            
            guard let tableViewCell = cell as? Banner2TVC else { return }
            tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: 11)
            tableViewCell.CVAfterTodayDeal.reloadData()
            
        case HomeOptions.bestProduct.rawValue:
            
            
            
            guard let tableViewCell = cell as? BestProductTVC else { return }
            
            tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: 5)
            
            tableViewCell.collectionVBestProd.reloadData()
            
        case HomeOptions.videoBanner.rawValue:
            break
        case HomeOptions.banner3.rawValue:
            guard let tableViewCell = cell as? Banner3TVC else { return }
            tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: 12)
            tableViewCell.CVBanner3.reloadData()
            
        case HomeOptions.recentlyViewed.rawValue:
            
            guard let tableViewCell = cell as? RecentlyViewTVC else { return }

            tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: 7)
            
            tableViewCell.collectionVRecentlyViewed.reloadData()
            
            
            
        case HomeOptions.shopByBrand.rawValue:
            
           
            
            guard let tableViewCell = cell as? ShopByBrandTVC else { return }
            
            tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: 7)

            tableViewCell.CVShopbyBrand.reloadData()
            
        case HomeOptions.doubleBanner.rawValue:
            
            guard let tableViewCell = cell as? DoubleBannerTVC else { return }
            tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: 8)
            tableViewCell.CVDoubler.reloadData()
            
        case HomeOptions.recommendedProd.rawValue:
          
            
            guard let tableViewCell = cell as? RecommendedProductTVC else { return }
            
            tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
            
            tableViewCell.CVRecommendedProd.reloadData()
            
        case HomeOptions.lastBanner.rawValue:
            guard let tableViewCell = cell as? LastBannerTVC else { return }
            tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: 13)
            tableViewCell.CVLastBanner.reloadData()
            
        default:
            break
        }
    }

    func productListVC()
    {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        let nextViewController = sb.instantiateViewController(withIdentifier: ProductListViewController.storyboardId()) as! ProductListViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func brandListVC()
    {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextViewController = sb.instantiateViewController(withIdentifier: BrandListViewController.storyboardId()) as! BrandListViewController
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
   
}
//#MARK:  UICollectionViewDataSource, UICollectionViewDelegate 

extension HomeViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        if collectionView == bannerCollectionView
        {
            
            return sliderDataArr.count
            
        }else{
            
            switch collectionView.tag {
            case 0:
                
                let dictData = kSharedInstance.getArray(self.afterSlider["data"])
                
                //print(dictData)
                
                return dictData.count
                
            case 1://topSellingData
                
                return self.topSellingData.count
                
            case 2://categoryData
                return categoryData.count
            case 3://today Deals
                return todayDealArrData.count
            case 4:
                return bestOfArray.count
            case 5:
                return self.recentlyViewedArray.count
            case 6:
                return shopByBrandArr.count
            case 7:
                return self.recommendedData.count
            case 8:
                return self.afterShopByData.count
            case 11:
                return self.afterTodayDeal.count
            case 12:
                return self.afterBestOfferBanner.count
            case 13:
                return self.footerBannerData.count
            default:
                return 0
            }//
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == bannerCollectionView
        {
            let CVCellBnner = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCVC.identifier(), for: indexPath) as! BannerCVC
            
            CVCellBnner.configureCell(withBannerData: kSharedInstance.getDictionary(sliderDataArr[indexPath.item]), andIndxPath: indexPath)
            
            return CVCellBnner
            
            
        }else{
            
            switch collectionView.tag {
            case 0:
                let cellCVUpper = collectionView.dequeueReusableCell(withReuseIdentifier: CVC1.identifier(), for: indexPath) as! CVC1
                
                let dataArr = kSharedInstance.getArray(self.afterSlider["data"])

                //print(dataArr.count)

                cellCVUpper.configureCell(withBannerData: kSharedInstance.getDictionary(dataArr[indexPath.item]), andIndxPath: indexPath)
               
                
                return cellCVUpper
                
                
            case 1://Top Selling
                
                let cellCVUpper = collectionView.dequeueReusableCell(withReuseIdentifier: TopSellingCVC.identifier(), for: indexPath) as! TopSellingCVC
                
               cellCVUpper.configureCellTopSelling(withBannerData: kSharedInstance.getDictionary(self.topSellingData[indexPath.item]), andIndxPath: indexPath)
                
                
                return cellCVUpper
                
                
            case 2://categoryData
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OtherServecesCVC.identifier(), for: indexPath) as! OtherServecesCVC
                
                cell.configureCellCategory(withBannerData: kSharedInstance.getDictionary(categoryData[indexPath.item]), andIndxPath: indexPath)
                
                return cell
                
                
            case 3://Today deals
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestOfferCVC.identifier(), for: indexPath) as! BestOfferCVC
                cell.configureCellBestOfferTodayDeal(withBannerData: kSharedInstance.getDictionary(todayDealArrData[indexPath.item]), andIndxPath: indexPath)
                
                return cell
                
            case 4://Best product bestOf haircare
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestProductCVC.identifier(), for: indexPath) as! BestProductCVC
             //bestOfArray
                 cell.configureCellBestProduct(withBannerData: kSharedInstance.getDictionary(bestOfArray[indexPath.item]), andIndxPath: indexPath)
                
                return cell
                
            case 5:
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentlyViewCVC.identifier(), for: indexPath) as! RecentlyViewCVC
                
                cell.configureCellRecentlyViewed(withBannerData: kSharedInstance.getDictionary(recentlyViewedArray[indexPath.item]), andIndxPath: indexPath)
                
                return cell
                
                
                
            case 6:
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopByBrandCVC.identifier(), for: indexPath) as! ShopByBrandCVC
                
               cell.configureCellShopByBrand(withBannerData: kSharedInstance.getDictionary(shopByBrandArr[indexPath.item]), andIndxPath: indexPath)
                
                return cell
                
            case 7:
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedProductCVC.identifier(), for: indexPath) as! RecommendedProductCVC
                
                
                cell.configureCellrecommendedProduct(withBannerData: kSharedInstance.getDictionary(recommendedData[indexPath.item]), andIndxPath: indexPath)
                
                
                
                return cell
            case 8 ://self.afterShopByData.count
                
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DoubleBannerCVC.identifier(), for: indexPath) as! DoubleBannerCVC
                  cell.configureDoubleBannerCell(withBannerData: kSharedInstance.getDictionary(self.afterShopByData[indexPath.row]), andIndxPath: indexPath)
                 return cell
            case 11 ://self.afterShopByData.count
                
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Banner2CVC.identifier(), for: indexPath) as! Banner2CVC
                  cell.configureBanner2Cell(withBannerData: kSharedInstance.getDictionary(self.afterTodayDeal[indexPath.row]), andIndxPath: indexPath)
                 return cell
           case 12 ://self.afterShopByData.count
                               
                 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Banner3CVC.identifier(), for: indexPath) as! Banner3CVC
                 cell.configureBanner3Cell(withBannerData: kSharedInstance.getDictionary(self.afterBestOfferBanner[indexPath.row]), andIndxPath: indexPath)
                return cell
           
         case 13 ://self.afterShopByData.count
                               
                 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LastBannerCVC.identifier(), for: indexPath) as! LastBannerCVC
                 cell.configureLastBannerCell(withBannerData: kSharedInstance.getDictionary(self.footerBannerData[indexPath.row]), andIndxPath: indexPath)
                return cell
                
            default:
                return UICollectionViewCell()
            }
            
        }
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        //print("Collection view at row :\(collectionView.tag) selected index path :\(indexPath)")
        
        if collectionView == bannerCollectionView
        {
            
            
            
            let dictData = kSharedInstance.getDictionary(sliderDataArr[indexPath.item])
            
            //print(dictData)
            
            let linkType = String.getString(dictData["linkType"])
            
            //print(linkType)
            
            
            if linkType == "Product"
            {
                //print(dictData) option_value_id
                self.productDetailsHomeVC(withProductId: String.getString(dictData["linkId"]), option_value_id: "")
            }
            if linkType == "Category"
            {
                self.productListViewControllerHP(withCatId: String.getString(dictData["linkId"]))
            }
            
        }else{
            
            switch collectionView.tag {
            case 0:
                
                //                self.productDetailVC()
                
                let dataArr = kSharedInstance.getArray(self.afterSlider["data"])
                
                ////print(dataArr)
               
                
                
                let dictData = kSharedInstance.getDictionary(dataArr[indexPath.item])
                
                let linkType = String.getString(dictData["linkType"])
                //print(linkType)
                
               // self.productListViewControllerHP(withCatId: String.getString(dictData["linkId"]))
                if linkType == "Product"
                {
                    print(dictData)
                    self.productDetailsHomeVC(withProductId: String.getString(dictData["linkId"]), option_value_id: "")
                }
                
                if linkType == "Category"
                {
                    self.productListViewControllerHP(withCatId: String.getString(dictData["linkId"]))
                }
                
            case 1:
                
                let dictData = kSharedInstance.getDictionary(self.topSellingData[indexPath.item])
                self.productDetailsHomeVC(withProductId: String.getString(dictData["product_id"]), option_value_id: String.getString(dictData["option_value_id"]))
                
            case 2:
                
                let dictData = kSharedInstance.getDictionary(self.categoryData[indexPath.row])
                
                self.productListViewControllerHP(withCatId: String.getString(dictData["category_id"]))
                
            case 3:
                
                let dictData = kSharedInstance.getDictionary(todayDealArrData[indexPath.item])
                
                
                self.productDetailsHomeVC(withProductId: String.getString(dictData["product_id"]), option_value_id: String.getString(dictData["option_value_id"]))
                
                // self.productDetailVC()
                
            case 4:
                
                let dictDataBestof = kSharedInstance.getDictionary(self.bestOfArray[indexPath.item])
                self.productDetailsHomeVC(withProductId: String.getString(dictDataBestof["product_id"]), option_value_id: String.getString(dictDataBestof["option_value_id"]))
                
                
            case 5:
                
                let dictDataRecentlyViewed = kSharedInstance.getDictionary(self.recentlyViewedArray[indexPath.item])
                self.productDetailsHomeVC(withProductId: String.getString(dictDataRecentlyViewed["product_id"]), option_value_id: String.getString(dictDataRecentlyViewed["option_value_id"]))
                
            case 6:
                
                // self.productDetailVC()
                let dictData = kSharedInstance.getDictionary(self.shopByBrandArr[indexPath.row])
                //print(dictData)
                
              //  self.categoryDetailVCSB(withserviceName: kGetBrandProductList, HeaderTitle: String.getString(dictData["brand_name"]), withId: 6, brandId: String.getString(dictData["brand_id"]))
            case 7:
                let dictDataRecom = kSharedInstance.getDictionary(self.recommendedData[indexPath.item])
                self.productDetailsHomeVC(withProductId: String.getString(dictDataRecom["product_id"]), option_value_id: String.getString(dictDataRecom["option_value_id"]))
            case 8 ://afterTodayDeal
                
                let dictData = kSharedInstance.getDictionary(self.afterShopByData[indexPath.row])
                let linkType = String.getString(dictData["linkType"])
                if linkType == "Product"
                {
                    self.productDetailsHomeVC(withProductId: String.getString(dictData["linkId"]), option_value_id:String.getString(dictData["option_value_id"]))
                }else if linkType == "Category"
                {
                   self.productListViewControllerHP(withCatId: String.getString(dictData["linkId"]))
                }
                
           case 11 ://afterTodayDeal
                
                let dictData = kSharedInstance.getDictionary(self.afterTodayDeal[indexPath.row])
                let linkType = String.getString(dictData["linkType"])
                if linkType == "Product"
                {
                    self.productDetailsHomeVC(withProductId: String.getString(dictData["linkId"]), option_value_id: String.getString(dictData["option_value_id"]))
                }else if linkType == "Category"
                {
                   self.productListViewControllerHP(withCatId: String.getString(dictData["linkId"]))
                }
          case 12 ://afterTodayDeal
                
                let dictData = kSharedInstance.getDictionary(self.afterBestOfferBanner[indexPath.row])
                let linkType = String.getString(dictData["linkType"])
                if linkType == "Product"
                {
                    self.productDetailsHomeVC(withProductId: String.getString(dictData["linkId"]), option_value_id: String.getString(dictData["option_value_id"]))
                }else if linkType == "Category"
                {
                   self.productListViewControllerHP(withCatId: String.getString(dictData["linkId"]))
                }
          
        case 13 ://afterTodayDeal
                
                let dictData = kSharedInstance.getDictionary(self.footerBannerData[indexPath.row])
                let linkType = String.getString(dictData["linkType"])
                if linkType == "Product"
                {
                    self.productDetailsHomeVC(withProductId: String.getString(dictData["linkId"]), option_value_id: String.getString(dictData["option_value_id"]))
                }else if linkType == "Category"
                {
                   self.productListViewControllerHP(withCatId: String.getString(dictData["linkId"]))
                }
            default:
                break
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView == bannerCollectionView
        {
            let width = (320.0 * kScreenWidth) / 320
            return CGSize(width: width, height: viewBanner.frame.size.height)
        }else{
            switch collectionView.tag {
            case 0:
//                let width = (139.0 * kScreenWidth) / 320
//                let hight = (100.0 * kScreenWidth) / 320
                let width = (142.0 * kScreenWidth) / 320
                let hight = (102.0 * kScreenWidth) / 320
                return CGSize(width: width, height: hight)//151
            case 1://Top Selling
                let width = (130.0 * kScreenWidth) / 320
                let hight = (190.0 * kScreenWidth) / 320
                return CGSize(width: width, height: hight)
            case 2://Otherservices
                let width = (68.0 * kScreenWidth) / 320
                let hight = (68.0 * kScreenWidth) / 320
                return CGSize(width: width, height: hight)
            case 3://Best offer/Today deals
//                let width = (152.6 * kScreenWidth) / 320
                 if UIDevice().userInterfaceIdiom == .phone {
                    switch UIScreen.main.nativeBounds.height {
                    case 1136://iphone 5/5S/SE
                        let width = (151.6 * kScreenWidth) / 320
                        //let hight = (200.0 * kScreenWidth) / 320
                        return CGSize(width: width, height: 229)
                    case 1334://iphone 6/6S/7/8
                        let width = (152.6 * kScreenWidth) / 320
                        //let hight = (200.0 * kScreenWidth) / 320
                        return CGSize(width: width, height: 229)
                    case 2208://iphone 6+/6S+/7+/8+
                        let width = (153.4 * kScreenWidth) / 320
                        //let hight = (200.0 * kScreenWidth) / 320
                        return CGSize(width: width, height: 229)
                    case 2436://iphone X/XS
                        
                        let width = (152.8 * kScreenWidth) / 320
                        
                        //let hight = (200.0 * kScreenWidth) / 320
                        return CGSize(width: width, height: 229)
                        
                    case 2688://iphone XS Max
                        
                        //print("iphone XS Max")
                        let width = (153.5 * kScreenWidth) / 320
                        //let hight = (200.0 * kScreenWidth) / 320
                        return CGSize(width: width, height: 229)
                        
                    case 1792://iphone XR
                        //print("iphone XR")
                        let width = (153.6 * kScreenWidth) / 320
                        return CGSize(width: width, height: 229)
                    default:
                        let width = (152.6 * kScreenWidth) / 320
                        return CGSize(width: width, height: 229)
                    }
                }
            case 4://Best Product
                let width = (130.0 * kScreenWidth) / 320
                let hight = (190.0 * kScreenWidth) / 320
                return CGSize(width: width, height: hight)
            case 5://
                let width = (130.0 * kScreenWidth) / 320
                let hight = (190.0 * kScreenWidth) / 320
                return CGSize(width: width, height: hight)
            case 6://ShopByBrand
                let width = (288.0 * kScreenWidth) / 320
                let hight = (50.0 * kScreenWidth) / 320
                return CGSize(width: width, height: hight)
            case 7:
                let width = (130.0 * kScreenWidth) / 320
                let hight = (190.0 * kScreenWidth) / 320
                return CGSize(width: width, height: hight)
           case 8:
               let width = (320.0 * kScreenWidth) / 320
               let hight = (152.0 * kScreenWidth) / 320
               return CGSize(width: width, height: hight)
         case 11:
               let width = (320.0 * kScreenWidth) / 320
               let hight = (130.0 * kScreenWidth) / 320
               return CGSize(width: width, height: hight)
        case 12:
             let width = (320.0 * kScreenWidth) / 320
             let hight = (150.0 * kScreenWidth) / 320
             return CGSize(width: width, height: hight)
        case 13:
             let width = (320.0 * kScreenWidth) / 320
             let hight = (150.0 * kScreenWidth) / 320
//             return CGSize(width: width, height: 160)
            return CGSize(width: width, height: hight)
            default:
                return CGSize(width: 0.0, height: 0.0)
            }
        }
        return CGSize(width: 0.0, height: 0.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView.tag {
        case 0:
            return 10//16
        case 1:
            return 8
        case 2:
            return 8
        case 3:
            return 1
        case 4:
            return 16
        case 5:
            return 16
        case 6:
            return 4
        case 7:
            return 16
        case 8:
           return 0
        case 11:
           return 0
        case 12:
            return 0
        case 13:
            return 0
            
        default:
            return 0
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == bannerCollectionView
        {
            return 0
        }else{
            switch collectionView.tag {
            case 0:
                return 0
            case 1:
                return 0
            case 2:
                return 0
            case 3:
                return 0
                
            case 4:
                
                return 0
            case 5:
                
                return 0
            case 6:
                
                return 0
                
            case 7:
                
                return 0
            case 8:
                   
                return 0
            case 11:
                return 0
            case 12:
                return 0
            case 13:
                return 0
            default:
                return 0
            }
            
        }
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == bannerCollectionView
        {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }else{
            switch collectionView.tag {
            case 0:
//                return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
                return UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
            case 1:
                return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            case 2:
                return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            case 3:
                return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            case 4 :
                return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            case 5:
                return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            case 6:
                return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            case 7:
                return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            case 8:
                return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            case 11:
                return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            case 12:
                return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            case 13:
                return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            default:
                return UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        
        let cellVisible = Int(scrollView.contentOffset.x / kScreenWidth)
        
        pageControl.progress = Double(cellVisible)
        
        
        
        //set progress with animation
        //pageControl.set(progress: cellVisible, animated: true)
        
        //        if upperHorizontalCView.contentSize.width == upperHorizontalCView.contentOffset.x + kScreenWidth
        //        {
        //            begin = true
        //
        //        }
        
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        // Called when manually setting contentOffset
        
        scrollViewDidEndDecelerating(scrollView)
    }

    
    func productDetailsHomeVC(withProductId prodId : String, option_value_id : String)
    {
        
        
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextVC = sb.instantiateViewController(withIdentifier: ProductDetailsViewController.storyboardId()) as! ProductDetailsViewController
        print("option_value_idSunish:\(option_value_id)")
        nextVC.product_id  = prodId
        if Int.getInt(option_value_id) != 0
        {
            nextVC.option_value_id = option_value_id
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    func productListViewControllerHP(withCatId catId : String)
    {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        let nextViewController = sb.instantiateViewController(withIdentifier: ProductListViewController.storyboardId()) as! ProductListViewController
        nextViewController.catId   = catId
         
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    

    
    func productDetailVC()
    {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextViewController = sb.instantiateViewController(withIdentifier: ProductDetailsViewController.storyboardId()) as! ProductDetailsViewController
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    //#MARK:-----------callGetHomePageDataWebService---------
    private func callGetHomePageDataWebService() {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetHomePageData, requestMethod: .post, requestImages: [dictImg], withProgressHUD: false, withProgessHUDTitle: "Please  Wait", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    //gradientLayer.add(animation, forKey: "shimmerKey")
                    
                    kSharedInstance.gradientLayer.removeAnimation(forKey: "shimmerKey")
                    
                    strongSelf.shimmerImageView.removeFromSuperview()
                    strongSelf.bgImageView.removeFromSuperview()
          
                    
                    strongSelf.bgImageView.removeFromSuperview()
                    strongSelf.shimmerImageView.removeFromSuperview()
                    strongSelf.tblHome.isHidden = false
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    let offerText = kSharedInstance.getDictionary(result["offerText"])
                    strongSelf.lblOffer.text = String.getString(offerText["content"])
                    let sliderData = kSharedInstance.getArray(result["sliderData"])
                    strongSelf.sliderDataArr = sliderData
                    strongSelf.pageControl.numberOfPages = sliderData.count
                    
                    strongSelf.afterSlider = kSharedInstance.getDictionary(result["afterSlider"])
                    
                    strongSelf.topSellingData = kSharedInstance.getArray(result["topSellingData"])
                    strongSelf.topSellingCount = kSharedInstance.getArray(result["topSellingData"]).count
                    strongSelf.categoryData = kSharedInstance.getArray(result["categoryData"])
                    
                    strongSelf.todayDeal = kSharedInstance.getDictionary(result["todayDeal"])
                    
                    //print(strongSelf.todayDeal)
                    
                    strongSelf.todayDealArrData = kSharedInstance.getArray(strongSelf.todayDeal["data"])
                    
                    strongSelf.afterTodayDeal = kSharedInstance.getArray(result["afterTodayDeal"])
                    
                   // strongSelf.afterTodayDealDictData = kSharedInstance.getDictionary(strongSelf.afterTodayDeal[0])
                    
                    let videoData = kSharedInstance.getArray(result["videoData"])
                    
                    strongSelf.videoDictData = kSharedInstance.getDictionary(videoData[0])
                    
                    strongSelf.bestOfDictData = kSharedInstance.getDictionary(result["bestOf"])
                    
                    let bestofData = kSharedInstance.getDictionary(result["bestOf"])
                    
                    
                    strongSelf.bestofProdName = String.getString(bestofData["name"])
                    
                    strongSelf.bestOfArrCount = kSharedInstance.getArray(strongSelf.bestOfDictData["data"]).count
                    
                    strongSelf.bestOfArray = kSharedInstance.getArray(strongSelf.bestOfDictData["data"])
                    
                    //let afterBestOfData = kSharedInstance.getArray(result["afterBestOfData"])
                    
                    strongSelf.afterBestOfferBanner = kSharedInstance.getArray(result["afterBestOfData"])
                    
                    strongSelf.recentlyViewedArray = kSharedInstance.getArray(result["recentlyViewData"])
                    strongSelf.recentlyViewedCount = kSharedInstance.getArray(result["recentlyViewData"]).count
                    
                    strongSelf.shopByBrandArr  = kSharedInstance.getArray(result["shopByBrandData"])
                    strongSelf.afterShopByData = kSharedInstance.getArray(result["afterShopByData"])
                    
                    strongSelf.recommendedData = kSharedInstance.getArray(result["recommendedData"])
                    strongSelf.recommendedProdCount = kSharedInstance.getArray(result["recommendedData"]).count
                    
                    
                    let footerBannerData = kSharedInstance.getArray(result["footerBannerData"])
                    
                    strongSelf.footerBannerData = footerBannerData
                    
                    strongSelf.tblHome.reloadData()
                    strongSelf.bannerCollectionView.reloadData()
                    
                }
                
            }
            else if errorType == .requestFailed
            {
                strongSelf.tblHome.isHidden = true
                
                kSharedInstance.gradientLayer.removeAnimation(forKey: "shimmerKey")
                                   
                strongSelf.shimmerImageView.removeFromSuperview()
                strongSelf.bgImageView.removeFromSuperview()
                
                strongSelf.bgImageView.removeFromSuperview()
                strongSelf.shimmerImageView.removeFromSuperview()
                
                UIApplication.shared.endIgnoringInteractionEvents()
            }
            else
            {
                
            }
        })
    }
    
    
    
    
    //#MARK:-----------callLoginWebService---------
    private func callGetCartDataWebServiceHM()
    {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetCartData, requestMethod: .post, requestImages: [dictImg], withProgressHUD: false, withProgessHUDTitle: "", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
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
    
    
    
    
    
//    func showCartCount(withCartCount count : String)
//    {
//        if let tabItems = tabBarController?.tabBar.items {
//            // In this case we want to modify the badge number of the third tab:
//            let tabItem = tabItems[4]
//            
//            if String.getLength(count) != 0
//            {
//                tabItem.badgeValue = "\(count)"
//            }
//            
//        }
//    }
    
//    func shopByBrandVC()
//    {
//        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
//
//        let nextViewController = sb.instantiateViewController(withIdentifier: ShopByBrandVC.storyboardId()) as! ShopByBrandVC
//
//        self.navigationController?.pushViewController(nextViewController, animated: true)
//    }
    
    func shopByBrandListVC()
    {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextViewController = sb.instantiateViewController(withIdentifier: ShopByBrandListVC.storyboardId()) as! ShopByBrandListVC
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func categoryDetailVC(withserviceName serviceName : String, HeaderTitle title: String, withId id : Int)
    {
        
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextViewController = sb.instantiateViewController(withIdentifier: CategoryDetailVC.storyboardId()) as! CategoryDetailVC
        
        
        nextViewController.headerTitle = title
        nextViewController.serviceName = serviceName
        nextViewController.idNo        = id
        nextViewController.brandId     = ""
        
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}
