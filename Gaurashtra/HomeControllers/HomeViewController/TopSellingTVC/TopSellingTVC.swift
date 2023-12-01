//
//  TVC2.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 27/13/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

typealias TapOnViewMore = (_ tapOnViewMore : UIButton) -> ()

class TopSellingTVC: UITableViewCell {

    fileprivate var tapOnViewMore:TapOnViewMore = {tapOnViewMore in}
    
    @IBOutlet weak var lblTopSelling: UILabel!
    
    
    @IBOutlet weak var btnViewMore: UIButton!
    
    @IBOutlet weak var collectionView2: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.registerNib2()
        self.btnViewMore.isHidden = true
        self.btnViewMore.tag = 1
        
        self.getDevice()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func registerNib2() -> Void
    {
        let nibCards = UINib(nibName: TopSellingCVC.identifier(), bundle: nil)
        self.collectionView2.register(nibCards, forCellWithReuseIdentifier: TopSellingCVC.identifier())
    }
    
    func configureCell(withDictData dictData : Dictionary<String,Any>,arrDataCount arrCount:[Any], forIndxPath indxPath : IndexPath, buttonViewMore: @escaping TapOnViewMore)
    {
        
        if arrCount.count >= 3
        {
            self.btnViewMore.isHidden = false
        }
        
        tapOnViewMore = buttonViewMore
        
    }
    
    @IBAction func tapToViewMore(_ sender: UIButton) {
        tapOnViewMore(sender)
    }
    
    func getDevice()
    {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136://iphone 5/5S/SE
                
                self.btnViewMore.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 11)
                self.lblTopSelling.font = UIFont(name: "Poppins-Medium", size: 15)
                
                
            case 1334://iphone 6/6S/7/8
                self.btnViewMore.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 13)
                
                self.lblTopSelling.font = UIFont(name: "Poppins-Medium", size: 17)
                
                
            case 2208://iphone 6+/6S+/7+/8+
                
                self.btnViewMore.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 13)
                
                self.lblTopSelling.font = UIFont(name: "Poppins-Medium", size: 19)
                
            case 2436://iphone X/XS
                
                self.btnViewMore.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 13)
                
                self.lblTopSelling.font = UIFont(name: "Poppins-Medium", size: 20)
                
                print("iphone XS")
                
            case 2688://iphone XS Max
                
                print("iphone XS Max")
                self.lblTopSelling.font = UIFont(name: "Poppins-Medium", size: 22)
                
                self.btnViewMore.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 13)
            case 1792://iphone XR
                
                print("iphone XR")
                
                
                self.lblTopSelling.font = UIFont(name: "Poppins-Medium", size: 22)
                
                self.btnViewMore.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 13)
                
                
            default:
                print("unknown")
                
                
            }
            
        }
        
    }
    
}
extension TopSellingTVC
{
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        collectionView2.delegate = dataSourceDelegate
        collectionView2.dataSource = dataSourceDelegate
        collectionView2.tag = row
        //collectionView2.tag = 1
        //   collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        collectionView2.reloadData()
    }
    
}
