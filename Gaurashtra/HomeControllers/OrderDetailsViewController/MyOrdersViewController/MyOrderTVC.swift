//
//  MyOrderTVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 21/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

typealias TapOnReport = (_ tapOnReport : UIButton) -> ()

class MyOrderTVC: UITableViewCell {

    fileprivate var tapOnreport : TapOnReport = { tapOnreport in }
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var btnReport: UIButton!
    
    @IBOutlet weak var lblOrderStatus: UILabel!
    
    @IBOutlet weak var lblPaymentMode: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblOrderDate: UILabel!
    @IBOutlet weak var lblOrderId: UILabel!
    
      @IBOutlet weak var footerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        footerView.layer.cornerRadius = 5
        //        subView.clipsToBounds = true
        footerView.layer.shadowOpacity = 0.9
        footerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        footerView.layer.shadowRadius = 4.0
        footerView.layer.shadowColor = UIColor(red: 168.0/255.0, green: 210.0/255.0, blue: 223.0/255.0, alpha: 1.0).cgColor
        footerView.backgroundColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

   
    
    func configureCell(withDictData dictData : Dictionary<String,Any> , forIndxPath indxPath : IndexPath , btnReport : @escaping TapOnReport)
    {
        
        tapOnreport = btnReport
        
        let orderId = String.getString(dictData["orderId"])
        
        self.lblPaymentMode.text = String.getString(dictData["paymentMethod"])
        print(dictData)
        
        print(orderId)
        
        let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
        let value              = CurrencyDataModel.getCurrencySavedDetails().value
        let currecyDoubleValue = Double.getDouble(value)
               
        let orderDate = String.getString(dictData["orderDate"])
        
        let replaced = orderDate.replacingOccurrences(of: "January", with: "Jan")
        let replaced2 = replaced.replacingOccurrences(of: "February", with: "Feb")
        let replaced3 = replaced2.replacingOccurrences(of: "August", with: "Aug")
        let replaced4 = replaced3.replacingOccurrences(of: "September", with: "Sept")
        let replaced5 = replaced4.replacingOccurrences(of: "October", with: "Oct")
        let replaced6 = replaced5.replacingOccurrences(of: "November", with: "Nov")
        let replaced7 = replaced6.replacingOccurrences(of: "December", with: "Dec")
      
        
        self.lblOrderId.text = "Order Id : \(orderId)"
        self.lblOrderDate.text = String.getString(replaced7)
        
        let amount = String.getString(dictData["amount"])
        
        let price = Double.getDouble(amount)*currecyDoubleValue
    
        
        let priceFloat    = Double(round(100*price)/100)
        
        self.lblPrice.text =  "\(symbol)\(priceFloat)"
        
        let img = String.getString(dictData["productImage"])
        
        let replacedURL = img.replacingOccurrences(of: ".jpg", with: "-300x300.jpg")
        
        let imageUrl2 = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL)
        print(imageUrl2)
        
        
        guard let urlBrand3 = URL.init(string: imageUrl2) else { return }
        self.imgView.af_setImage(withURL: urlBrand3, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
        
        let orderStatus = Int.getInt(dictData["orderStatus"])
        switch orderStatus {
            case 1:
               self.lblOrderStatus.text = "Pending"
            case 2:
               self.lblOrderStatus.text = "Processing"
            case 3:
               self.lblOrderStatus.text = "In Transit"
            case 4:
               self.lblOrderStatus.text = "Payment Failed"
            case 5:
               self.lblOrderStatus.text = "Delivered"
            case 6:
               self.lblOrderStatus.text = "Partially Refunded"
            case 7:
               self.lblOrderStatus.text = "Payment Awaited"
            case 8:
               self.lblOrderStatus.text = "Returned & Refunded"
            case 9:
               self.lblOrderStatus.text = "Damaged & Refunded"
            case 10:
               self.lblOrderStatus.text = "Voided"
            case 11:
               self.lblOrderStatus.text = "On Hold"
            case 12:
               self.lblOrderStatus.text = "Cancelled Reversal"
            case 13:
               self.lblOrderStatus.text = "Awaiting Response"
            case 14:
               self.lblOrderStatus.text = "Out For Delivery"
            case 15:
               self.lblOrderStatus.text = "Shipment Returned"
        default:
            break
        }
        
    }
    
    @IBAction func tapToReport(_ sender: UIButton) {
        tapOnreport(sender)
        
    }
    
}
