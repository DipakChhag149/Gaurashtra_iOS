//
//  CategoryTVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 07/01/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit

class CategoryTVC: UITableViewCell {

    @IBOutlet weak var subView: UIView!
    
    
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.getDevice()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(withDictData dictData: Dictionary<String,Any>, forIndxPath indxPath : IndexPath )
    {
        
        self.lblName.text = String.getString(dictData["name"])
        
    }
    
    func getDevice()
    {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136://iphone 5/5S/SE
                
                self.lblName.font = UIFont(name: "Poppins-Medium", size: 12)
                
                
                
            case 1334://iphone 6/6S/7/8
                self.lblName.font = UIFont(name: "Poppins-Medium", size: 14)
                
                
                
                
            case 2208://iphone 6+/6S+/7+/8+
                
                self.lblName.font = UIFont(name: "Poppins-Medium", size: 15)
                
                
                
            case 2436://iphone X/XS
                
                self.lblName.font = UIFont(name: "Poppins-Medium", size: 15)
                
                
                
                
                //print("iphone XS")
                
            case 2688,2778://iphone XS Max
                
                //print("iphone XS Max")
                
                self.lblName.font = UIFont(name: "Poppins-Medium", size: 15)
                
                
                
            case 1792://iphone XR
                
                self.lblName.font = UIFont(name: "Poppins-Medium", size: 15)
                
                
                
                
            default:
                self.lblName.font = UIFont(name: "Poppins-Medium", size: 15)
            }
            
        }
        
    }
    
}
