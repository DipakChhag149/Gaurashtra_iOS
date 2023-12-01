//
//  CouponTVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 05/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit

class CouponTVC: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lblCouponCode: UILabel!
    
    @IBOutlet weak var lblText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected
        {
            self.imgView.image = #imageLiteral(resourceName: "dot")
            
        }else{
            
            self.imgView.image = #imageLiteral(resourceName: "redioUncheck")
        }
        
        
    }
    
    func configureCell(withDictData dictData : Dictionary<String,Any>, forIndxPath indxPath : IndexPath)
    {
        
        self.lblCouponCode.text = String.getString(dictData["coupon_code"])
        self.lblText.text = String.getString(dictData["coupon_content"])
        
    }

}
