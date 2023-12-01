//
//  PaymentGatewayListTVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 04/02/20.
//  Copyright © 2020 Gaurashtra. All rights reserved.
//

import UIKit

class PaymentGatewayListTVC: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        kSharedInstance.setShadow(withSubView: self.subView, cornerRedius: 0)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected
        {
            self.imgView.image = #imageLiteral(resourceName: "correct")
        }else{
            self.imgView.image = #imageLiteral(resourceName: "circle")
        }
    }
    
    func configureCell(withDictData dictData : Dictionary<String,Any> , forIndxpath indxPath: IndexPath)
    {
        //PayPal
//        let title = String.getString(dictData["title"])
//        if title == "PayPal"
//        {
//             self.lblName.text = "Credit / Debit Caed / Netbanking / Wallets /UPI"
//        }else{
//            
//        }
       
        self.lblName.text = String.getString(dictData["title"])
        self.lblMsg.text = String.getString(dictData["description"])
    }

}
