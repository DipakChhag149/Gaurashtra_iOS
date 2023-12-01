//
//  ConfirmOrderTVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 20/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit

class ConfirmOrderTVC: UITableViewCell {
   
    
    fileprivate var tapOnDelete   : TapOnDelete   = { tapOnDelete in }
    fileprivate var tapOnMinus    : TapOnMinus    = { tapOnMinus in }
    fileprivate var tapOnPlus     : TapOnPlus     = { tapOnPlus in }
   
    @IBOutlet weak var lblAvailQty: UILabel!
    @IBOutlet weak var lblNoOfferPrice: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var lblSpecialPrice: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lblPecOff: UILabel!
    
    @IBOutlet weak var lblPriceLine: UILabel!
    
    @IBOutlet weak var lblProdName: UILabel!
    @IBOutlet weak var subview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        kSharedInstance.setShadow(withSubView: subview, cornerRedius: 0)
        subview.layer.cornerRadius = 4
        subview.clipsToBounds = false
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellConfirmOrder(withDaictData dictData : Dictionary<String,Any> , forIndxPath indxPath :  IndexPath , btnDelete : @escaping TapOnDelete , btnPlus : @escaping TapOnPlus)
    {
        tapOnDelete    = btnDelete
       
        tapOnPlus      = btnPlus
        
        let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
        let value              = CurrencyDataModel.getCurrencySavedDetails().value
        let currecyDoubleValue = Double.getDouble(value)
 
        let product_price = String.getString(dictData["product_price"])
        
        let special_price = String.getString(dictData["special_price"])
        
        let discount_quantity = Int.getInt(dictData["discount_quantity"])
        
        let discount_price  = String.getString(dictData["discount_price"])
        let cart_quantity  = String.getString(dictData["cart_quantity"])
        
        var price : Double = 0.00
        
        if discount_quantity == 0
        {
            price = Double.getDouble(product_price)*currecyDoubleValue
        }else{
            if Int.getInt(cart_quantity) >= Int.getInt(discount_quantity)
            {
                price = Double.getDouble(discount_price)*currecyDoubleValue
            }else{
                price = Double.getDouble(product_price)*currecyDoubleValue
            }
            
        }

        
        
       // let price = Double.getDouble(product_price)*currecyDoubleValue
        
        let specialPrice = Double.getDouble(special_price)*currecyDoubleValue
        
        let tax_rate      = Double.getDouble(dictData["tax_rate"])
        let priceRate     = Double(round(100*((price*tax_rate)/100))/100)
        let specialPriceRate = Double(round(100*((specialPrice*tax_rate)/100))/100)
        
        let dicountedAmt = price - specialPrice
        
        let disountedPec = ( dicountedAmt * 100.00) / price
        
        let priceFloat    = Double(round(100*price)/100) + priceRate
        
        let specialPriceFloat    = Double(round(100*specialPrice)/100) + specialPriceRate
        
        self.lblPrice.text =  "\(symbol)\(priceFloat)"
        
       // let cart_quantity = Int.getInt(dictData["cart_quantity"])
        
        let product_quantity = Int.getInt(dictData["product_quantity"])
        
        
        
        
        //print(cart_quantity)
        //print(product_quantity)
        
        if Int.getInt(cart_quantity) > product_quantity
        {
            self.lblAvailQty.text = "Availability:" + String.getString(dictData["product_quantity"])
            
            self.lblAvailQty.textColor = .red
        }else{
            
            self.lblAvailQty.text = ""
            
        }
        
        let qty = String.getString(dictData["cart_quantity"])
        
        //print("qty : \(qty)")
        
        self.lblQty.text = String.getString(dictData["cart_quantity"])
        
        let per = Double(round(100*disountedPec)/100)
        
        if special_price == "0.0000"
        {
            self.lblPriceLine.isHidden           = true
            self.lblSpecialPrice.isHidden        = true
            //            self.viewOfferPercentage.isHidden    = true
            //            self.priceConstraintH.constant       = 20
            self.lblPrice.textColor              = .black
            self.lblPecOff.isHidden          = true
            
            
            self.lblPrice.font  = UIFont.systemFont(ofSize: 12)
            
            
        }else  if special_price != "0.0000"{
            
            self.lblPriceLine.isHidden       = false
            self.lblSpecialPrice.isHidden    = false
            //self.viewOfferPercentage.isHidden     = false
            
            self.lblPecOff.text          = "\(per)%"
            self.lblSpecialPrice.text        = "\(symbol)\(specialPriceFloat)"
            self.lblPrice.textColor          = .lightGray
            // self.priceConstraintH.constant       = 20
            
            self.lblPecOff.isHidden          = false
            self.lblPrice.font  = UIFont.systemFont(ofSize: 11)
            
        }
        
        
        self.lblProdName.text = String.getString(dictData["product_name"])
        
        let imgURL = String.getString(dictData["product_image"])
        
        //        let str = "Swift 3.0 is the best version of Swift to learn, so if you're starting fresh you should definitely learn Swift 3.0."
        let replacedURL = imgURL.replacingOccurrences(of: ".jpg", with: "-300x300.jpg")
        
        let imageUrl = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL)
        guard let urlBrand = URL.init(string: imageUrl) else { return }
        self.imgView.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
        
        
        
    }
    
    @IBAction func tapToDelete(_ sender: UIButton) {
        tapOnDelete(sender)
        
    }
    @IBAction func tapToPlus(_ sender: UIButton) {
        
        tapOnPlus(sender)
        
    }
    
  
}
