//
//  ContactUsVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 03/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit
import SWRevealViewController

class ContactUsVC: GaurashtraBaseVC,UITextViewDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    let picker:UIImagePickerController? = UIImagePickerController()

    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var lblContactNumber: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    
    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var txtField: UITextField!
    
    @IBOutlet weak var txtView: UITextView!
    
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    
    //username, email, subject, query
    var mobileNo : String = ""
    private var dictParams = [kUsername  : "",
                              kEmail     : "",
                              kQuery     : "",
                              kSubject   : ""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNeedsStatusBarAppearanceUpdate()
        self.getDevice()
        btnMenu.target = revealViewController()
        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        txtView.delegate = self
        txtView.text = "Message"
        txtView.textColor = UIColor.lightGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.callgetContactUsContentWebService()
        
    }
    
    @IBAction func tapToSubmit(_ sender: UIButton) {
        
        let userName = String.getString(LoginDataModel.getLoggedInUserDetails().firstName)
        if String.getLength(userName) != 0
        {
            self.dictParams[kUsername] = String.getString(LoginDataModel.getLoggedInUserDetails().firstName) + " " + String.getString(LoginDataModel.getLoggedInUserDetails().lastName)
        }else{
            self.dictParams[kUsername] = "test"
        }
        
        self.dictParams[kEmail] = String.getString(LoginDataModel.getLoggedInUserDetails().email)
        self.dictParams[kQuery] = String.getString(txtView.text)
        if txtView.textColor != UIColor.lightGray {
            self.dictParams[kQuery] = String.getString(self.txtView.text)
        }
        self.checkValidation()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtView.textColor == UIColor.lightGray {
            txtView.text = nil
            txtView.textColor = UIColor.black
        }
    }
    
    
    
    @IBAction func tapToSelectSubject(_ sender: UIButton) {
        let picker = RSPickerView.init(view: self.view, arrayList: kSelectSubjectsList, keyValue: nil, handler: { (selectedIndex: NSInteger, response: Any?) in
        self.dictParams[kSubject] = kSelectSubjectsList[selectedIndex]
        self.lblSubject.text      = kSelectSubjectsList[selectedIndex]
        })
        picker.viewContainer.backgroundColor = kWhiteColor
        
    }
    
    //username, email, subject, query
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtView.text.isEmpty {
            txtView.text = "Message"
            txtView.textColor = UIColor.lightGray
        }
    }
    
    
    @IBAction func tapToCall(_ sender: UIButton) {
        
//        if let url = NSURL(string: "tel://\(mobileNo)"), UIApplication.shared.canOpenURL(url as URL) {
//            UIApplication.shared.openURL(url as URL)
//        }
        //print(mobileNo)
        
        guard let number = URL(string: "tel://\(mobileNo)") else { return }
        UIApplication.shared.open(number)
        
    }
    
    @IBAction func tapToSelectImage(_ sender: UIButton) {
        self.pickImageFromGalleryOrCamera()
    }
    //MARK:-openGallary-
    
    func openGallary()
    {
        
        picker?.delegate = self
        picker?.allowsEditing = true
        
        picker?.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(picker!, animated: true)  {
            self.picker?.delegate = self
            
        }
        
        
    }
    
    //MARK: - UIImagePickerController  Delegates -
    
    func openCamera()
    {
        if(UIImagePickerController.isSourceTypeAvailable(.camera))
        {
            
            picker?.delegate = self
            picker?.allowsEditing = true
            //            picker?.sourceType = UIImagePickerControllerSourceType.camera
            picker?.sourceType = .camera
            
            present(picker!, animated: true)  {
                self.picker?.delegate = self
            }
            
        }
        else{
            let alert = UIAlertController(title: kCameraNotFound, message: kThisdevicehasNoCamera, preferredStyle: .alert)
            let ok = UIAlertAction(title: kCancel, style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func pickImageFromGalleryOrCamera()
    {
        let settingsActionSheet: UIAlertController = UIAlertController(title:nil, message:nil, preferredStyle:UIAlertController.Style.actionSheet)
        settingsActionSheet.addAction(UIAlertAction(title:kChooseFromCamera, style:UIAlertAction.Style.default, handler:{ action in
            
            ////print("camera")
            
            self.openCamera()
        }))
        settingsActionSheet.addAction(UIAlertAction(title:kChooseFromGaller, style:UIAlertAction.Style.default, handler:{ action in
            self.openGallary()
        }))
        settingsActionSheet.addAction(UIAlertAction(title:kCancel, style:UIAlertAction.Style.cancel, handler:nil))
        
        if let popoverController = settingsActionSheet.popoverPresentationController {
            popoverController.sourceView = self.view
        }
        self.present(settingsActionSheet, animated:true, completion:nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
    {
        let chosenImage = info[.originalImage] as! UIImage
        self.imgView.image = kSharedInstance.imageOrientation(chosenImage)
     
     //self.callUpdateProfileImageWebService(withImage: kSharedInstance.imageOrientation(chosenImage))
        
        self.dismiss(animated: true, completion: nil)
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
    func checkValidation()
    {
        if String.getLength(self.dictParams[kSubject]) == 0
        {
             self.view.makeToast("Select Subject", duration: 1.5, position: .center)
        }else if String.getLength(self.dictParams[kQuery]) == 0 || txtView.textColor == UIColor.lightGray
        {
            self.view.makeToast(kEnterMessage, duration: 1.5, position: .center)
        }else{
            
            if isInternetAvailable()
            {
                self.callSetOrderReportWebService()
                
            }else{
                
                self.view.makeToast(kNetworkErrorAlert, duration: 1.5, position: .center)
            }
            
        }
        
    }
    
    //#MARK: callSetOrderReportWebService 
    private func callSetOrderReportWebService()
    {
        var dictImg:[String : Any] = ["":""]
        if self.imgView.image == nil{
            dictImg  = ["image" : UIImage(),
                        "imageName" : "uploaded_file"]
        }else{
            dictImg = ["image" : self.imgView.image!,
                       "imageName" : "imageAttached"]
        }
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kContactUs, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Sending...", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                let dictResponse = kSharedInstance.getDictionary(response)
                if Int.getInt(dictResponse["success"]) == 1
                {
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
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
    
    private func callgetContactUsContentWebService()
         {
          let dictData : [String:String] = ["":""]
      
    
          let apiURL = kBASEURL +  "getContactUsContent"
            TANetworkManager.sharedInstance.requestApi(withServiceName: apiURL, requestMethod: .GET, requestParameters: dictData, withProgressHUD: false, withProgressHUDTitle: "Please Wait")
             {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
              
                guard let strongSelf = self else { return }
            
              
                 if errorType == .requestSuccess
                 {
                     let dictResponse = kSharedInstance.getDictionary(response)
                     //print("Response:\(dictResponse)")
                      
                     if (Int.getInt(dictResponse["success"]) == 1)
                     {
                          let result = kSharedInstance.getDictionary(dictResponse["result"])
                        let contactUsContent = kSharedInstance.getDictionary(result["contactUsContent"])
                        //print(contactUsContent)
                        strongSelf.lblEmail.text = String.getString(contactUsContent["email"])
                      strongSelf.lblContactNumber.text = String.getString(contactUsContent["mobile"])
                        
                        let mobile = String.getString(contactUsContent["mobile"])
                        if String.getLength(mobile) != 0
                        {
                            let array = mobile.components(separatedBy: "(")
                                                   
                           if array.count != 0
                           {
                               strongSelf.mobileNo = String.getString(array[0]).replacingOccurrences(of: " ", with: "")
                           //print(strongSelf.mobileNo)

                           }
                        }
                   
                     }else{
                         //strongSelf.showOkAlert(withMessage: String.getString(dictResponse["message"]))
                     }
              
                 }
                 else if errorType == .requestFailed
                 {
                 }
                 else
                 {
                 }
             }
         }
    
    
    
}
