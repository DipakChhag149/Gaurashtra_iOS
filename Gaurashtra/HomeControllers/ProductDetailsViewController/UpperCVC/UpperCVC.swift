//
//  UpperCVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 24/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class UpperCVC: UICollectionViewCell {

    
    @IBOutlet weak var lblPriceLine: UILabel!
    
    
    @IBOutlet weak var lblSpecialPrice: UILabel!
    
    @IBOutlet weak var lblPerc: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblPriceNoOffer: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    @IBOutlet weak var lblProdName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configureReLatedProdCell(withDictData dictData : Dictionary<String,Any> , forIndxPath indxPath : IndexPath)
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
            self.lblSpecialPrice.isHidden    = true
            self.lblPerc.isHidden      = true
            self.lblPrice.isHidden           = true
            self.lblPriceNoOffer.isHidden    = false
            
            self.lblPriceNoOffer.text = "\(symbol)\(priceFloat)"
            
            
            
        }else  if special_price != "0.0000"{
            
            self.lblPriceLine.isHidden       = false
            self.lblSpecialPrice.isHidden    = false
            self.lblPerc.isHidden      = false
            self.lblPrice.isHidden           = false
            
            
            
            self.lblPriceNoOffer.isHidden    = true
            
            
            self.lblPriceNoOffer?.text = ""
            
            self.lblPerc.text          = "\(per)%"
            self.lblSpecialPrice.text        = "\(symbol)\(specialPriceFlt)"
            
        }
        
        
        
        self.lblProdName.text = String.getString(dictData["product_name"])
        
        let imgURL = String.getString(dictData["product_image"])
        
        let replacedURL = imgURL.replacingOccurrences(of: ".jpg", with: "-300x300.jpg").replacingOccurrences(of: " ", with: "%20")
        //-300x300.jpg
        let imageUrl = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL)
        guard let urlBrand = URL.init(string: imageUrl) else { return }
        self.imgView.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
    }
}
