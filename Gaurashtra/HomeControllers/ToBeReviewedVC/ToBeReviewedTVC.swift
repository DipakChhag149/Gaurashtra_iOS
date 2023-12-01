//
//  ToBeReviewedTVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 30/01/20.
//  Copyright © 2020 Gaurashtra. All rights reserved.
//

import UIKit

class ToBeReviewedTVC: UITableViewCell {

    
    fileprivate var tapOnWriteReview : TapOnBtn = { tapOnWriteReview in }
    
    @IBOutlet weak var lblProdName: UILabel!
    
    @IBOutlet weak var lblOrderDate: UILabel!
    
   // @IBOutlet weak var lblReview: UILabel!
    
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var lblOrderedId: UILabel!
    @IBOutlet weak var imgView: UIImageView!
   
    
   // @IBOutlet weak var lblDelivered: UILabel!
    
  //  @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnReview: UIButton!
    
  //  @IBOutlet weak var lblPaymentMode: UILabel!
    
    
  //  @IBOutlet weak var img5: UIImageView!
  //  @IBOutlet weak var img4: UIImageView!
    
  //  @IBOutlet weak var img1: UIImageView!
    
   // @IBOutlet weak var img2: UIImageView!
    
  //  @IBOutlet weak var img3: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
           subView.layer.cornerRadius = 5
               //        subView.clipsToBounds = true
           subView.layer.shadowOpacity = 0.9
           subView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
           
           subView.layer.shadowRadius = 4.0
           subView.layer.shadowColor = UIColor(red: 168.0/255.0, green: 210.0/255.0, blue: 223.0/255.0, alpha: 1.0).cgColor
           subView.backgroundColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    /*
        
           "orderId": "6528",
           "invoicePrefix": "GR-2K1701-00",
           "orderDate": "03 September 2019",
           "amount": "589.0002",
           "paymentMethod": "Razorpay",
           "delivered": "",
           "productId": "263",
           "productName": "GoSeva Satvik Dhoop 12 Sticks",
           "productImage": "catalog/cow-products/panchagavya-dhoop/GoSeva-Satvik-Cow-Dung-Dhoop.jpg",
           "productModel": "Satvik Dhoop",
           "productQuantity": "1",
           "productPrice": "38.0952",
           "productTotal": "38.0952",
           "productTax": "1.9048",
           "productOptionId": "0",
           "productOptionValueId": "0",
           "productOptionName": "",
           "productOptionValueName": "",
           "productOptionType": "",
           "reviewText": "",
           "reviewRating": "0"
        
        
        
        */
    
    func configureCell(withDictData dictData : Dictionary<String,Any> , forIndxPath indxPath : IndexPath , btnWriteReview : @escaping TapOnBtn)
    {
        tapOnWriteReview = btnWriteReview
        self.lblOrderDate.text = String.getString(dictData["orderDate"])
//        let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
//        let value              = CurrencyDataModel.getCurrencySavedDetails().value
//        let currecyDoubleValue = Double.getDouble(value)
        
        let orderId = String.getString(dictData["orderId"])
        
        self.lblOrderedId.text = "Order No. " + orderId
        
        self.lblProdName.text = String.getString(dictData["productName"])
        
//        self.lblPaymentMode.text = String.getString(dictData["paymentMethod"])
//
//        let product_price = String.getString(dictData["productPrice"])
//
//        let product_priceDbl = Double.getDouble(product_price)*currecyDoubleValue
//
//        let tax_rate      = Double.getDouble(dictData["tax_rate"])
//        let priceRate     = Double(round(100*((product_priceDbl*tax_rate)/100))/100)
//        //let specialPriceRate = Double(round(100*((specialPrice*tax_rate)/100))/100)
//
//         let priceFloat    = Double(round(100*product_priceDbl)/100) + priceRate
//
//        self.lblPrice.text = "\(symbol)\(priceFloat)"
        
        
        let imgURL = String.getString(dictData["productImage"])
              
              //        let str = "Swift 3.0 is the best version of Swift to learn, so if you're starting fresh you should definitely learn Swift 3.0."
        let replacedURL = imgURL.replacingOccurrences(of: ".jpg", with: "-300x300.jpg")
      //https://www.gaurashtra.com/image/cache/catalog/cow-products/shampoo/Gaurashtra-Panchgavya-Reetha-Hair-Shampoo-300x300.jpg
        let imageUrl = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL)
        guard let urlBrand = URL.init(string: imageUrl) else { return }
        self.imgView.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
   
    }
    
    
    
    @IBAction func tapToWriteReview(_ sender: UIButton) {
        
        tapOnWriteReview(sender)
        
    }
    
    

}
