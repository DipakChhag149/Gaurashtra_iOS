//
//  OrderDetailTVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 21/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class OrderDetailTVC: UITableViewCell {
    
    fileprivate var tapOnReviews : TapOnBtn = { tapOnReviews in }
    
    @IBOutlet weak var btnReview: UIButton!
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblProdModel: UILabel!
    
    @IBOutlet weak var lblQty: UILabel!
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configureCell(withDictData dictData : Dictionary<String,Any> , forIndxPath indxPath : IndexPath, btnReviews : @escaping TapOnBtn )
    {
        
        tapOnReviews = btnReviews
        let reviewId = String.getString(dictData["reviewId"])
        
        if reviewId == "0"
        {
            self.btnReview.setTitle("Write a review", for: .normal)
        }else{
            self.btnReview.setTitle("Edit review", for: .normal)
        }
        self.lblName.text = String.getString(dictData["productName"])
        let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
        let value              = CurrencyDataModel.getCurrencySavedDetails().value
        let currecyDoubleValue = Double.getDouble(value)
        
        
        let productQuantity = String.getString(dictData["productQuantity"])
        
        self.lblQty.text = "Qty : \(productQuantity)"
        
        self.lblProdModel.text = String.getString(dictData["productModel"])
     
        let productPrice = String.getString(dictData["productPrice"])
        //productTax
        let price = Double.getDouble(productPrice)*currecyDoubleValue
        
        let productTax      = Double.getDouble(dictData["productTax"])*currecyDoubleValue
        
        let finalPrice = price + productTax
        
       // let priceRate     = Double(round(100*((price*tax_rate)/100))/100)
      //  let specialPriceRate = Double(round(100*((specialPrice*tax_rate)/100))/100)
        
         
        let priceFloat    = Double(round(100*finalPrice)/100)
        
        self.lblPrice.text =  "\(symbol)\(priceFloat)"
        
        let img = String.getString(dictData["productImage"])
        
        let replacedURL = img.replacingOccurrences(of: ".jpg", with: "-300x300.jpg")
        
        let imageUrl2 = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL)
        guard let urlBrand3 = URL.init(string: imageUrl2) else { return }
        self.imgView.af_setImage(withURL: urlBrand3, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
        
    }
    
    @IBAction func tapToReview(_ sender: UIButton) {
        
        tapOnReviews(sender)
        
    }
    
}
