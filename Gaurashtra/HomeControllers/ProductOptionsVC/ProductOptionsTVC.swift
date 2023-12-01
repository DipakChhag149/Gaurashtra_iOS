//
//  ProductOptionsTVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 22/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit


class ProductOptionsTVC: UITableViewCell {
    //TapOnQuantity
    fileprivate var tapOnAddCart : TapOnAddCart = { tapOnAddCart in }
    fileprivate var tapOnQuantity : TapOnQuantity = { tapOnQuantity in }
    
    @IBOutlet weak var qtyView: UIView!
    
    
    @IBOutlet weak var lblOptionName: UILabel!
    
    @IBOutlet weak var lblQnty: UILabel!
    
    @IBOutlet weak var img1: UIImageView!
 
    @IBOutlet weak var img5: UIImageView!
    
    @IBOutlet weak var img4: UIImageView!
   
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    
    @IBOutlet weak var btnAddCart: UIButton!
    
  
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var prodName: UILabel!
    
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var imgWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var btnQty: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        kSharedInstance.setShadow(withSubView: subView, cornerRedius: 0)
        
        subView.layer.cornerRadius = 0
           subView.clipsToBounds = false
        
        self.getDevice()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureProdOptionCell(withDictData dictData : Dictionary<String,Any>, forIndxPath indxPath : IndexPath , data : Dictionary<String,Any> ,btnAddCart :@escaping TapOnAddCart , btnQnty : @escaping TapOnQuantity )
    {
        //print(dictData)
        //print(data)
        
        tapOnAddCart  = btnAddCart
        tapOnQuantity = btnQnty
        
        
        let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
        let value              = CurrencyDataModel.getCurrencySavedDetails().value
        let currecyDoubleValue = Double.getDouble(value)
        
        let product_price = String.getString(data["product_price"])
        let product_priceDbl = Double.getDouble(product_price)*currecyDoubleValue
        
        
        let option_price = String.getString(dictData["option_price"])
        let option_priceDbl = Double.getDouble(option_price)*currecyDoubleValue
     
        let option_price_prefix = String.getString(dictData["option_price_prefix"])
        
        self.lblOptionName.text = String.getString(dictData["option_name"])
        
        let tax_rate      = Double.getDouble(dictData["tax_rate"])
        let priceRate = Double(round(100*((Double.getDouble(product_price)*tax_rate)/100))/100)
     
       // let specialPriceRate = Double(round(100*((specialPrice*tax_rate)/100))/100)
       //let specialPriceFlt = Double(round(100*specialPrice)/100) + specialPriceRate
        
        let selectedQty = String.getString(dictData["selectedQty"])
               
               if Int.getInt(selectedQty) == 0
               {
                   self.lblQnty.text = "1"
                   
               }else{
               
                    self.lblQnty.text = selectedQty
                   
               }
        
        
        if option_price_prefix == "+"
        {
           let totalPrice = product_priceDbl + option_priceDbl
            
            let priceFloat    = Double(round(100*totalPrice)/100) + priceRate
            
            
            self.lblPrice.text = "\(symbol)\(priceFloat)"
            
        }else{
            
          let  totalPrice = product_priceDbl - option_priceDbl
            
          let priceFloat    = Double(round(100*totalPrice)/100) + priceRate
            
            
          self.lblPrice.text = "\(symbol)\(priceFloat)"
            
        }
       
        
       // self.lblPrice.font  = UIFont.systemFont(ofSize: 11)
        
       
        
        self.prodName.text = String.getString(data["product_name"])
        
        let imgURL = String.getString(data["product_image"])
        
        //        let str = "Swift 3.0 is the best version of Swift to learn, so if you're starting fresh you should definitely learn Swift 3.0."
        let replacedURL = imgURL.replacingOccurrences(of: ".jpg", with: "-300x300.jpg")
        
        let imageUrl = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL)
        guard let urlBrand = URL.init(string: imageUrl) else { return }
        self.imgView.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
        
    }
    
    
    @IBAction func tapToQty(_ sender: UIButton) {
   
        tapOnQuantity(sender)
        
    }
    

    @IBAction func tapToAddCart(_ sender: UIButton) {
        tapOnAddCart(sender)
    }
    
    
    func getDevice()
    {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136://iphone 5/5S/SE
                
                self.prodName.font = UIFont(name: "Poppins-Medium", size: 11)
              
                
               self.imgWidthConstraint.constant = 70
            
            case 1334://iphone 6/6S/7/8
                self.prodName.font = UIFont(name: "Poppins-Medium", size: 12)
                
               // self.lblPrice.font = UIFont.systemFont(ofSize: 12, weight: .medium)
                
               self.imgWidthConstraint.constant = 85
                
            case 2208://iphone 6+/6S+/7+/8+
                
                self.prodName.font = UIFont(name: "Poppins-Medium", size: 13)
                
                self.imgWidthConstraint.constant = 100
                
                
            case 2436://iphone X/XS
                
                self.prodName.font = UIFont(name: "Poppins-Medium", size: 13)
                self.imgWidthConstraint.constant = 100
                //print("iphone XS")
                
            case 2688,2778://iphone XS Max
                
                //print("iphone XS Max")
                
                self.prodName.font = UIFont(name: "Poppins-Medium", size: 13)
                
                self.imgWidthConstraint.constant = 110
                
            case 1792://iphone XR
                
                self.prodName.font = UIFont(name: "Poppins-Medium", size: 13)
                
                self.imgWidthConstraint.constant = 100
               
                
            default:
                self.prodName.font = UIFont(name: "Poppins-Medium", size: 13)
                self.imgWidthConstraint.constant = 100
            }
            
        }
        
    }
    
}
