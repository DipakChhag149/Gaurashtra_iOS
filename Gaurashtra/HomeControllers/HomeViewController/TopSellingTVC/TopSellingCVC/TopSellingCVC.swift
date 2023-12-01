//
//  TopSellingCVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 28/12/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class TopSellingCVC: UICollectionViewCell {

    @IBOutlet weak var discountPriceConstraintH: NSLayoutConstraint!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var prodImgView: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblActualPrice: UILabel!
    
    @IBOutlet weak var lblPriceLine: UILabel!
    
    @IBOutlet weak var lblDiscountedPrice: UILabel!
    
    @IBOutlet weak var lblDiscountPer: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        kSharedInstance.setShadow(withSubView: self.subView, cornerRedius: 0)
        
        
        self.getDevice()
    }

    
    func getDevice()
    {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136://iphone 5/5S/SE
                
                self.lblName.font = UIFont(name: "Poppins-Medium", size: 12)
                self.lblActualPrice.font = UIFont(name: "Poppins-Regular", size: 10)
                
                self.lblDiscountPer.font = UIFont(name: "Poppins-Regular", size: 10)
                
                self.lblDiscountedPrice.font = UIFont(name: "Poppins-Regular", size: 10)
                
                
                
                
                
            case 1334://iphone 6/6S/7/8
                self.lblName.font = UIFont(name: "Poppins-Medium", size: 14)
                
                self.lblActualPrice.font = UIFont.systemFont(ofSize: 14)
                
                self.lblDiscountPer.font = UIFont(name: "Poppins-Regular", size: 14)
                
                self.lblDiscountedPrice.font = UIFont.systemFont(ofSize: 15, weight: .medium)
                
                
                
            case 2208://iphone 6+/6S+/7+/8+
                
                self.lblName.font = UIFont(name: "Poppins-Medium", size: 15)
                
                self.lblActualPrice.font = UIFont.systemFont(ofSize: 15)
                
                self.lblDiscountPer.font = UIFont(name: "Poppins-Regular", size: 15)
                
                
                
                self.lblDiscountedPrice.font = UIFont.systemFont(ofSize: 16, weight: .medium)
                
                
            case 2436://iphone X/XS
                
                self.lblName.font = UIFont(name: "Poppins-Medium", size: 15)
                
                self.lblActualPrice.font = UIFont.systemFont(ofSize: 15)
                
                self.lblDiscountPer.font = UIFont(name: "Poppins-Regular", size: 15)
                
                
                
                self.lblDiscountedPrice.font = UIFont.systemFont(ofSize: 16, weight: .medium)
                
                
                print("iphone XS")
                
            case 2688,2778://iphone XS Max
                
                print("iphone XS Max")
                
                self.lblName.font = UIFont(name: "Poppins-Medium", size: 15)
                
                self.lblActualPrice.font = UIFont.systemFont(ofSize: 15)
                
                self.lblDiscountPer.font = UIFont(name: "Poppins-Regular", size: 15)
                
                
                
                self.lblDiscountedPrice.font = UIFont.systemFont(ofSize: 16, weight: .medium)
                
                
            case 1792://iphone XR
                
                self.lblName.font = UIFont(name: "Poppins-Medium", size: 15)
                
                self.lblActualPrice.font = UIFont.systemFont(ofSize: 15)
                
                self.lblDiscountPer.font = UIFont(name: "Poppins-Regular", size: 15)
                
                
                
                self.lblDiscountedPrice.font = UIFont.systemFont(ofSize: 16, weight: .medium)
                
                
            default:
                self.lblName.font = UIFont(name: "Poppins-Medium", size: 15)
                self.lblActualPrice.font = UIFont.systemFont(ofSize: 15)
                self.lblDiscountPer.font = UIFont(name: "Poppins-Regular", size: 15)
                self.lblDiscountedPrice.font = UIFont.systemFont(ofSize: 16, weight: .medium)
                
            }
            
        }
        
    }
    
    
    
    func configureCellTopSelling(withBannerData dictData : Dictionary<String,Any> , andIndxPath indxPath : IndexPath)
    {
        
        print(dictData)
        
        
        let symbol = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
        let value = CurrencyDataModel.getCurrencySavedDetails().value
        
         let currecyDoubleValue = Double.getDouble(value)
       
        let product_price = String.getString(dictData["product_price"])
        
        let special_price = String.getString(dictData["special_price"])
        
       
        let price = Double.getDouble(product_price)*currecyDoubleValue
        print(price)
        let specialPrice = Double.getDouble(special_price)*currecyDoubleValue
        let tax_rate      = Double.getDouble(dictData["tax_rate"])
        let priceRate = Double(round(100*((price*tax_rate)/100))/100)
        
        let specialPriceRate = Double(round(100*((specialPrice*tax_rate)/100))/100)
        
        
        print(specialPrice)
        
        let dicountedAmt = price - specialPrice
        
         
        
        let disountedPec = (dicountedAmt * 100.00) / price
        
        let priceFloat    = Double(round(100*price)/100) + priceRate
        
        print("priceFloat:\(priceFloat)")
        
        let specialPriceFlt = Double(round(100*specialPrice)/100) + specialPriceRate
        
        
        self.lblActualPrice.text =  "\(symbol)\(priceFloat)"
        
        self.lblPriceLine.text = "\(symbol)\(priceFloat)"
        
        
        let per = Double(round(100*disountedPec)/100)
        
        if special_price == "0.0000"
        {
            self.lblPriceLine.isHidden       = true
            self.lblDiscountedPrice.isHidden = true
            self.lblDiscountPer.isHidden     = true
             self.lblActualPrice.textColor              = UIColor(red: 245.0/255.0, green: 85.0/255.0, blue: 22.0/255.0, alpha: 1.0)
            
            
        }else  if special_price != "0.0000"{
            
            self.lblPriceLine.isHidden       = false
            self.lblDiscountedPrice.isHidden = false
            self.lblDiscountPer.isHidden     = false
            self.lblActualPrice.textColor    = UIColor.lightGray
            self.lblDiscountPer.text         = "\(per)%"
            self.lblDiscountedPrice.text     = "\(symbol)\(specialPriceFlt)"
            
        }
        
        
        
        self.lblName.text = String.getString(dictData["product_name"])
        //sliderImage
     let imgURL = String.getString(dictData["product_image"])
        
       
        
        
        let replacedURL = imgURL.replacingOccurrences(of: ".jpg", with: "-300x300.jpg")
        
        let imageUrl = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL)
        guard let urlBrand = URL.init(string: imageUrl) else { return }
        self.prodImgView.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
    }
    
}
