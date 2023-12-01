//
//  SearchViewController.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 05/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit
import SWRevealViewController
import CoreData


class SearchViewController: GaurashtraBaseVC {
    
    
    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var searchConstH: NSLayoutConstraint!
    
    var arrSearchName : [String] = []
    
    @IBOutlet weak var tblSearch: UITableView!
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var clearView: UIView!
    
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    var searchActive : Bool = false
    
    var searchHistoryList : [Any] = []
    
    
    var searchProduct : [Any] = []
    
     fileprivate var dictParams =  [kSearchtext  : ""]
    
    private var dictParamsCurr = [kCode   : ""]
       
       
    var titleStr  : [String] = []
    var codeStr   : [String] = []
    var valueStr  : [String] = []
    var symbolStr : [String] = []
       

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDevice()
        self.callGetCurrencyListWebServiceHM()
      
        //self.tblSearch.estimatedRowHeight = 150
        //self.tblSearch.rowHeight          = UITableView.automaticDimension
        
        btnMenu.target = revealViewController()
        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))

      
        self.search.placeholder = "Search"
       // self.search.tintColor = .blue
        
        self.search.barTintColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        
       self.searchConstH.constant = 50
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.search.becomeFirstResponder()
        let userId = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        if String.getLength(userId) == 0
        {
           if let tabItems = self.tabBarController?.tabBar.items {
              let tabItem = tabItems[4]
              tabItem.badgeValue = nil
        }
   }
//        arrSearchName  = Search.getAllSearchList().map { (favData: Search) -> String in
//            return String.getString(favData.name)
//        }
//
//        if Int.getInt(arrSearchName.count) != 0
//        {
//            self.clearView.isHidden = false
//        }else{
//            self.clearView.isHidden = true
//        }
//
//        self.tblSearch.reloadData()
        
    }
    
    @IBAction func tapToClearSearch(_ sender: UIButton) {
        
        
        let items  = Search.getAllSearchList().map { (favData: Search) -> String in
            return String.getString(favData.name)
        }
        for item in items {
           Search.deleteSearchData(withSearchName: String.getString(item))
        }
        
        self.arrSearchName.removeAll()
        
        
        if Int.getInt(items) == 0
        {
          self.clearView.isHidden = true
        }
        
        
        self.tblSearch.reloadData()
        
    }
    
    @IBAction func tapToMyCart(_ sender: UIBarButtonItem) {
      
        self.notificationVC()
     
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
              
              
           //    self.searchProduct.removeAll()
             //  self.tblSearch.reloadData()
            
               if String.getLength(self.search.text) != 0
               {
                  self.searchProduct.removeAll()
                  self.tblSearch.reloadData()
                  
                   self.callGlobalSearchService(withSearchTxt: String.getString(self.search.text))
               }
        
                             
               })
           
                picker.viewContainer.backgroundColor = kWhiteColor
                   
               }else{
               
                self.view.makeToast("Loading Please Wait")
               
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
                 //print("unknown")
                 break
                 
             }
             
         }
         
     }
   
    
}
extension SearchViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return searchProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblSearch.dequeueReusableCell(withIdentifier: SearchTVC.cellIdentifier(), for: indexPath) as! SearchTVC
      //  let newArrData = arrSearchName.reversed()
        
        cell.configureSerchCell(withDictData: kSharedInstance.getDictionary(self.searchProduct[indexPath.row]), forIndxPath: indexPath)
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dictData = kSharedInstance.getDictionary(self.searchProduct[indexPath.row])
        
        self.productDetailsSearchVC(withProductId: String.getString(dictData["product_id"]), option_value_id: String.getString(dictData["option_value_id"]))
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
    
}
extension SearchViewController : UISearchBarDelegate
{
    
    
    func searchBarTextDidBeginEditing(_ search: UISearchBar) {

        searchActive = true
        search.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ search: UISearchBar) {
       
        searchActive = false
        search.showsCancelButton = false
    }
    
    
    func searchBarCancelButtonClicked(_ search: UISearchBar)
    {
       
        searchActive = false;
        search.text = ""
        search.showsCancelButton = false
        search.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ search: UISearchBar)
    {
        
//        let searchTxt = String.getString(search.text)
//
//        if String.getLength(searchTxt) != 0
//        {
//            Search.addSearchData(withSearchName: searchTxt)
//        }
        
       
        
        if String.getLength(self.search.text) != 0
        {
            self.searchProduct.removeAll()
            self.tblSearch.reloadData()
            
             self.callGlobalSearchService(withSearchTxt: String.getString(self.search.text))
        }
        
       
        
        self.search.showsCancelButton = false
        searchActive = false
        search.endEditing(true)
       
        
      
    }
    
    func searchBar(_ search: UISearchBar, textDidChange searchText: String)
    {
     
        self.search.showsCancelButton = true
        
        //print("TapSearch")
     
    }
    
  
    
    func searchBar(_ search: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        //self.searchProduct.removeAll()
       // self.tblSearch.reloadData()
       // self.callGlobalSearchService(withSearchTxt: String.getString(self.search.text))
      

        return true

    }
    
    //#MARK:-----------callLoginWebService---------
    private func callGlobalSearchService(withSearchTxt searchText : String)
    {
        
        let dict = [kSearchtext : searchText]
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGlobalSearch, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Searching...", requestVideos: [String:  Any](), requestData: dict, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                //                strongSelf.imgProfile.image = strongSelf.img
                //                self?.callgetStateWebService()
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    
                    strongSelf.searchProduct = kSharedInstance.getArray(result["productData"])
                 
                    strongSelf.tblSearch.reloadData()
                    
                    
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
    
    
    
    
    
    func productDetailsSearchVC(withProductId prodId : String ,option_value_id : String)
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
    
}
