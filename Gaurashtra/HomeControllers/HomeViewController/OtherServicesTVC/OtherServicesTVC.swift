//
//  OtherServicesTVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 28/12/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class OtherServicesTVC: UITableViewCell {

    
    @IBOutlet weak var otherServicesCV: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.registerNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func registerNib() -> Void
    {
        let nibCards = UINib(nibName: OtherServecesCVC.identifier(), bundle: nil)
        self.otherServicesCV.register(nibCards, forCellWithReuseIdentifier: OtherServecesCVC.identifier())
    }
    
}
extension OtherServicesTVC
{
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        otherServicesCV.delegate = dataSourceDelegate
        otherServicesCV.dataSource = dataSourceDelegate
        otherServicesCV.tag = 2
        //   collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        otherServicesCV.reloadData()
    }
    
}
