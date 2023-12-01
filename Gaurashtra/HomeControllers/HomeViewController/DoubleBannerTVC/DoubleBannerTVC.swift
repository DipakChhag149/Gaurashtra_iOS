//
//  DoubleBannerTVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 28/12/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

typealias TapOnBtn = (_ tapOnBtn : UIButton) -> ()

class DoubleBannerTVC: UITableViewCell {

    @IBOutlet weak var CVDoubler: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.registerNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }//
    
    private func registerNib() -> Void
    {
        let nibCards = UINib(nibName: DoubleBannerCVC.identifier(), bundle: nil)
        self.CVDoubler.register(nibCards, forCellWithReuseIdentifier: DoubleBannerCVC.identifier())
    }
    
//    func configureCellDoubleBanner(withArrData arrData : [Any], forIndxPath indxPath : IndexPath, button1: @escaping TapOnBtn, button2: @escaping TapOnBtn)
//    {
//       
//    }
  
}
extension DoubleBannerTVC
{

    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        CVDoubler.delegate = dataSourceDelegate
        CVDoubler.dataSource = dataSourceDelegate
        CVDoubler.tag = 8
        //   collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        CVDoubler.reloadData()
    }

}
