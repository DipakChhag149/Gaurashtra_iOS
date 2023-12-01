//
//  OrderDetailsViewController.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 21/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class OrderDetailsViewController: GaurashtraBaseVC {

    @IBOutlet weak var tblInfo: UITableView!
   // @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var trackView: UIView!
    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblBillingName: UILabel!
    
    
    @IBOutlet weak var lblBillingAddress: UILabel!
    
    @IBOutlet weak var lblBillingMobile: UILabel!
    
    
    @IBOutlet weak var lblShippingMobile: UILabel!
    @IBOutlet weak var lblShippingName: UILabel!
    
    @IBOutlet weak var lblShippingAddress: UILabel!
    
//    @IBOutlet weak var lblDeliveryStatus: UILabel!
//    @IBOutlet weak var lblDeliveryDate: UILabel!
    @IBOutlet weak var lblOrderInitiationDate: UILabel!
    
    @IBOutlet weak var lblDelivery: UILabel!
 //   @IBOutlet weak var lblPaymentMode: UILabel!
    @IBOutlet weak var lblOrderId: UILabel!
    
  //  @IBOutlet weak var lblTotalAmount: UILabel!
    
    @IBOutlet weak var lblOrderDate: UILabel!
    
    @IBOutlet weak var shipmentView: UIView!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var billingView: UIView!
    @IBOutlet weak var shippingView: UIView!
    @IBOutlet weak var orderDetailTbl: UITableView!
    let gradientLayer = CAGradientLayer()
       let bgImageView = UIImageView(image: #imageLiteral(resourceName: "grayline2"))
       let shimmerImageView = UIImageView(image: #imageLiteral(resourceName: "grayline1"))
    var orderId : String = ""
    
    var productList : [Any]  = []
    var infoList    : [Any]  = []
    var idetify     : Int    = 0
    var trackingUrl : String = ""
    
    private var dictParams = [kUserId  : "",
                              kOrderId : ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDevice()
        self.trackView.isHidden = true
        kSharedInstance.setShadow(withSubView: topView, cornerRedius: 0)
        kSharedInstance.setShadow(withSubView: shipmentView, cornerRedius: 0)
        kSharedInstance.setShadow(withSubView: billingView, cornerRedius: 5)
        kSharedInstance.setShadow(withSubView: shippingView, cornerRedius: 5)
        
         self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        self.dictParams[kOrderId] = String.getString(orderId)
     
        if isInternetAvailable()
        {
            
            self.callGetOrderDetailsWebService(withProgressHUD: true)
            kSharedInstance.setupShimmeringImage(withView: self.view, backGrroundImgV: bgImageView, shimmerImageView: shimmerImageView)
            
        }else{
            
            showOkAlert(withMessage: kNetworkErrorAlert)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isInternetAvailable()
       {
           
        self.callGetOrderDetailsWebService(withProgressHUD: false)
           
       }else{
           
           showOkAlert(withMessage: kNetworkErrorAlert)
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
     
    @IBAction func tapToTrack(_ sender: UIButton) {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        let nv = sb.instantiateViewController(withIdentifier: OrderTrankingVC.storyboardId()) as! OrderTrankingVC
        nv.trackingUrl = self.trackingUrl
        self.navigationController?.pushViewController(nv, animated: true)
    }
        
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        
        if idetify == 1
        {
            kSharedAppDelegate.showSideMenu()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    

}
//#MARK:  UITableViewDelegate,UITableViewDataSource 
extension OrderDetailsViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case self.orderDetailTbl:
            return productList.count
        case self.tblInfo:
            return self.infoList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case self.orderDetailTbl:
            let cell = orderDetailTbl.dequeueReusableCell(withIdentifier: OrderDetailTVC.cellIdentifier(), for: indexPath) as! OrderDetailTVC
            cell.configureCell(withDictData: kSharedInstance.getDictionary(productList[indexPath.row]), forIndxPath: indexPath, btnReviews: {( btnReviews : UIButton ) in
              //setProductReviewRating
                
                let dictData = kSharedInstance.getDictionary(self.productList[indexPath.row])
                let reviewId = String.getString(dictData["reviewId"])
                self.reviewVc(withDictData: dictData, reviewId: String.getString(dictData["reviewId"]))
               
                
            })
            
            return cell
        case self.tblInfo:
            let cell = tblInfo.dequeueReusableCell(withIdentifier: OrderInfoTVC.cellIdentifier(), for: indexPath) as! OrderInfoTVC
            cell.configureCell(withDictData: kSharedInstance.getDictionary(self.infoList[indexPath.row]), forIndexPath: indexPath)
            
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case self.orderDetailTbl:
            let dictData = kSharedInstance.getDictionary(productList[indexPath.row])
             self.productDetailsVC(withProductId: String.getString(dictData["productId"]))
        case self.tblInfo:
            break
        default:
            break
        }
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch tableView {
        case self.orderDetailTbl:
            return 140.0
        case self.tblInfo:
            if self.infoList.count == 4
            {
                return 32.0
            }else if self.infoList.count == 5
            {
                return 30.0
            }else if self.infoList.count == 6
            {
                return 26
            }else{
                return 60.0
            }
            
        default:
            return 0
        }
    }
    
    func reviewVc(withDictData dictData : Dictionary<String,Any>, reviewId : String)
    {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextVC = sb.instantiateViewController(withIdentifier: ReviewVC.storyboardId()) as! ReviewVC
        
        nextVC.productData = dictData
        nextVC.reviewId    = reviewId
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    
    func productDetailsVC(withProductId prodId : String)
    {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextVC = sb.instantiateViewController(withIdentifier: ProductDetailsViewController.storyboardId()) as! ProductDetailsViewController
        
        nextVC.product_id  = prodId
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    
    
    //#MARK:-----------callGetCartDataWebService---------
    private func callGetOrderDetailsWebService(withProgressHUD progressHUD : Bool)
    {
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetOrderDetails, requestMethod: .post, requestImages: [dictImg], withProgressHUD: progressHUD, withProgessHUDTitle: "Please Wait", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                strongSelf.bgImageView.removeFromSuperview()
                strongSelf.shimmerImageView.removeFromSuperview()

                let dictResponse = kSharedInstance.getDictionary(response)
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    
                    let orderData = kSharedInstance.getDictionary(result["orderData"])
                    
                    strongSelf.productList = kSharedInstance.getArray(orderData["product"])
                    print("orderDataSunish:\(orderData)")
                    print("infoArrSunish:\(kSharedInstance.getArray(orderData["info"]))")
                    strongSelf.infoList    = kSharedInstance.getArray(orderData["info"])
                    let  general = kSharedInstance.getDictionary(orderData["general"])
                    let tracking_url = String.getString(general["tracking_url"])
                    if String.getLength(tracking_url) != 0
                    {
                        strongSelf.trackView.isHidden = false
                        strongSelf.trackingUrl        = tracking_url
                    }else{
                        strongSelf.trackView.isHidden = true
                    }
                    strongSelf.showData(withDictDat: kSharedInstance.getDictionary(orderData["general"]))
                    strongSelf.orderDetailTbl.reloadData()
                    strongSelf.tblInfo.reloadData()
                    
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
    
    func showData(withDictDat dictData : Dictionary<String,Any>)
    {
        //print(dictData)
        
        let symbol = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
        let value = CurrencyDataModel.getCurrencySavedDetails().value
        let amount  = String.getString(dictData["amount"])
        
        let currecyDoubleValue = Double.getDouble(value)
        let price = Double.getDouble(amount)*currecyDoubleValue
        
        let priceRate = Double(round(100*price)/100)
        
      //  self.lblTotalAmount.text = "\(symbol)\(priceRate)"
        
        let orderId = String.getString(dictData["orderId"])
        
        
        self.lblOrderId.text = orderId
     
        let customerName = String.getString(dictData["customerName"])
        let customerPhone = String.getString(dictData["customerPhone"])
        
        self.lblShippingName.text = String.getString(dictData["shippingName"])
        
        self.lblShippingMobile.text = "Mobile : \(customerPhone)"
        
        
        let shippingCompany = String.getString(dictData["shippingCompany"])
        let shippingAddress1 = String.getString(dictData["shippingAddress1"])
        let shippingAddress2 = String.getString(dictData["shippingAddress2"])
        let shippingCity = String.getString(dictData["shippingCity"])
        
        let shippingPostcode = String.getString(dictData["shippingPostcode"])
        let shippingCountry = String.getString(dictData["shippingCountry"])
        
        self.lblShippingAddress.text = shippingAddress1 + ", " + shippingAddress2 + ", " + shippingCity + ", " + shippingPostcode + ", " + shippingCountry
        
        
       
        let paymentName = String.getString(dictData["paymentName"])
        let paymentCompany = String.getString(dictData["paymentCompany"])
        let paymentAddress1 = String.getString(dictData["paymentAddress1"])
        let paymentAddress2 = String.getString(dictData["paymentAddress2"])
        let paymentCity = String.getString(dictData["paymentCity"])
        
        let paymentPostcode = String.getString(dictData["paymentPostcode"])
        let paymentCountry = String.getString(dictData["paymentCountry"])
       
        
        self.lblBillingName.text = String.getString(paymentName)
        
        self.lblBillingMobile.text = "Mobile : \(customerPhone)"
        
        self.lblBillingAddress.text = paymentAddress1 + ", " + paymentAddress2 + ", " + paymentCity + ", " + paymentPostcode + ", " + paymentCountry
       
        self.lblOrderDate.text = String.getString(dictData["orderDate"])
       
        let orderStatus = Int.getInt(dictData["orderStatus"])
        switch orderStatus {
            case 1:
               self.lblDelivery.text = "Pending"
            case 2:
               self.lblDelivery.text = "Processing"
            case 3:
               self.lblDelivery.text = "In Transit"
            case 4:
               self.lblDelivery.text = "Payment Failed"
            case 5:
               self.lblDelivery.text = "Delivered"
            case 6:
               self.lblDelivery.text = "Partially Refunded"
            case 7:
               self.lblDelivery.text = "Payment Awaited"
            case 8:
               self.lblDelivery.text = "Returned & Refunded"
            case 9:
               self.lblDelivery.text = "Damaged & Refunded"
            case 10:
               self.lblDelivery.text = "Voided"
            case 11:
               self.lblDelivery.text = "On Hold"
            case 12:
               self.lblDelivery.text = "Cancelled Reversal"
            case 13:
               self.lblDelivery.text = "Awaiting Response"
            case 14:
               self.lblDelivery.text = "Out For Delivery"
            case 15:
               self.lblDelivery.text = "Shipment Returned"
        default:
            break
        }
       //need to changes
//        if String.getLength(delivered) != 0
//        {
//            self.lblDelivery.text = delivered
//            self.lblDeliveryDate.text = ""
//
//            self.lblDeliveryStatus.text = "Your ordr has been delivered"
//        }else{
//
////            self.lblDelivery.text = "Transit it"
////            self.lblDeliveryDate.text = ""
//
//           // self.lblDeliveryStatus.text = ""
//        }
    }
    
}
