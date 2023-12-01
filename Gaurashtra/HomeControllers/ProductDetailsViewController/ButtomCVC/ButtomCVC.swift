//
//  ButtomCVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 24/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class ButtomCVC: UICollectionViewCell {

    @IBOutlet weak var lblPriceNoNoffer: UILabel!
    @IBOutlet weak var lblSpcialPrice: UILabel!
    @IBOutlet weak var lblProdName: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblPercentage: UILabel!
    @IBOutlet weak var imgViewProd: UIImageView!
    
    @IBOutlet weak var lblPriceLine: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureRecentlyPurchasedCell(withDictData dictData : Dictionary<String,Any> ,  forindxPath indxPath : IndexPath)
    {
        let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
        let value              = CurrencyDataModel.getCurrencySavedDetails().value
        let currecyDoubleValue = Double.getDouble(value)
             
        
        let product_price = String.getString(dictData["product_price"])
        
        let special_price = String.getString(dictData["special_price"])
        
        let price = Double.getDouble(product_price)*currecyDoubleValue
        
        let specialPrice = Double.getDouble(special_price)*currecyDoubleValue
        let tax_rate      = Double.getDouble(dictData["tax_rate"])
        let priceRate     = Double(round(100*((price*tax_rate)/100))/100)
        
        let specialPriceRate = Double(round(100*((specialPrice*tax_rate)/100))/100)
        let dicountedAmt = price - specialPrice
        
        let disountedPec = ( dicountedAmt * 100.00) / price
        
        let priceFloat    = Double(round(100*price)/100) + priceRate
        
        let specialPriceFlt = Double(round(100*specialPrice)/100) + specialPriceRate
        
        self.lblPrice.text =  "\(symbol)\(priceFloat)"
        
        self.lblPriceLine.text = "\(symbol)\(priceFloat)"
        
        
        let per = Double(round(100*disountedPec)/100)
        
        if special_price == "0.0000"
        {
            self.lblPriceLine.isHidden       = true
            self.lblSpcialPrice.isHidden    = true
            self.lblPercentage.isHidden      = true
            self.lblPrice.isHidden           = true
            self.lblPriceNoNoffer.isHidden    = false
            
            self.lblPriceNoNoffer.text = "\(symbol)\(priceFloat)"
            
            
            
        }else  if special_price != "0.0000"{
            
            self.lblPriceLine.isHidden       = false
            self.lblSpcialPrice.isHidden    = false
            self.lblPercentage.isHidden      = false
            self.lblPrice.isHidden           = false
            
            
            
            self.lblPriceNoNoffer.isHidden    = true
            
            
            self.lblPriceNoNoffer?.text = ""
            
            self.lblPercentage.text          = "\(per)%"
            self.lblSpcialPrice.text        = "\(symbol)\(specialPriceFlt)"
            
        }
        
        
        //https://www.gaurashtra.com/image/cache/catalog/cow-products/Vanri Gutika.jpg
        self.lblProdName.text = String.getString(dictData["product_name"])
        
        let imgURL = String.getString(dictData["product_image"])
        
        let replacedURL = imgURL.replacingOccurrences(of: ".jpg", with: "-300x300.jpg")
        
        let imageUrl = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL).replacingOccurrences(of: " ", with: "%20")
        guard let urlBrand = URL.init(string: imageUrl) else { return }
        self.imgViewProd.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
        
    }

    
}
