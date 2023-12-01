//
//  ShopByBrandCVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 28/12/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class ShopByBrandCVC: UICollectionViewCell {

    @IBOutlet weak var lblBrandName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCellShopByBrand(withBannerData dictData : Dictionary<String,Any> , andIndxPath indxPath : IndexPath)
    {
        //print(dictData)
        self.lblBrandName.text = String.getString(dictData["brand_name"]).replacingOccurrences(of: "&amp;", with: "")
    }
}
