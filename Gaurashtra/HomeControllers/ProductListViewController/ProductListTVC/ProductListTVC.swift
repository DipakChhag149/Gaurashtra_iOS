//
//  HomeTVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 06/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit
typealias TapOnView     = (_ tapOnView : UIButton) -> ()
typealias TapOnPackOf   = (_ apOnPackOf : UIButton) -> ()

class ProductListTVC: UITableViewCell {

    fileprivate var tapOnAddCArt:TapOnAddCart = { tapOnAddCArt in}
    
    fileprivate var tapOnView:TapOnView = { tapOnView in}
    
    fileprivate var tapOnPackOf:TapOnPackOf = { tapOnPackOf in}
    
    
    @IBOutlet weak var qtyView: UIView!
    
    @IBOutlet weak var subView: UIView!
    
    
    @IBOutlet weak var lblProdName: UILabel!
    
    @IBOutlet weak var prodImgView: UIImageView!
    
   // @IBOutlet weak var viewPackOf: UIView!
    
    @IBOutlet weak var showView: UIView!
    
    @IBOutlet weak var btnAddcart: UIButton!
    @IBOutlet weak var lblNoOfferPrice: UILabel!
    
    
    @IBOutlet weak var addCartConstraintWidth: NSLayoutConstraint!
    
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblPriceLine: UILabel!
    
    
    @IBOutlet weak var lblSpecialPrice: UILabel!
    
    @IBOutlet weak var btnView: UIButton!
    
    
    @IBOutlet weak var viewPercentage: UIView!
    
    @IBOutlet weak var lblOffPercentage: UILabel!
    
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var view2: UIView!
    
    
    @IBOutlet weak var lblPackOf: UILabel!
    
    @IBOutlet weak var btnPackOf: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        kSharedInstance.setShadow(withSubView: subView, cornerRedius: 0)
        
        subView.layer.cornerRadius = 4
        subView.clipsToBounds = false
        
        self.getDevice()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
   
    
    func configureCellProductListTVC(withDictData dictData : Dictionary<String,Any>, forIndxPath indxPath : IndexPath, btnAddCart : @escaping TapOnAddCart,btnPackOff : @escaping TapOnPackOf , btnView : @escaping TapOnView)
        
    {
     
        tapOnView    = btnView
        tapOnPackOf  = btnPackOff
        tapOnAddCArt = btnAddCart
        
        
        let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
        let value              = CurrencyDataModel.getCurrencySavedDetails().value
        let currecyDoubleValue = Double.getDouble(value)
        
        
        
        
        let product_price = String.getString(dictData["product_price"])
        
        let special_price = String.getString(dictData["special_price"])
        
        let price = Double.getDouble(product_price)*currecyDoubleValue
        
        let specialPrice = Double.getDouble(special_price)*currecyDoubleValue
        
        let tax_rate      = Double.getDouble(dictData["tax_rate"])
        let priceRate = Double(round(100*((price*tax_rate)/100))/100)
        
        let specialPriceRate = Double(round(100*((specialPrice*tax_rate)/100))/100)
        // let specialPriceFlt = Double(round(100*specialPrice)/100) +
        
        
        let dicountedAmt = price - specialPrice
        
        let disountedPec = ( dicountedAmt * 100.00) / price
        
        let priceFloat    = Double(round(100*price)/100) + priceRate
        
        let specialPriceDbl = Double(round(100*specialPrice)/100) + specialPriceRate
        
        self.lblPrice.font  = UIFont.systemFont(ofSize: 11)
        
        
        
        let per = Double(round(100*disountedPec)/10)
        
        let discount_quantity = String.getString(dictData["discount_quantity"])
        
        let discount_price = String.getString(dictData["discount_price"])
        
        let selectedQty = String.getString(dictData["selectedQty"])
        
        
        let product_quantity = String.getString(dictData["product_quantity"])
        
        if Int.getInt(product_quantity) != 0
        {
            self.btnAddcart.setTitle("Add to Cart", for: .normal)
            
            self.qtyView.isHidden = false
            
            self.btnAddcart.backgroundColor = UIColor(red: 255.0/255.0, green: 97.0/255.0, blue: 33.0/255.0, alpha: 1.0)
            
        }else{
            
            self.btnAddcart.setTitle("Notify Me", for: .normal)
            self.btnAddcart.backgroundColor = UIColor(red: 149.0/255.0, green: 165.0/255.0, blue: 166.0/255.0, alpha: 1.0)
            self.qtyView.isHidden = true
            
        }
        
        if Int.getInt(selectedQty) == 0
        {
            self.lblPackOf.text = "1"
        }else{
             self.lblPackOf.text = selectedQty
        }
            if special_price == "0.0000"
        {
            self.view1.isHidden           = true
            self.view1.isHidden           = true
            self.lblSpecialPrice.isHidden = true
            self.lblPrice.isHidden        = true
            self.lblPriceLine.isHidden    = true
            self.lblNoOfferPrice.isHidden     = false
            
            
            self.lblNoOfferPrice.font  = UIFont.systemFont(ofSize: 12)
            self.viewPercentage.isHidden = true
            
            if Int.getInt(dictData["selecteIndex"]) == indxPath.row {
                
                if Int.getInt(dictData["selectetag"]) == 1
                {
                    
                    //print(Int.getInt(dictData["selecteIndex"]))
                    
                    //print(discount_quantity)
                    //print(discount_price)
                    
                    let dicountQntyDbl = Double.getDouble(discount_quantity)
                    
                    let discountPrice = Double.getDouble(discount_price)
                    
                    //print(discountPrice)
                    
                    self.lblNoOfferPrice.text  = "\(symbol)\(priceFloat)"
                    

                }else{
                    
                    self.lblNoOfferPrice.text  = "\(symbol)\(priceFloat)"
//                    self.viewPackOf.backgroundColor = UIColor(red: 234.0/255.0, green: 234.0/255.0, blue: 234.0/255.0, alpha: 1.0)
                    
                }
                
                
            }else{
                
                self.lblNoOfferPrice.text  = "\(symbol)\(priceFloat)"
            }
            
            
            
        }else  if special_price != "0.0000"{
            
            self.viewPercentage.isHidden      = false
            self.lblNoOfferPrice.isHidden     = true
            
            self.view1.isHidden        = false
            self.view1.isHidden        = false
            
            self.lblSpecialPrice.isHidden = false
            self.lblPrice.isHidden        = false
            self.lblPriceLine.isHidden    = false
            
            self.lblPrice.text            =  "\(symbol)\(priceFloat)"
            self.lblOffPercentage.text  = "\(per)%OFF"
            self.lblSpecialPrice.text     = "\(symbol)\(specialPriceDbl)"
            self.lblPrice.textColor       = .lightGray
            //  self.priceConstraintH.constant  = 20
        }
       
        //        if special_price == "0.0000"
        //        {
        //            self.lblPriceLine.isHidden           = true
        //            self.lblSpecialPrice.isHidden        = true
        //            self.viewOfferPercentage.isHidden    = true
        //            self.priceConstraintH.constant       = 20
        //            self.lblPrice.textColor              = .black
        //
        //            self.lblPrice.font  = UIFont.systemFont(ofSize: 14)
        //
        //
        //        }else{
        //
        //            self.lblPriceLine.isHidden       = false
        //            self.lblSpecialPrice.isHidden = false
        //            self.viewOfferPercentage.isHidden     = false
        //
        //            self.lblPercentage.text         = "\(per)"
        //            self.lblSpecialPrice.text     = "\(symbol)\(special_price)"
        //            self.lblPrice.textColor              = .lightGray
        //            self.priceConstraintH.constant       = 20
        //            self.lblPrice.font  = UIFont.systemFont(ofSize: 11)
        //
        //        }
        //
        

        let option_id = String.getString(dictData["option_id"])
        if option_id != "0"
        {
            self.showView.isHidden = false
        }else{
            
            self.showView.isHidden = true
        }
      
        self.lblProdName.text = String.getString(dictData["product_name"])
        
        let imgURL = String.getString(dictData["product_image"])
        
        //        let str = "Swift 3.0 is the best version of Swift to learn, so if you're starting fresh you should definitely learn Swift 3.0."
        let replacedURL = imgURL.replacingOccurrences(of: ".jpg", with: "-300x300.jpg")
        
        let imageUrl = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL)
        guard let urlBrand = URL.init(string: imageUrl) else { return }
        self.prodImgView.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
        
    }
    
    
    @IBAction func tapToAddCart(_ sender: UIButton) {
     
        tapOnAddCArt(sender)
        
    }
    
    @IBAction func taptoPackOf(_ sender: UIButton) {
        
        tapOnPackOf(sender)
        
    }
    
    
    @IBAction func tapToView(_ sender: UIButton) {
        
        tapOnView(sender)
        
    }
    
    
    func getDevice()
    {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136://iphone 5/5S/SE
                
                self.lblProdName.font = UIFont(name: "Poppins-Medium", size: 12)
                self.lblPrice.font = UIFont(name: "Poppins-Regular", size: 10)
                
                // self.lblOfferPercentage.font = UIFont(name: "Poppins-Regular", size: 10)
                
                self.lblSpecialPrice.font = UIFont.systemFont(ofSize: 10, weight: .regular)
                
                self.lblNoOfferPrice.font = UIFont(name: "Poppins-Regular", size: 10)
                
                self.btnAddcart.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 12)
                
                self.addCartConstraintWidth.constant = 80
                
                
            case 1334://iphone 6/6S/7/8
                self.lblProdName.font = UIFont(name: "Poppins-Medium", size: 14)
                
                self.lblPrice.font = UIFont.systemFont(ofSize: 15, weight: .medium)
                
                // self.lblOfferPercentage.font = UIFont(name: "Poppins-Regular", size: 14)
                
                self.lblSpecialPrice.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                
                self.lblNoOfferPrice.font = UIFont.systemFont(ofSize: 15, weight: .medium)
                
                 self.btnAddcart.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 14)
                
                self.addCartConstraintWidth.constant = 100
                
            case 2208://iphone 6+/6S+/7+/8+
                
                self.lblProdName.font = UIFont(name: "Poppins-Medium", size: 15)
                
                self.lblPrice.font = UIFont.systemFont(ofSize: 15)
                
                // self.lblOfferPercentage.font = UIFont(name: "Poppins-Regular", size: 15)
                
                self.lblSpecialPrice.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                
                self.lblNoOfferPrice.font = UIFont.systemFont(ofSize: 15, weight: .medium)
                 self.btnAddcart.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 14)
                
                self.addCartConstraintWidth.constant = 110
                
            case 2436://iphone X/XS
                
                self.lblProdName.font = UIFont(name: "Poppins-Medium", size: 15)
                
                self.lblPrice.font = UIFont.systemFont(ofSize: 15)
                
                // self.lblOfferPercentage.font = UIFont(name: "Poppins-Regular", size: 15)
                
                self.lblNoOfferPrice.font = UIFont.systemFont(ofSize: 15, weight: .medium)
                
                self.lblSpecialPrice.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                
                 self.btnAddcart.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 14)
                
                 self.addCartConstraintWidth.constant = 110
                
                //print("iphone XS")
                
            case 2688,2778://iphone XS Max
                
                //print("iphone XS Max")
                
                self.lblProdName.font = UIFont(name: "Poppins-Medium", size: 15)
                
                self.lblPrice.font = UIFont.systemFont(ofSize: 15)
                
                // self.lblOfferPercentage.font = UIFont(name: "Poppins-Regular", size: 15)
                
                self.lblNoOfferPrice.font = UIFont.systemFont(ofSize: 15, weight: .medium)
                
                self.lblSpecialPrice.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                self.btnAddcart.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 14)
                
                 self.addCartConstraintWidth.constant = 110
                
            case 1792://iphone XR
                
                self.lblProdName.font = UIFont(name: "Poppins-Medium", size: 15)
                
                self.lblPrice.font = UIFont.systemFont(ofSize: 15)
                
                // self.lblOfferPercentage.font = UIFont(name: "Poppins-Regular", size: 15)
                
                self.lblNoOfferPrice.font = UIFont.systemFont(ofSize: 15, weight: .medium)
                
                self.lblSpecialPrice.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                self.btnAddcart.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 14)
                
                 self.addCartConstraintWidth.constant = 110
                
            default:
                self.lblProdName.font = UIFont(name: "Poppins-Medium", size: 15)
                
                self.lblPrice.font = UIFont.systemFont(ofSize: 15)
                
                // self.lblOfferPercentage.font = UIFont(name: "Poppins-Regular", size: 15)
                
                self.lblNoOfferPrice.font = UIFont.systemFont(ofSize: 15, weight: .medium)
                
                self.lblSpecialPrice.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                
                 self.btnAddcart.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 14)
                
                 self.addCartConstraintWidth.constant = 110
                
            }
            
        }
        
    }
    
    
    
    func setShadow(withSubView subView:UIView)
    {
        
        //subView.layer.cornerRadius = 0
        // subView.clipsToBounds = true
        subView.layer.shadowOpacity = 0.9
        subView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        subView.layer.shadowRadius = 2.0
        
        // subView.layer.shadowColor = UIColor.white.cgColor
        subView.layer.shadowColor = UIColor(red: 192.0/255.0, green: 212.0/255.0, blue: 234.0/248.0, alpha: 1.0).cgColor
        
    }
    

}
