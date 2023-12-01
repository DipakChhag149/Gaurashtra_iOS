//
//  WishListTVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 06/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class WishListTVC: UITableViewCell {
    
    
    
    fileprivate var tapOnDelete : TapOnDelete = { tapOnDelete in }
    
    fileprivate var tapOnAddCart : TapOnAddCart = { tapOnAddCart in }
    
    fileprivate var tapOnPackOf : TapOnPackOf = { tapOnDelete in }
    
   
    @IBOutlet weak var viewPackOf: UIView!
    @IBOutlet weak var lblTotalCount: UILabel!
    @IBOutlet weak var subView: UIView!
     @IBOutlet weak var btnPackOff: UIButton!
    
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnAddToCart: UIButton!
    
    @IBOutlet weak var lblNoOfferPrice: UILabel!
    @IBOutlet weak var lblProdName: UILabel!
    @IBOutlet weak var lblPackOff: UILabel!
    
    @IBOutlet weak var lblSpecialPrice: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblPerc: UILabel!
    
    @IBOutlet weak var lblPriceLine: UILabel!
    
    @IBOutlet weak var star1: UIImageView!
    
    @IBOutlet weak var star2: UIImageView!
    
    @IBOutlet weak var star3: UIImageView!
    
    @IBOutlet weak var star4: UIImageView!
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var star5: UIImageView!
     @IBOutlet weak var lblRatingCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        subView.layer.cornerRadius = 5
//        subView.clipsToBounds = true
        subView.layer.shadowOpacity = 0.9
        subView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        subView.layer.shadowRadius = 3.0
        subView.layer.shadowColor = UIColor(red: 168.0/255.0, green: 210.0/255.0, blue: 223.0/255.0, alpha: 1.0).cgColor
        subView.backgroundColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWishListCell(withDictData dictData : Dictionary<String,Any>, forIndxPath indxPath : IndexPath , btnPackof :@escaping TapOnPackOf , btnAddCart :@escaping TapOnAddCart , btnDelete :@escaping TapOnDelete  )
    {
        tapOnDelete  = btnDelete
        tapOnAddCart = btnAddCart
        tapOnPackOf  = btnPackof
        
        
        let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
        let value              = CurrencyDataModel.getCurrencySavedDetails().value
        let currecyDoubleValue = Double.getDouble(value)
        
        
        
        let product_price = String.getString(dictData["product_price"])
        
        let special_price = String.getString(dictData["special_price"])
        
         let selectedQty = String.getString(dictData["selectedQty"])
        
        
        
        let price = Double.getDouble(product_price)*currecyDoubleValue
        
        let specialPrice = Double.getDouble(special_price)*currecyDoubleValue
        
        let tax_rate      = Double.getDouble(dictData["tax_rate"])
        let priceRate = Double(round(100*((price*tax_rate)/100))/100)
        
        let specialPriceRate = Double(round(100*((specialPrice*tax_rate)/100))/100)
        //let specialPriceFlt = Double(round(100*specialPrice)/100) + specialPriceRate
        
        let dicountedAmt = price - specialPrice
        
        let disountedPec = ( dicountedAmt * 100.00) / price
        
        let priceFloat    = Double(round(100*price)/100) + priceRate
        
        let specialPriceDbl = Double(round(100*specialPrice)/100) + specialPriceRate
        self.lblPrice.font  = UIFont.systemFont(ofSize: 11)
        
        let per = Double(round(100*disountedPec)/100)
        
        let discount_quantity = String.getString(dictData["discount_quantity"])
        
        
        if Int.getInt(selectedQty) == 0
        {
           self.lblPackOff.text = "1"
         
        }else{
     
           self.lblPackOff.text = selectedQty
         
        }
        
        let product_quantity = String.getString(dictData["product_quantity"])
               
        if Int.getInt(product_quantity) != 0
        {
           self.btnAddToCart.setTitle("Add to Cart", for: .normal)
           
           self.viewPackOf.isHidden = false
            self.btnAddToCart.setBackgroundImage(#imageLiteral(resourceName: "btnImg"), for: .normal)
           //self.btnAddToCart.backgroundColor = UIColor(red: 245.0/255.0, green: 84.0/255.0, blue: 22.0/255.0, alpha: 1.0)
           
        }else{
           
           self.btnAddToCart.setTitle("Notify Me", for: .normal)
            self.btnAddToCart.setBackgroundImage(nil, for: .normal)
           self.btnAddToCart.backgroundColor = UIColor(red: 176.0/255.0, green: 223.0/255.0, blue: 229.0/255.0, alpha: 1.0)
           
           self.viewPackOf.isHidden = true
           
        }
        
        
        
        
        
//        if Int.getInt(discount_quantity) == 0
//        {
//            self.viewPackOf.isHidden = true
//
//            self.lblPackOff.text = ""
//
//        }else{
//
//            self.viewPackOf.isHidden = false
//
//            self.lblPackOff.text = "Pack of \(discount_quantity)"
//        }
        
        let discount_price = String.getString(dictData["discount_price"])
    
        
        if special_price == "0.0000"
        {
           
            self.lblSpecialPrice.isHidden = true
            self.lblPrice.isHidden        = true
            self.lblPriceLine.isHidden    = true
            self.lblNoOfferPrice.isHidden     = false
            self.lblPerc.isHidden         = true
            
            
           // self.lblNoOfferPrice.font  = UIFont.systemFont(ofSize: 12)
//            self.viewPercentage.isHidden = true
            
            if Int.getInt(dictData["selecteIndex"]) == indxPath.row {
                
                if Int.getInt(dictData["selectetag"]) == 1
                {
                    
                    //print(Int.getInt(dictData["selecteIndex"]))
                    
                    //print(discount_quantity)
                    //print(discount_price)
                    
                    let dicountQntyDbl = Double.getDouble(discount_quantity)
                    
                    let discountPrice = Double.getDouble(discount_price)
                    
                    //print(discountPrice)
                    
                    if discountPrice != 0.0
                    {
                        let finalDiscountPrice = dicountQntyDbl*discountPrice
                        
                        let finalDiscountpriceFloat = Double(round(100*finalDiscountPrice)/100)
                        
                        self.lblNoOfferPrice.text  = "\(symbol)\(finalDiscountpriceFloat)"
                       // self.viewPackOf.backgroundColor = .lightGray
                    }
                    
                }else{
                    
                    self.lblNoOfferPrice.text  = "\(symbol)\(priceFloat)"
                    
                }
                
                
            }else{
                
                self.lblNoOfferPrice.text  = "\(symbol)\(priceFloat)"
            }
            
            
            
        }else  if special_price != "0.0000"{
            
            
            
//            self.viewPercentage.isHidden      = false
            self.lblNoOfferPrice.isHidden     = true
            self.lblPerc.isHidden         = true
            
//            self.view1.isHidden        = false
//            self.view1.isHidden        = false
            
            self.lblSpecialPrice.isHidden = false
            self.lblPrice.isHidden        = false
            self.lblPriceLine.isHidden    = false
            
            self.lblPrice.text            =  "\(symbol)\(priceFloat)"
            
            self.lblPerc.text  = "\(per)%"
            self.lblSpecialPrice.text     = "\(symbol)\(specialPriceDbl)"
            self.lblPrice.textColor       = .lightGray
            //  self.priceConstraintH.constant  = 20
            
            
        }
     
        
        
        self.lblProdName.text = String.getString(dictData["product_name"])
        
        let imgURL = String.getString(dictData["product_image"])
        
        //        let str = "Swift 3.0 is the best version of Swift to learn, so if you're starting fresh you should definitely learn Swift 3.0."
        let replacedURL = imgURL.replacingOccurrences(of: ".jpg", with: "-300x300.jpg")
        
        let imageUrl = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL)
        guard let urlBrand = URL.init(string: imageUrl) else { return }
        self.imgView.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
        
        let total_rating = String.getString(dictData["total_rating"])
       
        let productRating = Double.getDouble(total_rating)
        
        let total_count = String.getString(dictData["total_count"])
        
        if Int.getInt(total_count) ==  0
        {
            self.lblTotalCount.text = ""
        }else  if Int.getInt(total_count) >  0
        {
             self.lblTotalCount.text = "\(total_count) ratings"
        }
        
        
        if productRating >= 1.0 && productRating < 2.0
        {
            if productRating == 1.0
            {
                star1.image = #imageLiteral(resourceName: "star")
                
                
            }else{
                
                star1.image = #imageLiteral(resourceName: "star")
                star2.image = #imageLiteral(resourceName: "halfStar")
                
            }
            
            
        }else if productRating >= 2.0 && productRating < 3.0
        {
            
            if productRating == 2.0
            {
                star1.image = #imageLiteral(resourceName: "star")
                star2.image = #imageLiteral(resourceName: "star")
                
                
            }else{
                star1.image = #imageLiteral(resourceName: "star")
                star2.image = #imageLiteral(resourceName: "star")
                star3.image = #imageLiteral(resourceName: "halfStar")
                
            }
            
        }else if productRating >= 3.0 && productRating < 4.0
        {
            if productRating == 3.0
            {
                star1.image = #imageLiteral(resourceName: "star")
                star2.image = #imageLiteral(resourceName: "star")
                star3.image = #imageLiteral(resourceName: "star")
                
            }else{
                star1.image = #imageLiteral(resourceName: "star")
                star2.image = #imageLiteral(resourceName: "star")
                star3.image = #imageLiteral(resourceName: "star")
                star4.image = #imageLiteral(resourceName: "halfStar")
                
            }
            
        }else if productRating >= 4.0 && productRating < 5.0
        {
            if productRating == 4.0
            {
                star1.image = #imageLiteral(resourceName: "star")
                star2.image = #imageLiteral(resourceName: "star")
                star3.image = #imageLiteral(resourceName: "star")
                star4.image = #imageLiteral(resourceName: "star")
                
            }else{
                
                star1.image = #imageLiteral(resourceName: "star")
                star2.image = #imageLiteral(resourceName: "star")
                star3.image = #imageLiteral(resourceName: "star")
                star4.image = #imageLiteral(resourceName: "star")
                star5.image = #imageLiteral(resourceName: "halfStar")
            }
            
        }else if productRating == 5.0
        {
            star1.image = #imageLiteral(resourceName: "star")
            star2.image = #imageLiteral(resourceName: "star")
            star3.image = #imageLiteral(resourceName: "star")
            star4.image = #imageLiteral(resourceName: "star")
            star5.image = #imageLiteral(resourceName: "star")
            
        }
      
    }
    
    
    @IBAction func tapToAddCart(_ sender: UIButton) {
        
        tapOnAddCart(sender)
        
    }
    @IBAction func tapToPackOff(_ sender: UIButton) {
        
        tapOnPackOf(sender)
        
    }
    

    @IBAction func tapToDelete(_ sender: UIButton) {
        
        tapOnDelete(sender)
    }
}
