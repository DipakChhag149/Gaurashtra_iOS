//
//  AddNewAddressVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 20/03/20.
//  Copyright © 2020 Gaurashtra. All rights reserved.
//

import UIKit

class AddNewAddressVC: GaurashtraBaseVC {
    @IBOutlet weak var txtFieldFName: UITextField!
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var txtFieldLastName: UITextField!
    
    @IBOutlet weak var txtFieldPhoneNo: UITextField!
    
    @IBOutlet weak var txtFieldCompany: UITextField!
    
    @IBOutlet weak var txtFieldAddress1: UITextField!
    
    @IBOutlet weak var txtFieldAddress2: UITextField!
    
    @IBOutlet weak var txtFieldCity: UITextField!
    
    @IBOutlet weak var txtFieldPostCode: UITextField!
    
    @IBOutlet weak var txtFieldCountryName: UITextField!
    
    @IBOutlet weak var txtFieldState: UITextField!
    
    @IBOutlet weak var btnSwitch: UISwitch!
    
    var countryArrList    : [String] = []
    var arrListCountry_id : [String] = []
    
    var zoneArrList    : [String] = []
    var arrListZone_id : [String] = []
    
    var userAddress : Dictionary<String,Any> = ["":""]
    
    var controllerId : Int = 0
    var editOrAdd    : Int = 0
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDevice()
        self.dictParams[kDef_address]    = "N"
         self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.callCountryListWebService()
        if Int.getInt(self.editOrAdd) == 2
        {
            self.lblHeader.text  = "Edit Address"
            self.lblAddress.text = "Edit Address"
           let firstname = String.getString(userAddress["firstname"])
           let lastname = String.getString(userAddress["lastname"])
           let address_1 = String.getString(userAddress["address_1"])
           let address_2 = String.getString(userAddress["address_2"])
           let city      = String.getString(userAddress["city"])
           let postcode  = String.getString(userAddress["postcode"])
           let phoneNo   = String.getString(userAddress["custom_field"])
           let company   = String.getString(userAddress["company"])
           let address_id = String.getString(userAddress["address_id"])
           let country_id = String.getString(userAddress["country_id"])
           let zone_id    = String.getString(userAddress["zone_id"])
           self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
          
           self.dictParams[kFirstName]      = String.getString(firstname)
           self.dictParams[kLastName]       = String.getString(lastname)
           self.dictParams[kAddress1]       = String.getString(address_1)
           self.dictParams[kAddress2]       = String.getString(address_2)
           self.dictParams[kCity]           = String.getString(city)
           self.dictParams[kPostcode]       = String.getString(postcode)
           self.dictParams[kCountry]        = String.getString(country_id)
           self.dictParams[kState]          = String.getString(zone_id)
           
           self.dictParams[kTelephone]      = String.getString(phoneNo)
           self.dictParams[kAddressId]      = String.getString(address_id)
           self.dictParams[kCompany]        = String.getString(company)
           
           self.txtFieldFName.text    = firstname
           self.txtFieldLastName.text = lastname
           self.txtFieldPhoneNo.text  = phoneNo
           self.txtFieldCompany.text  = company
           self.txtFieldAddress1.text = address_1
           self.txtFieldAddress2.text = address_2
           self.txtFieldCity.text     = city
           self.txtFieldPostCode.text = postcode
        }else{
            self.lblHeader.text  = "Add New Address"
            self.lblAddress.text = "Add New Address"
        }
    }
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func mobileTxtAction(_ sender: UITextField) {
        
        let lenght = txtFieldPhoneNo.text?.count
        let txtStr = txtFieldPhoneNo.text
        if (lenght! >= 10)
        {
           let indx = txtStr?.index((txtStr?.startIndex)!, offsetBy: 10)
           txtFieldPhoneNo.text = txtFieldPhoneNo.text?.substring(to: indx!)
        }
        
    }
    
    @IBAction func txtFpinCodeAction(_ sender: UITextField) {
        
        let lenght = txtFieldPostCode.text?.count
        let txtStr = txtFieldPostCode.text
        if (lenght! >= 6)
        {
           let indx = txtStr?.index((txtStr?.startIndex)!, offsetBy: 6)
           txtFieldPostCode.text = txtFieldPostCode.text?.substring(to: indx!)
        }
        
    }
  
    
    func getDevice()
      {
          if UIDevice().userInterfaceIdiom == .phone {
              switch UIScreen.main.nativeBounds.height {
              case 1136://iphone 5/5S/SE
                  
                  self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 12)
                  
                  //self.headerViewConstraintH.constant = 64
                  
              case 1334://iphone 6/6S/7/8
                  self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 15)
                  //self.headerViewConstraintH.constant = 64
              case 2208://iphone 6+/6S+/7+/8+
                  
                  self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
                  //self.headerViewConstraintH.constant = 64
              case 2436://iphone X/XS
                  
                  self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
                  //self.headerViewConstraintH.constant = 84
                  //print("iphone XS")
                  
              case 2688,2778://iphone XS Max
                  
                  //print("iphone XS Max")
                  //self.headerViewConstraintH.constant = 84
                  self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
                  
              case 1792://iphone XR
                  //self.headerViewConstraintH.constant = 84
                  self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
              default:
                self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
                  
              }
              
          }
          
      }
    
    
    @IBAction func tapToSelectCountry(_ sender: UIButton) {
        let picker = RSPickerView.init(view: self.view, arrayList: self.countryArrList, keyValue: nil, handler: { (selectedIndex: NSInteger, response: Any?) in
               self.txtFieldCountryName.text = String.getString(self.countryArrList[selectedIndex])
               self.dictParams[kCountry]     = String.getString(self.arrListCountry_id[selectedIndex])
                self.dictParamsSList[kCountryid]     = String.getString(self.arrListCountry_id[selectedIndex])
               if String.getLength(self.dictParamsSList[kCountryid]) != 0
               {
                   self.callStateListWebService()
               }
           })
           picker.viewContainer.backgroundColor = kWhiteColor
    }
    
    @IBAction func btnSwitchAction(_ sender: UISwitch) {
        if self.btnSwitch.isOn == true
        {
            self.dictParams[kDef_address]    = "Y"
        }else{
            self.dictParams[kDef_address]    = "N"
        }
    }
    @IBAction func tapToSave(_ sender: UIButton) {
        self.dictParams[kFirstName]      = String.getString( self.txtFieldFName.text)
               self.dictParams[kLastName]       = String.getString(self.txtFieldLastName.text)
               self.dictParams[kAddress1]       = String.getString(self.txtFieldAddress1.text)
               self.dictParams[kAddress2]       = String.getString(self.txtFieldAddress2.text)
               self.dictParams[kCity]           = String.getString(self.txtFieldCity.text)
               self.dictParams[kPostcode]       = String.getString(self.txtFieldPostCode.text)
               self.dictParams[kTelephone]      = String.getString(self.txtFieldPhoneNo.text)
               self.dictParams[kCompany]        = String.getString(self.txtFieldCompany.text)
               self.checkValidation()
           }
           
           func checkValidation()
           {
               if String.getLength(self.dictParams[kFirstName]) == 0
               {
                   self.showOkAlert(withMessage: kEnterFirstName)
                   
               }else if String.getLength(self.dictParams[kLastName]) == 0
               {
                   self.showOkAlert(withMessage: kEnterLastName)
                   
               }else if String.getLength(self.dictParams[kAddress1]) == 0
               {
                   self.showOkAlert(withMessage: kEnterAddress1)
                   
               }else if String.getLength(self.dictParams[kAddress2]) == 0
               {
                   self.showOkAlert(withMessage: kEnterAddress2)
                   
               }else if String.getLength(self.dictParams[kPostcode]) == 0
               {
                   self.showOkAlert(withMessage: kEnterPostCode)
                   
               }else if String.getLength(self.dictParams[kCountry]) == 0
               {
                   self.showOkAlert(withMessage: kSelectCountry)
                   
               }else if String.getLength(self.dictParams[kState]) == 0
               {
                   self.showOkAlert(withMessage: kSelectState)

               }else{
                   
                   if isInternetAvailable()
                   {
                       self.callAddOrEditAddressWebService()
                   }else{
                       
                       self.showOkAlert(withMessage: kNetworkErrorAlert)
                   }
                   
               }
               
    }
    
    @IBAction func tapToSelectState(_ sender: UIButton) {
        if self.self.zoneArrList.count != 0
         {
             let picker = RSPickerView.init(view: self.view, arrayList: self.zoneArrList, keyValue: nil, handler: { (selectedIndex: NSInteger, response: Any?) in
                 self.txtFieldState.text = String.getString(self.zoneArrList[selectedIndex])
                 self.dictParams[kState]     = String.getString(self.arrListZone_id[selectedIndex])
             })
             picker.viewContainer.backgroundColor = kWhiteColor
         }else{
             showOkAlert2(withMessage: "Please select country")
         }
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
    
}
