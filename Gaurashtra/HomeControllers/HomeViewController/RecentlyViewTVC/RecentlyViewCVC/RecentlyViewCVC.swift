//
//  RecentlyViewCVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 28/12/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class RecentlyViewCVC: UICollectionViewCell {
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var lblProdName: UILabel!
    @IBOutlet weak var lblPer: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblPriceLine: UILabel!
    @IBOutlet weak var lblSpecialPrice: UILabel!
    @IBOutlet weak var prodImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
         kSharedInstance.setShadow(withSubView: self.subView, cornerRedius: 0)
    }
    func getDevice()
    {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136://iphone 5/5S/SE
                self.lblProdName.font = UIFont(name: "Poppins-Medium", size: 12)
                self.lblPrice.font = UIFont(name: "Poppins-Regular", size: 10)
                self.lblPer.font = UIFont(name: "Poppins-Regular", size: 10)
                self.lblSpecialPrice.font = UIFont(name: "Poppins-Regular", size: 10)
            case 1334://iphone 6/6S/7/8
                self.lblProdName.font = UIFont(name: "Poppins-Medium", size: 14)
                self.lblPrice.font = UIFont.systemFont(ofSize: 14)
                self.lblPer.font = UIFont(name: "Poppins-Regular", size: 14)
                self.lblSpecialPrice.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            case 2208://iphone 6+/6S+/7+/8+
                self.lblProdName.font = UIFont(name: "Poppins-Medium", size: 15)
                self.lblPrice.font = UIFont.systemFont(ofSize: 15)
                self.lblPer.font = UIFont(name: "Poppins-Regular", size: 15)
                self.lblSpecialPrice.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            case 2436://iphone X/XS
                self.lblProdName.font = UIFont(name: "Poppins-Medium", size: 15)
                self.lblPrice.font = UIFont.systemFont(ofSize: 15)
                self.lblPer.font = UIFont(name: "Poppins-Regular", size: 15)
                self.lblSpecialPrice.font = UIFont.systemFont(ofSize: 16, weight: .medium)
                //print("iphone XS")
            case 2688,2778://iphone XS Max
                //print("iphone XS Max")
                self.lblProdName.font = UIFont(name: "Poppins-Medium", size: 15)
                self.lblPrice.font = UIFont.systemFont(ofSize: 15)
                self.lblPer.font = UIFont(name: "Poppins-Regular", size: 15)
                self.lblSpecialPrice.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            case 1792://iphone XR
                self.lblProdName.font = UIFont(name: "Poppins-Medium", size: 15)
                self.lblPrice.font = UIFont.systemFont(ofSize: 15)
                self.lblPer.font = UIFont(name: "Poppins-Regular", size: 15)
                self.lblSpecialPrice.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            default: 
                //print("unknown")
                self.lblProdName.font = UIFont(name: "Poppins-Medium", size: 15)
                self.lblPrice.font = UIFont.systemFont(ofSize: 15)
                self.lblPer.font = UIFont(name: "Poppins-Regular", size: 15)
                self.lblSpecialPrice.font = UIFont.systemFont(ofSize: 16, weight: .medium)
                
            }
            
        }
        
    }
    
    func configureCellRecentlyViewed(withBannerData dictData : Dictionary<String,Any> , andIndxPath indxPath : IndexPath)
    {
        
        let symbol = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
        let value = CurrencyDataModel.getCurrencySavedDetails().value
        let currecyDoubleValue = Double.getDouble(value)
        
        let product_price = String.getString(dictData["product_price"])
        
        let special_price = String.getString(dictData["special_price"])
        
        let price = Double.getDouble(product_price)*currecyDoubleValue
        
        let specialPrice = Double.getDouble(special_price)*currecyDoubleValue
        
        let tax_rate      = Double.getDouble(dictData["tax_rate"])
        let priceRate     = Double(round(100*((price*tax_rate)/100))/100)
        
        let specialPriceRate = Double(round(100*((specialPrice*tax_rate)/100))/100)
        let specialPriceFlt = Double(round(100*specialPrice)/100) + specialPriceRate
        let dicountedAmt = price - specialPrice
        
        let disountedPec = ( dicountedAmt * 100.00) / price
        
        let priceFloat    = Double(round(100*price)/100) + priceRate
        
        self.lblPrice.text =  "\(symbol)\(priceFloat)"
        
        
        
        let per = Double(round(100*disountedPec)/100)
        
        if special_price == "0.0000"
        {
            self.lblPriceLine.isHidden    = true
            self.lblSpecialPrice.isHidden = true
            self.lblPer.isHidden         = true
            // self.lblPrice.textColor       = .black
             self.lblPrice.textColor              = UIColor(red: 245.0/255.0, green: 85.0/255.0, blue: 22.0/255.0, alpha: 1.0)
            
            self.lblPrice.font  = UIFont.systemFont(ofSize: 13)
            
            
        }else{
            
            self.lblPriceLine.isHidden       = false
            self.lblSpecialPrice.isHidden = false
            self.lblPer.isHidden     = false
            
            self.lblPer.text         = "\(per)"
            self.lblSpecialPrice.text     = "\(symbol)\(specialPriceFlt)"
            self.lblPrice.textColor              = .lightGray
            
            // self.lblPrice.font  = UIFont.systemFont(ofSize: 12)
            
        }
        
        
        self.lblProdName.text = String.getString(dictData["product_name"])
        
        let imgURL = String.getString(dictData["product_image"])
        
        //        let str = "Swift 3.0 is the best version of Swift to learn, so if you're starting fresh you should definitely learn Swift 3.0."
        let replacedURL = imgURL.replacingOccurrences(of: ".jpg", with: "-300x300.jpg")
        
        let imageUrl = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL)
        guard let urlBrand = URL.init(string: imageUrl) else { return }
        self.prodImgView.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
   
    
    }
    
    
}
