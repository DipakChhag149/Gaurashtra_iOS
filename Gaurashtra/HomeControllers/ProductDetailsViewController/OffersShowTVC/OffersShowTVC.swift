//
//  OffersShowTVC.swift
//  Gaurashtra
//
//  Created by Algosoft Technologies on 10/18/20.
//  Copyright © 2020 Gaurashtra. All rights reserved.
//

import UIKit

class OffersShowTVC: UITableViewCell {

    
    @IBOutlet weak var lblOfferTitle: UILabel!
    
    @IBOutlet weak var lblDecs: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(withDictData dictData : Dictionary<String,Any>, forIndxPath indxPath : IndexPath)
    {
        self.lblOfferTitle.text = String.getString(dictData["title"])
        self.lblDecs.text       = String.getString(dictData["content"])
        
    }
    
}
