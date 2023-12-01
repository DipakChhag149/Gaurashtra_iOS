//
//  TVC1.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 27/12/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit
import AlamofireImage

class TVC1: UITableViewCell {

    
    @IBOutlet weak var imgView: UIImageView!
    
     @IBOutlet weak var collectionView1: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       self.registerNib()
    }
    
    private func registerNib() -> Void
    {
        let nibCards = UINib(nibName: CVC1.identifier(), bundle: nil)
        self.collectionView1.register(nibCards, forCellWithReuseIdentifier: CVC1.identifier())
    }
    
    func configureCellForbackgroundImage(withDictData dictData : Dictionary<String,Any> , indxPath : IndexPath)
    {
        
        let imgUrl = String.getString(dictData["image"])
        
        //print(imgUrl)
        
        guard let urlBrand = URL.init(string: imgUrl) else { return }
        self.imgView.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension TVC1
{
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        collectionView1.delegate = dataSourceDelegate
        collectionView1.dataSource = dataSourceDelegate
        collectionView1.tag = row
        //   collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        collectionView1.reloadData()
    }
    
}
