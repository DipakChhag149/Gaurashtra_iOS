//
//  OtherServecesCVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 28/12/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class OtherServecesCVC: UICollectionViewCell {

    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        kSharedInstance.setShadow(withSubView: subView, cornerRedius: 0)
        
        subView.layer.cornerRadius = 4
        subView.clipsToBounds = false
    }

    func configureCellCategory(withBannerData dictData : Dictionary<String,Any> , andIndxPath indxPath : IndexPath)
    {
        self.lblName.text = String.getString(dictData["name"])
        
        //cat_image
        let imageUrl = String.getString(dictData["cat_image"])
        guard let urlBrand = URL.init(string: imageUrl) else { return }
        self.imgView.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
        
    }
    
}
