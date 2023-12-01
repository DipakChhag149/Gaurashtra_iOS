//
//  Banner3TVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 28/12/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class Banner3TVC: UITableViewCell {

   
    @IBOutlet weak var CVBanner3: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.registerNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func configureCellVideoBanner3(withBannerData dictData : Dictionary<String,Any> , andIndxPath indxPath : IndexPath)
//    {
//        let imageUrl = String.getString(dictData["bannerImage"])
//        guard let urlBrand = URL.init(string: imageUrl) else { return }
//        self.imgViewBanner.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
//    }
    private func registerNib() -> Void
    {
       let nibCards = UINib(nibName: Banner3CVC.identifier(), bundle: nil)
       self.CVBanner3.register(nibCards, forCellWithReuseIdentifier: Banner3CVC.identifier())
    }

}
extension Banner3TVC
{

    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        CVBanner3.delegate = dataSourceDelegate
        CVBanner3.dataSource = dataSourceDelegate
        CVBanner3.tag = 12
        CVBanner3.reloadData()
    }

}
