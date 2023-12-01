//
//  CartTVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 20/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

typealias TapOnDelete       = (_ tapOnDelete : UIButton) -> ()
typealias TapOnQuantity     = (_ tapOnQuantity : UIButton) -> ()
typealias TapOnMinus        = (_ tapOnMinus : UIButton) -> ()
typealias TapOnPlus         = (_ tapOnPlus : UIButton) -> ()
typealias TapOnSaveLetter   = (_ tapOnSaveLetter : UIButton) -> ()

class CartTVC: UITableViewCell {
    
    fileprivate var tapOnDelete   : TapOnDelete   = { tapOnDelete in }
    fileprivate var tapOnQuantity : TapOnQuantity = { tapOnQuantity in }
    fileprivate var tapOnMinus    : TapOnMinus    = { tapOnMinus in }
    fileprivate var tapOnPlus     : TapOnPlus     = { tapOnPlus in }
    fileprivate var tapOnPackOf   : TapOnPackOf   = { tapOnPackOf in }
    
    fileprivate var tapOnSaveLetter : TapOnSaveLetter = {tapOnSaveLetter in}
    
    @IBOutlet weak var imgCheck: UIImageView!
    
    
    @IBOutlet weak var lblOption_name: UILabel!
    
    @IBOutlet weak var lblOutofStock: UILabel!
    @IBOutlet weak var saveLetterWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnSaveforLetter: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblPercentage: UILabel!
    @IBOutlet weak var lblSpecialPrice: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
   // @IBOutlet weak var lblAvailQty: UILabel!
    
    @IBOutlet weak var lblPriceLine: UILabel!
    
    
    @IBOutlet weak var lblProductName: UILabel!
    
    
    @IBOutlet weak var imgViewProd: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblOutofStock.isHidden = true
        kSharedInstance.setShadow(withSubView: subView, cornerRedius: 0)
        subView.layer.cornerRadius = 4
        subView.clipsToBounds = false
        
        self.getDevice()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.imgCheck.image = selected ? #imageLiteral(resourceName: "checked") : #imageLiteral(resourceName: "check")
    }
    
    func configureCellMyCart(withDaictData dictData : Dictionary<String,Any> , forIndxPath indxPath :  IndexPath , btnDelete : @escaping TapOnDelete , btnPlus : @escaping TapOnPlus , btnPackOf : @escaping TapOnPackOf , btnSaveForLetter : @escaping TapOnSaveLetter)
    {
        tapOnDelete    = btnDelete
        tapOnPackOf    = btnPackOf
       // tapOnMinus     = btnMinus
        tapOnPlus      = btnPlus
        tapOnSaveLetter = btnSaveForLetter
        
        let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
        let value              = CurrencyDataModel.getCurrencySavedDetails().value
        let currecyDoubleValue = Double.getDouble(value)
        self.lblOption_name.text = String.getString(dictData["option_name"])
        let qty = String.getString(dictData["cart_quantity"])
        let cart_product_price_total = Double.getDouble(dictData["cart_product_price"])
       
        let product_price = String.getString(dictData["product_price"])
        
        let special_price = String.getString(dictData["special_price"])
        
        let discount_quantity = Int.getInt(dictData["discount_quantity"])
        
        let discount_price  = String.getString(dictData["discount_price"])
        let cart_quantity  = String.getString(dictData["cart_quantity"])
        let cart_product_price_text = String.getString(dictData["cart_product_price_text"])
        
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
        
        let priceRound = Double(round(100*price)/100)
        
        let specialPrice = Double.getDouble(special_price)*currecyDoubleValue
        
        let tax_rate      = Double.getDouble(dictData["tax_rate"])
        let priceRate = Double(round(100*((price*tax_rate)/100))/100)
       
        let specialPriceRate = Double(round(100*((specialPrice*tax_rate)/100))/100)
       //let specialPriceFlt = Double(round(100*specialPrice)/100) + specialPriceRate
        
        let dicountedAmt = price - specialPrice
        
        let disountedPec = ( dicountedAmt * 100.00) / price
        
        let priceFloat    = Double(round(100*price)/100) + priceRate
        
        let totalAmt = priceFloat*Double.getDouble(cart_product_price_total)
        
        let totalSpecialAmt = specialPrice*Double.getDouble(cart_product_price_total)
        
        let specialPriceFloat    = Double(round(100*specialPrice)/100) + specialPriceRate
        let roundPrice = Double.getDouble(round(100*cart_product_price_total)/100)
        
        self.lblPrice.text = "\(symbol)\(priceFloat)" // "\(symbol)\(priceRound)"  //
        
       // let cart_quantity = Int.getInt(dictData["cart_quantity"])
        
        let product_quantity = Int.getInt(dictData["product_quantity"])
        
        //print(cart_quantity)
        //print(product_quantity)
        
//        if cart_quantity > product_quantity
//        {
//            self.lblAvailQty.text = "Availability:" + String.getString(dictData["product_quantity"])
//
//            self.lblAvailQty.textColor = .red
//        }else{
//
//            self.lblAvailQty.text = ""
//
//        }
        
        
       
        self.lblQty.text = "Qty : " + String.getString(dictData["cart_quantity"])
        
        let per = Double(round(100*disountedPec)/100)
        
        
        if special_price == "0.0000"
        {
            self.lblPriceLine.isHidden           = true
            self.lblSpecialPrice.isHidden        = true
            //            self.viewOfferPercentage.isHidden    = true
            //            self.priceConstraintH.constant       = 20
            self.lblPrice.textColor              = .black
            self.lblPercentage.isHidden          = true
            
            
            self.lblPrice.font  = UIFont.systemFont(ofSize: 16)
            
            
        }else  if special_price != "0.0000"{
            
            self.lblPriceLine.isHidden       = false
            self.lblSpecialPrice.isHidden    = false
            //self.viewOfferPercentage.isHidden     = false
            
            self.lblPercentage.text          = cart_product_price_text //"\(per)%" Double(round(100*specialPrice)/100)
            self.lblSpecialPrice.text        = "\(symbol)\(specialPriceFloat)"
            self.lblPriceLine.text = "\(symbol)\(specialPriceFloat)"
           // self.lblSpecialPrice.text        = "\(symbol)\(specialPrice)"//specialPrice
            self.lblPrice.textColor          = .lightGray
            // self.priceConstraintH.constant       = 20
            
            self.lblPercentage.isHidden          = false
            self.lblPrice.font  = UIFont.systemFont(ofSize: 11)
        }
        self.lblProductName.text = String.getString(dictData["product_name"])
        let imgURL = String.getString(dictData["product_image"])
        
        //        let str = "Swift 3.0 is the best version of Swift to learn, so if you're starting fresh you should definitely learn Swift 3.0."
        let replacedURL = imgURL.replacingOccurrences(of: ".jpg", with: "-300x300.jpg")
        let imageUrl = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL)
        guard let urlBrand = URL.init(string: imageUrl) else { return }
        self.imgViewProd.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
        print("dictDataSunish:\(dictData)")
        let option_id = String.getString(dictData["option_id"])
        if Int.getInt(option_id) != 0
        {
            let option_quantity = String.getString(dictData["option_quantity"])
            if Int.getInt(option_quantity) == 0
            {
                self.lblOutofStock.isHidden = false
                self.lblOutofStock.text     = "Out of Stock"
                let grayImg = self.convertToGrayScale(image: self.imgViewProd.image!)
                self.imgViewProd.image = grayImg
                self.lblProductName.textColor = .gray
                self.btnPlus.isUserInteractionEnabled = false

            }else{
                self.lblOutofStock.isHidden = true
                self.lblProductName.textColor = .black
                self.btnPlus.isUserInteractionEnabled = true
            }
        }else{
            let product_quantity = String.getString(dictData["product_quantity"])
            if Int.getInt(product_quantity) == 0
            {
                self.lblOutofStock.isHidden = false
                self.lblOutofStock.text     = "Out of Stock"
                let grayImg = self.convertToGrayScale(image: self.imgViewProd.image!)
                self.imgViewProd.image = grayImg
                self.lblProductName.textColor = .gray
                self.btnPlus.isUserInteractionEnabled = false

            }else{
                self.lblOutofStock.isHidden = true
                self.lblProductName.textColor = .black
                self.btnPlus.isUserInteractionEnabled = true
            }
        }
       
    }
   //btnplus, lblqty, lblname,productImg
    
   
   
   
    @IBAction func tapToDelete(_ sender: UIButton) {
        tapOnDelete(sender)
        
    }
    
    @IBAction func tapToPlus(_ sender: UIButton) {
        
        tapOnPlus(sender)
        
    }
    
    @IBAction func tapToSaveLatter(_ sender: UIButton) {
        
        tapOnSaveLetter(sender)
        
    }
    func getDevice()
    {
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136://iphone 5/5S/SE
                
             
                self.saveLetterWidthConstraint.constant = 60
                self.lblProductName.font = UIFont(name: "Poppins-Regular", size: 13)
                
                self.btnSaveforLetter.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 10)
              
                
                
            case 1334://iphone 6/6S/7/8
                
                self.saveLetterWidthConstraint.constant = 100
                self.lblProductName.font = UIFont(name: "Poppins-Regular", size: 15)
                
                self.btnSaveforLetter.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 12)
                
            case 2208://iphone 6+/6S+/7+/8+
                
                 self.saveLetterWidthConstraint.constant = 100
                 self.lblProductName.font = UIFont(name: "Poppins-Regular", size: 17)
                 self.btnSaveforLetter.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 14)
                
            case 2436,2778://iphone X/XS
                
                 self.saveLetterWidthConstraint.constant = 100
                 
                 self.lblProductName.font = UIFont(name: "Poppins-Regular", size: 16)
                 self.btnSaveforLetter.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 13)
                
                //print("iphone XS")
                
            case 2688://iphone XS Max
                
                self.saveLetterWidthConstraint.constant = 100
                  self.lblProductName.font = UIFont(name: "Poppins-Regular", size: 17)
                self.btnSaveforLetter.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 14)
                
            case 1792://iphone XR
                
                 self.saveLetterWidthConstraint.constant = 100
                   self.lblProductName.font = UIFont(name: "Poppins-Regular", size: 16)
                 self.btnSaveforLetter.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 14)
                
                //print("iphone XR")
                
                
                
                
                
            default:
                self.saveLetterWidthConstraint.constant = 100
                self.lblProductName.font = UIFont(name: "Poppins-Regular", size: 17)
                self.btnSaveforLetter.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 14)
                
            }
            
        }
  
     }
    func convertToGrayScale(image: UIImage) -> UIImage? {
            let imageRect:CGRect = CGRect(x:0, y:0, width:image.size.width, height: image.size.height)
            let colorSpace = CGColorSpaceCreateDeviceGray()
            let width = image.size.width
            let height = image.size.height
            let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
            let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
            if let cgImg = image.cgImage {
                context?.draw(cgImg, in: imageRect)
                if let makeImg = context?.makeImage() {
                    let imageRef = makeImg
                    let newImage = UIImage(cgImage: imageRef)
                    return newImage
                }
            }
            return UIImage()
        }
}
