//
//  MyWalletVC.swift
//  Gaurashtra
//
//  Created by Algosoft Technologies on 10/2/20.
//  Copyright © 2020 Gaurashtra. All rights reserved.
//

import UIKit

class MyWalletVC: GaurashtraBaseVC {

    @IBOutlet weak var tblWallet: UITableView!
    @IBOutlet weak var lblTotalAmount: UILabel!
    private var dictParams = [kUserId: ""]
    var walletData : [Any] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
              //self.dictParams[kUserId] = "4078"
              if isInternetAvailable()
              {
                  self.callWishListWebService()
                  
                  
                 // kSharedInstance.setupShimmeringImage(withView: self.view, backGrroundImgV: bgImageView, shimmerImageView: shimmerImageView)
                  
              }else{
                  
                  showOkAlert(withMessage: kNetworkErrorAlert)
                  
              }
        
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
//#MARK:  UITableViewDelegate,UITableViewDataSource 
extension MyWalletVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return walletData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblWallet.dequeueReusableCell(withIdentifier: MyWalletTVC.cellIdentifier(), for: indexPath) as! MyWalletTVC
        cell.configureCell(withDictData: kSharedInstance.getDictionary(self.walletData[indexPath.row]), forIndxPath: indexPath)
        return cell
  }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //#MARK:-----------callCategoryListWebService---------
           private func callWishListWebService()
           {
               
               let dictImg:[String : Any] = ["image" : UIImage(),
                                             "imageName" : "uploaded_file"]
               
               TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetWalletData, requestMethod: .post, requestImages: [dictImg], withProgressHUD: false, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
                   guard let strongSelf = self else { return }
                   if errorType == .requestSuccess
                   {
                       UIApplication.shared.endIgnoringInteractionEvents()
                       
                       let dictResponse = kSharedInstance.getDictionary(response)
                       
    //                   strongSelf.bgImageView.removeFromSuperview()
    //                   strongSelf.shimmerImageView.removeFromSuperview()
                       
                       if Int.getInt(dictResponse["success"]) == 1
                       {
                           let result = kSharedInstance.getDictionary(dictResponse["result"])
                        

                        let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                        let value              = CurrencyDataModel.getCurrencySavedDetails().value
                        let currecyDoubleValue = Double.getDouble(value)
                        let balanceAmount = String.getString(result["balanceAmount"])
                        let walletDbl = Double.getDouble(balanceAmount)*currecyDoubleValue
                        let amount = Double(round(100*walletDbl)/100)
                        strongSelf.lblTotalAmount.text = "\(symbol)\(amount)"
                         
                        strongSelf.walletData = kSharedInstance.getArray(result["walletData"])
                        strongSelf.tblWallet.reloadData()
                           
                       }else{
                          strongSelf.view.makeToast(String.getString(dictResponse[kMessage]), duration: 1.5, position: .center)
                        let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
                        strongSelf.lblTotalAmount.text = "\(symbol)0.00"
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
