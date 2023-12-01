//
//  BestOfferCVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 28/12/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class BestOfferCVC: UICollectionViewCell {

    @IBOutlet weak var prodImgView: UIImageView!
    
    @IBOutlet weak var timeImgView: UIImageView!
    
    @IBOutlet weak var lblDealEndDate: UILabel!
    
    @IBOutlet weak var lblProductName: UILabel!
    
    @IBOutlet weak var lblPriceLine: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblDiscountPer: UILabel!
    
    @IBOutlet weak var lblSpecialPrice: UILabel!
    
    
    
    
    
    
    //    @IBOutlet weak var lblPrice: UILabel!
//    
//    @IBOutlet weak var lblPriceLine: UILabel!
//    @IBOutlet weak var lblDealEndTime: UILabel!
//    
//    @IBOutlet weak var lblDiscountPer: UILabel!
//    @IBOutlet weak var lblProductName: UILabel!
//    
//    
//    
//    @IBOutlet weak var lblSpecialPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configureCellBestOfferTodayDeal(withBannerData dictData : Dictionary<String,Any> , andIndxPath indxPath : IndexPath)
    {
        
        let symbol = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
        let value = CurrencyDataModel.getCurrencySavedDetails().value
       
        let currecyDoubleValue = Double.getDouble(value)
        
        
        let product_price = String.getString(dictData["product_price"])
        
        let special_price = String.getString(dictData["special_price"])
        
        let price = Double.getDouble(product_price)*currecyDoubleValue
        
        let specialPrice = Double.getDouble(special_price)*currecyDoubleValue
        
         let tax_rate      = Double.getDouble(dictData["tax_rate"])
         let priceRate = Double(round(100*((price*tax_rate)/100))/100)
        
         let specialPriceRate = Double(round(100*((specialPrice*tax_rate)/100))/100)
         let specialPriceFlt = Double(round(100*specialPrice)/100) + specialPriceRate
        
        let dicountedAmt = price - specialPrice
        
        let disountedPec = ( dicountedAmt * 100.00) / price
        
        let priceFloat    = Double(round(100*price)/100) + priceRate
        
        self.lblPrice.text =  "\(symbol)\(priceFloat)"
        
        print("\(symbol)\(priceFloat)")
        
        
        let per = Double(round(100*disountedPec)/100)
        
        if special_price == "0.0000"
        {
            self.lblPriceLine.isHidden       = true
            self.lblSpecialPrice.isHidden    = true
            self.lblDiscountPer.isHidden     = true
            self.lblPrice.font  = UIFont.systemFont(ofSize: 13)
             self.lblPrice.textColor              = UIColor(red: 245.0/255.0, green: 85.0/255.0, blue: 22.0/255.0, alpha: 1.0)
            
        }else{
            
            self.lblPriceLine.isHidden       = false
            self.lblSpecialPrice.isHidden    = false
            self.lblDiscountPer.isHidden     = false
            self.lblPrice.textColor              = UIColor.lightGray
            self.lblDiscountPer.text         = "\(per)"
            self.lblSpecialPrice.text        = "\(symbol)\(specialPriceFlt)"
            
        }
        
        
        self.lblProductName.text = String.getString(dictData["product_name"])
        
        let imgURL = String.getString(dictData["product_image"])
        
        //        let str = "Swift 3.0 is the best version of Swift to learn, so if you're starting fresh you should definitely learn Swift 3.0."
        let replacedURL = imgURL.replacingOccurrences(of: ".jpg", with: "-300x300.jpg")
        
        let imageUrl = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL)
        guard let urlBrand = URL.init(string: imageUrl) else { return }
        self.prodImgView.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
    }
    

}
