//
//  SearchTVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 14/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit

class SearchTVC: UITableViewCell {

    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var lblProdName: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        kSharedInstance.setShadow(withSubView: subView, cornerRedius: 0)
        subView.layer.cornerRadius = 4
          subView.clipsToBounds = false
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureSerchCell(withDictData dictData: Dictionary<String,Any>, forIndxPath indxPath : IndexPath)
    {
        
        let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
        let value              = CurrencyDataModel.getCurrencySavedDetails().value
        let currecyDoubleValue = Double.getDouble(value)
        
        
        
        let product_price = String.getString(dictData["product_price"])
        let price = Double.getDouble(product_price)*currecyDoubleValue
        
        let tax_rate      = Double.getDouble(dictData["tax_rate"])
        let priceRate     = Double(round(100*((price*tax_rate)/100))/100)
        
        //let specialPriceRate = Double(round(100*((specialPrice*tax_rate)/100))/100)
        // let specialPriceFlt = Double(round(100*specialPrice)/100) 
        
        let priceFloat    = Double(round(100*price)/100) + priceRate
        
        self.lblPrice.text = "\(symbol)\(priceFloat)"
        
        self.lblProdName.text = String.getString(dictData["product_name"])
      
        
        let imgURL = String.getString(dictData["product_image"])
        
        //        let str = "Swift 3.0 is the best version of Swift to learn, so if you're starting fresh you should definitely learn Swift 3.0."
        let replacedURL = imgURL.replacingOccurrences(of: ".jpg", with: "-300x300.jpg")
        
        let imageUrl = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL)
        guard let urlBrand = URL.init(string: imageUrl) else { return }
        self.imgView.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
       
    }
    

}
