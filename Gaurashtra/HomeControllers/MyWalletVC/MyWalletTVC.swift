//
//  MyWalletTVC.swift
//  Gaurashtra
//
//  Created by Algosoft Technologies on 10/2/20.
//  Copyright © 2020 Gaurashtra. All rights reserved.
//

import UIKit

class MyWalletTVC: UITableViewCell {

    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblAddedDate: UILabel!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var subView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        kSharedInstance.setShadow(withSubView: self.subView, cornerRedius: 0)
        subView.layer.cornerRadius = 4
        subView.clipsToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(withDictData dictData : Dictionary<String,Any>, forIndxPath indxPath : IndexPath)
    {
      //  print(dictData)
        
               let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
               let value              = CurrencyDataModel.getCurrencySavedDetails().value
               let currecyDoubleValue = Double.getDouble(value)
               let amount = String.getString(dictData["amount"])
               let walletDbl = Double.getDouble(amount)*currecyDoubleValue
               let priceRate = Double(round(100*walletDbl)/100)
           
               self.lblMsg.text    = String.getString(dictData["description"])
               self.lblAmount.text = "\(symbol)\(priceRate)"   
               let date_added      = String.getString(dictData["date_added"])
        
            if String.getLength(date_added) != 0
            {
              let dateFormatter = DateFormatter()
              dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
              dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
              let date = dateFormatter.date(from:date_added)!
              //let formatter2 = DateFormatter()
//              dateFormatter.dateFormat = "MMMM dd yyyy hh:mm a"
                dateFormatter.dateFormat = "MMM dd yyyy"
                let finaltime = dateFormatter.string(from: date)
                
              let replaced = finaltime.replacingOccurrences(of: "January", with: "Jan")
              let replaced2 = replaced.replacingOccurrences(of: "February", with: "Feb")
              let replaced3 = replaced2.replacingOccurrences(of: "August", with: "Aug")
              let replaced4 = replaced3.replacingOccurrences(of: "September", with: "Sept")
              let replaced5 = replaced4.replacingOccurrences(of: "October", with: "Oct")
              let replaced6 = replaced5.replacingOccurrences(of: "November", with: "Nov")
              let replaced7 = replaced6.replacingOccurrences(of: "December", with: "Dec")
              self.lblAddedDate.text = String.getString(finaltime)
          }
        
                  
               
    }

}
