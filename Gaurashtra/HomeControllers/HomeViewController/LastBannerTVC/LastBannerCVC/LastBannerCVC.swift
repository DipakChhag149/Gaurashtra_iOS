//
//  LastBannerCVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 19/06/20.
//  Copyright © 2020 Gaurashtra. All rights reserved.
//

import UIKit

class LastBannerCVC: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureLastBannerCell(withBannerData dictData : Dictionary<String,Any> , andIndxPath indxPath : IndexPath)
    {
        let imgURL = String.getString(dictData["bannerImage"])

        guard let urlBrand = URL.init(string: imgURL) else { return }
        self.imgView.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
    }

}
