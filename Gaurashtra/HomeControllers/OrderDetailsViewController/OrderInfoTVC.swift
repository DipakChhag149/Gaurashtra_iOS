//
//  OrderInfoTVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 17/02/21.
//  Copyright © 2021 Gaurashtra. All rights reserved.
//

import UIKit

class OrderInfoTVC: UITableViewCell {

    @IBOutlet weak var imgDot: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configureCell(withDictData dictData : Dictionary<String,Any>, forIndexPath indxPath : IndexPath)
    {
        let symbol = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
        let value = CurrencyDataModel.getCurrencySavedDetails().value
        let amount  = String.getString(dictData["value"])
        
        let currecyDoubleValue = Double.getDouble(value)
        let price = Double.getDouble(amount)*currecyDoubleValue
        
        let priceRate = Double(round(100*price)/100)
        
        //  self.lblPaymentMode.text = String.getString(dictData["paymentMethod"])
        //  self.lblOrderDate.text = String.getString(dictData["orderDate"])
        
        self.lblValue.text = "\(symbol)\(priceRate)"
       // self.lblTitle.text = String.getString(dictData["title"])
        let codeStr = String.getString(dictData["code"])
        if codeStr == "total"
        {//
            self.imgDot.isHidden = false
            self.lblTitle.font = UIFont.init(name: "Poppins-Medium", size: 16)
            self.lblValue.font = UIFont.boldSystemFont(ofSize: 14)
        }else{
            self.imgDot.isHidden = true
            self.lblTitle.font = UIFont.init(name: "Poppins-Regular", size: 15)
            self.lblValue.font = UIFont.systemFont(ofSize: 15)
        }
        if codeStr == "shipping"
        {
            self.lblTitle.text = String.getString(dictData["title"])
        }else{
            self.lblTitle.text = String.getString(dictData["title"])
        }
        if codeStr == "shipping"
        {
            let titleSlipted = String.getString(dictData["title"])
            let titleArr = titleSlipted.components(separatedBy: "(")
            if titleArr.count > 1
            {
                self.lblTitle.text  = "Shipping Charge(\(titleArr[1])"
            }
        }
    }
    
}
