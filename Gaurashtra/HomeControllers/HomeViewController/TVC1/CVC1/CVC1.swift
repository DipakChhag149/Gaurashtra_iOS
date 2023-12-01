//
//  CVC1.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 27/12/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit
import AlamofireImage

class CVC1: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(withBannerData bannerData : Dictionary<String,Any> , andIndxPath indxPath : IndexPath)
    {
        let imageUrl = String.getString(bannerData["bannerImage"])
        guard let urlBrand = URL.init(string: imageUrl) else { return }
        self.imgView.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
        print("sunish:\(imageUrl)")
    }

    
}
