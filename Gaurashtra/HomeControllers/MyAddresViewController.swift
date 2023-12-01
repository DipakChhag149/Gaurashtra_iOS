//
//  MyAddresViewController.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 20/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class MyAddresViewController: GaurashtraBaseVC {

    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var btnDeliveryHere: UIButton!
    
   // @IBOutlet weak var addressView: UIView!
    
//    @IBOutlet weak var txtFieldFName: UITextField!
//
//    @IBOutlet weak var txtFieldLastName: UITextField!
//
//    @IBOutlet weak var txtFieldPhoneNo: UITextField!
//
//    @IBOutlet weak var txtFieldCompany: UITextField!
//
//    @IBOutlet weak var txtFieldAddress1: UITextField!
//
//    @IBOutlet weak var txtFieldAddress2: UITextField!
//
//    @IBOutlet weak var txtFieldCity: UITextField!
//
//    @IBOutlet weak var txtFieldPostCode: UITextField!
//
//    @IBOutlet weak var txtFieldCountryName: UITextField!
//
//    @IBOutlet weak var txtFieldState: UITextField!
//
//    @IBOutlet weak var btnSwitch: UISwitch!
//
    var countryArrList    : [String] = []
    var arrListCountry_id : [String] = []
    
    var zoneArrList    : [String] = []
    var arrListZone_id : [String] = []
    
    var defaultAddress : Dictionary<String,Any> = ["":""]
    
    var controllerId : Int = 0
    
    var addressData : Dictionary<String,Any> = ["":""]
    
    
    @IBOutlet weak var myAddressTbl: UITableView!
 
    private var dictParams = [kUserId      : "",
                              kFirstName   : "",
                              kLastName    : "",
                              kAddress1    : "",
                              kAddress2    : "",
                              kCity        : "",
                              kPostcode    : "",
                              kCountry     : "",
                              kState       : "",
                              kDef_address : "",
                              kCompany     : "",
                              kTelephone   : "",
                              kAddressId   : ""]
    
     private var dictParamsCList  = [kUserId      : ""]
     private var dictParamsSList  = [kCountryid   : ""]
    
    var userAddressData : [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dictParams[kDef_address]    = "N"
        self.getDevice()
         
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        if let indexPath = myAddressTbl.indexPathForSelectedRow {
            myAddressTbl.deselectRow(at: indexPath, animated: true)
        }
        
        self.btnDeliveryHere.isEnabled = false
        self.btnDeliveryHere.alpha     = 0.5
        self.callCountryListWebService()
        
        if Int.getInt(controllerId) == 1 || Int.getInt(controllerId) == 2
        {
            self.btnDeliveryHere.isHidden = true
            
        }else{
            
            self.btnDeliveryHere.isHidden = false
        }
        self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        self.callAddressListWebService()
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
    
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
//    @IBAction func makeDefaultAddress(_ sender: UISwitch) {
//
//        if self.btnSwitch.isOn == true
//        {
//            self.dictParams[kDef_address]    = "Y"
//
//        }else{
//
//            self.dictParams[kDef_address]    = "N"
//
//        }
//    }
    
    
    
//    @IBAction func tapToSelectCountry(_ sender: UIButton) {
//
//        let picker = RSPickerView.init(view: self.view, arrayList: self.countryArrList, keyValue: nil, handler: { (selectedIndex: NSInteger, response: Any?) in
//
//            self.txtFieldCountryName.text = String.getString(self.countryArrList[selectedIndex])
//            self.dictParams[kCountry]     = String.getString(self.arrListCountry_id[selectedIndex])
//             self.dictParamsSList[kCountryid]     = String.getString(self.arrListCountry_id[selectedIndex])
//
//            if String.getLength(self.dictParamsSList[kCountryid]) != 0
//            {
//                self.callStateListWebService()
//            }
//
//        })
//        picker.viewContainer.backgroundColor = kWhiteColor
//
//    }
//
//
//    @IBAction func tapToSelectStates(_ sender: UIButton) {
//
//
//        if self.self.zoneArrList.count != 0
//        {
//            let picker = RSPickerView.init(view: self.view, arrayList: self.zoneArrList, keyValue: nil, handler: { (selectedIndex: NSInteger, response: Any?) in
//
//                self.txtFieldState.text = String.getString(self.zoneArrList[selectedIndex])
//                self.dictParams[kState]     = String.getString(self.arrListZone_id[selectedIndex])
//            })
//            picker.viewContainer.backgroundColor = kWhiteColor
//        }else{
//            showOkAlert2(withMessage: "Please select country")
//        }
//    }
//
//    @IBAction func tapToSaveAddress(_ sender: UIButton) {
//
//        self.dictParams[kFirstName]      = String.getString( self.txtFieldFName.text)
//        self.dictParams[kLastName]       = String.getString(self.txtFieldLastName.text)
//        self.dictParams[kAddress1]       = String.getString(self.txtFieldAddress1.text)
//        self.dictParams[kAddress2]       = String.getString(self.txtFieldAddress2.text)
//        self.dictParams[kCity]           = String.getString(self.txtFieldCity.text)
//        self.dictParams[kPostcode]       = String.getString(self.txtFieldPostCode.text)
//        self.dictParams[kTelephone]      = String.getString(self.txtFieldPhoneNo.text)
//        self.dictParams[kCompany]        = String.getString(self.txtFieldCompany.text)
//        self.checkValidation()
//    }
//
//
//    func checkValidation()
//    {
//        if String.getLength(self.dictParams[kFirstName]) == 0
//        {
//            self.showOkAlert(withMessage: kEnterFirstName)
//
//        }else if String.getLength(self.dictParams[kLastName]) == 0
//        {
//            self.showOkAlert(withMessage: kEnterLastName)
//
//        }else if String.getLength(self.dictParams[kAddress1]) == 0
//        {
//            self.showOkAlert(withMessage: kEnterAddress1)
//
//        }else if String.getLength(self.dictParams[kAddress2]) == 0
//        {
//            self.showOkAlert(withMessage: kEnterAddress2)
//
//        }else if String.getLength(self.dictParams[kPostcode]) == 0
//        {
//            self.showOkAlert(withMessage: kEnterPostCode)
//
//        }else if String.getLength(self.dictParams[kCountry]) == 0
//        {
//            self.showOkAlert(withMessage: kSelectCountry)
//
//        }else if String.getLength(self.dictParams[kState]) == 0
//        {
//            self.showOkAlert(withMessage: kSelectState)
//
//        }else{
//
//            if isInternetAvailable()
//            {
//                self.callAddOrEditAddressWebService()
//            }else{
//
//                self.showOkAlert(withMessage: kNetworkErrorAlert)
//            }
//        }
//    }
//
    @IBAction func tapToAddNewAddress(_ sender: UIButton) {
        let data : Dictionary<String,Any> = ["":""]
        self.addOrEditAddress(withAddOrEdit: 1, dictData: data)
    }
    func addOrEditAddress(withAddOrEdit addEdit : Int , dictData : Dictionary<String,Any>)
    {
       let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
       let nextVc = sb.instantiateViewController(withIdentifier: AddNewAddressVC.storyboardId()) as! AddNewAddressVC
        nextVc.userAddress = dictData
        nextVc.editOrAdd   = addEdit
       self.navigationController?.pushViewController(nextVc, animated: true)
    }
    @IBAction func tapToDeliverHere(_ sender: UIButton) {
        
        
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextVC = sb.instantiateViewController(withIdentifier: ConfirmOrderVC.storyboardId()) as! ConfirmOrderVC
        
        nextVC.addDictData    = self.addressData
        nextVC.defaultAddress = self.defaultAddress
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        
        
    }
    
}
//#MARK:  UITableViewDelegate,UITableViewDataSource 
extension MyAddresViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userAddressData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myAddressTbl.dequeueReusableCell(withIdentifier: AddressTVC.cellIdentifier(), for: indexPath) as! AddressTVC
        
        cell.configureCell(withDictData: kSharedInstance.getDictionary(self.userAddressData[indexPath.row]), forIndxPath: indexPath, buttonEdit: { (buttonEdit : UIButton) in
            
            let dictData = kSharedInstance.getDictionary(self.userAddressData[indexPath.item])
            //print(dictData)
            self.addOrEditAddress(withAddOrEdit: 2, dictData: dictData)
//            let firstname = String.getString(dictData["firstname"])
//            let lastname = String.getString(dictData["lastname"])
//            let address_1 = String.getString(dictData["address_1"])
//            let address_2 = String.getString(dictData["address_2"])
//            let city      = String.getString(dictData["city"])
//            let postcode  = String.getString(dictData["postcode"])
//            let phoneNo   = String.getString(dictData["custom_field"])
//            let company   = String.getString(dictData["company"])
//            let address_id = String.getString(dictData["address_id"])
//            let country_id = String.getString(dictData["country_id"])
//            let zone_id    = String.getString(dictData["zone_id"])
//            
//            
//            self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
//           
//            self.dictParams[kFirstName]      = String.getString(firstname)
//            self.dictParams[kLastName]       = String.getString(lastname)
//            self.dictParams[kAddress1]       = String.getString(address_1)
//            self.dictParams[kAddress2]       = String.getString(address_2)
//            self.dictParams[kCity]           = String.getString(city)
//            self.dictParams[kPostcode]       = String.getString(postcode)
//            self.dictParams[kCountry]        = String.getString(country_id)
//            self.dictParams[kState]          = String.getString(zone_id)
//            
//            self.dictParams[kTelephone]      = String.getString(phoneNo)
//            self.dictParams[kAddressId]      = String.getString(address_id)
//            self.dictParams[kCompany]        = String.getString(company)
//            
//            self.txtFieldFName.text    = firstname
//            self.txtFieldLastName.text = lastname
//            self.txtFieldPhoneNo.text  = phoneNo
//            self.txtFieldCompany.text  = company
//            self.txtFieldAddress1.text = address_1
//            self.txtFieldAddress2.text = address_2
//            self.txtFieldCity.text     = city
//            self.txtFieldPostCode.text = postcode
//            self.txtFieldCountryName.text =
//            self.txtFieldState.text    =
            

            
            //print("Edit")
        })
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        for addData in self.userAddressData
        {
            
           let dictAddData = kSharedInstance.getDictionary(addData)
            
            let address_id = String.getString(dictAddData["address_id"])
            let default_address_id  = String.getString(dictAddData["default_address_id"])
            //print(address_id)
            //print(default_address_id)
            if String.getString(address_id) == String.getString(default_address_id)
            {
               self.defaultAddress = dictAddData
                //print(dictAddData)
            }
        }
          self.addressData = kSharedInstance.getDictionary(self.userAddressData[indexPath.item])
        
        self.btnDeliveryHere.isEnabled = true
        self.btnDeliveryHere.alpha     = 1.0
        
       // self.isSelectAddress = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    
    //#MARK:-----------callLoginWebService---------
    private func callCountryListWebService()
    {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetCountryList, requestMethod: .post, requestImages: [dictImg], withProgressHUD: false, withProgessHUDTitle: "Please Wait...", requestVideos: [String:  Any](), requestData: dictParamsCList, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
               
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                  
                    //print(result)
                    let arrCountryData = kSharedInstance.getArray(result["countryData"])
                    //print(arrCountryData)
                    
                    for dict in arrCountryData
                    {
                        let dic = kSharedInstance.getDictionary(dict)
                        
                        //print(dic)
                        
                        let countryName = String.getString(dic["name"])
                        let country_id = String.getString(dic["country_id"])
                        
                     
                        strongSelf.countryArrList.append(countryName)
                        
                        //print(strongSelf.countryArrList)
                        
                        strongSelf.arrListCountry_id.append(country_id)
                        
                    }
                    
                    
                    
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
    
    //#MARK:-----------callLoginWebService---------
    private func callStateListWebService()
    {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetZoneList, requestMethod: .post, requestImages: [dictImg], withProgressHUD: false, withProgessHUDTitle: "Please Wait...", requestVideos: [String:  Any](), requestData: dictParamsSList, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    
                    //print(result)
                    let arrZoneData = kSharedInstance.getArray(result["zoneData"])
                    //print(arrZoneData)
                    
                    for dict in arrZoneData
                    {
                        let dic = kSharedInstance.getDictionary(dict)
                        
                        //print(dic)
                        
                        let name = String.getString(dic["name"])
                        let zone_id = String.getString(dic["zone_id"])
                        
                        
                        strongSelf.zoneArrList.append(name)
                       
                        
                        strongSelf.arrListZone_id.append(zone_id)
                        
                    }
                    
                    
                    
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
    
    
    
    //#MARK:-----------callLoginWebService---------
    private func callAddOrEditAddressWebService()
    {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetAddEditAddress, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait...", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
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
                    strongSelf.callAddressListWebService()
                    
                    strongSelf.showOkAlert(withMessage: String.getString(dictResponse[kMessage]))
                    
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
    
    //kGetCountryList kGetZoneList
    
    //#MARK:-----------callLoginWebService---------
    private func callAddressListWebService()
    {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetAddressList, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Please Wait...", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                //                strongSelf.imgProfile.image = strongSelf.img
                //                self?.callgetStateWebService() 
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    
                    
                    strongSelf.userAddressData = kSharedInstance.getArray(result["userAddressData"])
               
                    strongSelf.myAddressTbl.reloadData()
                    
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
}
