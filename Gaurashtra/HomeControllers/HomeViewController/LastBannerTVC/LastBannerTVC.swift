//
//  LastBannerTVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 28/12/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class LastBannerTVC: UITableViewCell {
    
    @IBOutlet weak var CVLastBanner: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.registerNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func registerNib() -> Void
    {
      let nibCards = UINib(nibName: LastBannerCVC.identifier(), bundle: nil)
      self.CVLastBanner.register(nibCards, forCellWithReuseIdentifier: LastBannerCVC.identifier())
    }


}
extension LastBannerTVC
{
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        CVLastBanner.delegate = dataSourceDelegate
        CVLastBanner.dataSource = dataSourceDelegate
        CVLastBanner.tag = 13
        CVLastBanner.reloadData()
    }
}
