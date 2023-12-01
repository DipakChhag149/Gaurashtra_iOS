//
//  Banner2TVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 28/12/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class Banner2TVC: UITableViewCell {
    
    @IBOutlet weak var CVAfterTodayDeal: UICollectionView!
    
    
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
        let nibCards = UINib(nibName: Banner2CVC.identifier(), bundle: nil)
        self.CVAfterTodayDeal.register(nibCards, forCellWithReuseIdentifier: Banner2CVC.identifier())
    }
    
}
extension Banner2TVC
{

    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        CVAfterTodayDeal.delegate = dataSourceDelegate
        CVAfterTodayDeal.dataSource = dataSourceDelegate
        CVAfterTodayDeal.tag = 11
        //   collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        CVAfterTodayDeal.reloadData()
    }

}
