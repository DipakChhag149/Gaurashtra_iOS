//
//  BannerCVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 27/12/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit
import AlamofireImage

class BannerCVC: UICollectionViewCell {

    
    @IBOutlet weak var imgBanner: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(withBannerData bannerData : Dictionary<String,Any> , andIndxPath indxPath : IndexPath)
    {
      
        
        let imageUrl = String.getString(bannerData["sliderImage"])
        
        guard let urlBrand = URL.init(string: imageUrl) else { return }
        self.imgBanner.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
    }

}
