//
//  ProductListCVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 27/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class ProductListCVC: UICollectionViewCell {

    
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var prodNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        kSharedInstance.setShadow(withSubView: subView, cornerRedius: 20)
    }
    func configureCellCatData(withDictData dictData : Dictionary<String,Any>, forindxPath indxPath : IndexPath)
    {
        let replacedWidth = String.getString(dictData["name"]).replacingOccurrences(of: "&amp;", with: "&")
        self.prodNameLbl.text = String.getString(replacedWidth)
        let selected = String.getString(dictData["selected"])
        if selected == "Y"
        {
            self.subView.backgroundColor = UIColor(red: 47.0/255.0, green:  53.0/255.0, blue:  76.0/255.0, alpha: 1.0)
            self.prodNameLbl.textColor   = .white
        } else if selected == "N"
        {
            self.subView.backgroundColor = .white
            self.prodNameLbl.textColor   = .darkText
        }
    }
//    override var isHighlighted: Bool {
//            didSet {
//                 self.subView.backgroundColor = isHighlighted ?UIColor(red: 47.0/255.0, green:  53.0/255.0, blue:  76.0/255.0, alpha: 1.0) :  UIColor.white
//                self.prodNameLbl.textColor = isSelected ?  UIColor.white :  UIColor.darkText
//            }
//        }
//        override var isSelected: Bool {
//            didSet {
//               self.subView.backgroundColor = isSelected ?  UIColor(red: 47.0/255.0, green:  53.0/255.0, blue:  76.0/255.0, alpha: 1.0) :  UIColor.white
//               self.prodNameLbl.textColor = isSelected ?  UIColor.white :  UIColor.darkText
//            }
//        }
    
}
