//
//  ShopByBrandListTVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 05/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit

class ShopByBrandListTVC: UITableViewCell {

    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.getDevice()
    }

   
    func getDevice()
    {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136://iphone 5/5S/SE
                
                self.lblName.font = UIFont(name: "Poppins-Regular", size: 12)
            case 1334://iphone 6/6S/7/8
                self.lblName.font = UIFont(name: "Poppins-Regular", size: 14)
            case 2208://iphone 6+/6S+/7+/8+
                self.lblName.font = UIFont(name: "Poppins-Regular", size: 16)
            case 2436://iphone X/XS
                self.lblName.font = UIFont(name: "Poppins-Regular", size: 16)
                //print("iphone XS")
            case 2688,2778://iphone XS Max
                //print("iphone XS Max")
                self.lblName.font = UIFont(name: "Poppins-Regular", size: 18)
            case 1792://iphone XR
                //print("iphone XR")
                self.lblName.font = UIFont(name: "Poppins-Regular", size: 17)
            default:
                self.lblName.font = UIFont(name: "Poppins-Regular", size: 16)
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configureBrandsCell(withDictData dictData: Dictionary<String,Any>, forIndxPath indxPath : IndexPath )
    {
        self.lblName.text = String.getString(dictData["brand_name"]).replacingOccurrences(of: "&amp;", with: "")
    }
}
