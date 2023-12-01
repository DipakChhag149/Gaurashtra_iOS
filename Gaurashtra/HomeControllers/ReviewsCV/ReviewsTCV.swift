//
//  ReviewsTCV.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 28/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit

class ReviewsTCV: UITableViewCell {
    
    @IBOutlet weak var subView: UIView!
    
    
    @IBOutlet weak var img5: UIImageView!
    
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    @IBOutlet weak var img1: UIImageView!
    
    @IBOutlet weak var img2: UIImageView!
    
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblDecs: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        kSharedInstance.setShadow(withSubView: subView, cornerRedius: 0)
        
        subView.layer.cornerRadius = 4
        subView.clipsToBounds = false
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(withDictData dictData : Dictionary<String,Any> , forIndxPath indxPath : IndexPath)
    {
        self.lblDecs.text = String.getString(dictData["review_content"])
        
        self.lblName.text = String.getString(dictData["user_name"])
        
        let review_date = String.getString(dictData["review_date"])
        
        
        let onlyDate = review_date.components(separatedBy: " ")
        
        let date = onlyDate[0]
        
        let dateSeperate = date.components(separatedBy: "-")
        
        let year = dateSeperate[0]
        
        let month = dateSeperate[1]
        
        let dateStr = dateSeperate[2]
        
        self.lblDate.text = "\(dateStr)-\(month)-\(year)"
        
        let rating  = Int.getInt(dictData["rating"])
        
        switch rating {
        case 1:
            
            self.img1.image = #imageLiteral(resourceName: "star")
            self.img2.image = #imageLiteral(resourceName: "starLess")
            self.img3.image = #imageLiteral(resourceName: "starLess")
            self.img4.image = #imageLiteral(resourceName: "starLess")
            self.img5.image = #imageLiteral(resourceName: "starLess")
            
            
            
        case 2:
            
            self.img1.image = #imageLiteral(resourceName: "star")
            self.img2.image = #imageLiteral(resourceName: "star")
            self.img3.image = #imageLiteral(resourceName: "starLess")
            self.img4.image = #imageLiteral(resourceName: "starLess")
            self.img5.image = #imageLiteral(resourceName: "starLess")
            
        case 3:
            self.img1.image = #imageLiteral(resourceName: "star")
            self.img2.image = #imageLiteral(resourceName: "star")
            self.img3.image = #imageLiteral(resourceName: "star")
            self.img4.image = #imageLiteral(resourceName: "starLess")
            self.img5.image = #imageLiteral(resourceName: "starLess")
            
        case 4:
            
            self.img1.image = #imageLiteral(resourceName: "star")
            self.img2.image = #imageLiteral(resourceName: "star")
            self.img3.image = #imageLiteral(resourceName: "star")
            self.img4.image = #imageLiteral(resourceName: "star")
            self.img5.image = #imageLiteral(resourceName: "starLess")
            
        case 5:
            
            self.img1.image = #imageLiteral(resourceName: "star")
            self.img2.image = #imageLiteral(resourceName: "star")
            self.img3.image = #imageLiteral(resourceName: "star")
            self.img4.image = #imageLiteral(resourceName: "star")
            self.img5.image = #imageLiteral(resourceName: "star")
            
        default:
            break
        }
        
        
    }
    

}
