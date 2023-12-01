//
//  BrandListTVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 22/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class BrandListTVC: UITableViewCell {

    
    @IBOutlet weak var headerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configureCellBrandListTVC(withDictData dictData : Dictionary<String,Any>, forIndxPath indxPath : IndexPath,allArrData arrData:[Any])
    {
        
        
    }
        
}
