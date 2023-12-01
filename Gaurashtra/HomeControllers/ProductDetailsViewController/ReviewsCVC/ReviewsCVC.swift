//
//  ReviewsCVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 26/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class ReviewsCVC: UICollectionViewCell {

    
    @IBOutlet weak var lblComments: UILabel!
    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var star1: UIImageView!
    
    @IBOutlet weak var star2: UIImageView!
    
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var star5: UIImageView!
    
 
    
    @IBOutlet weak var lblData: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        kSharedInstance.setShadow(withSubView: subView, cornerRedius: 0)
    }

    
    func configureCell(withDictData reviewDictData :Dictionary<String,Any> , indxpath : IndexPath)
    {
        //print(reviewDictData)
        self.lblComments.text = String.getString(reviewDictData["review_content"])
        
        self.lblName.text = String.getString(reviewDictData["user_name"])
        
        let review_date = String.getString(reviewDictData["review_date"])
        
//        let onlyDate = review_date.components(separatedBy: " ")
//        let date = onlyDate[0]
//        let dateSeperate = date.components(separatedBy: "-")
//        let year = dateSeperate[0]
//        let month = dateSeperate[1]
//        let dateStr = dateSeperate[2]
//        self.lblData.text = "\(dateStr)-\(month)-\(year)"
        
        if String.getLength(review_date) != 0 && String.getString(review_date) != "0000-00-00 00:00:00"
        {
            let dateFormatter = DateFormatter()
             dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
             dateFormatter.locale = Locale.init(identifier: "en_GB")

             let startTime = dateFormatter.date(from: review_date)
           
             dateFormatter.dateFormat = "dd-MM-yyyy"
             let bookingDate = dateFormatter.string(from: startTime!)
             self.lblData.text =  bookingDate
            
//            dateFormatter.dateFormat = "hh:mm a"
//            dateFormatter.amSymbol   = "AM"
//            dateFormatter.pmSymbol   = "PM"
//            let bookingTime   = dateFormatter.string(from: startTime!)
//            self.lblTime.text =  bookingTime
        }
        
        
        
        
        
        
        let rating  = Int.getInt(reviewDictData["rating"])
        
        switch rating {
        case 1:
            
            self.star1.image = #imageLiteral(resourceName: "star")
            self.star2.image = #imageLiteral(resourceName: "starLess")
            self.star3.image = #imageLiteral(resourceName: "starLess")
            self.star4.image = #imageLiteral(resourceName: "starLess")
            self.star5.image = #imageLiteral(resourceName: "starLess")
            
            
            
        case 2:
            
            self.star1.image = #imageLiteral(resourceName: "star")
            self.star2.image = #imageLiteral(resourceName: "star")
            self.star3.image = #imageLiteral(resourceName: "starLess")
            self.star4.image = #imageLiteral(resourceName: "starLess")
            self.star5.image = #imageLiteral(resourceName: "starLess")
            
        case 3:
            self.star1.image = #imageLiteral(resourceName: "star")
            self.star2.image = #imageLiteral(resourceName: "star")
            self.star3.image = #imageLiteral(resourceName: "star")
            self.star4.image = #imageLiteral(resourceName: "starLess")
            self.star5.image = #imageLiteral(resourceName: "starLess")
            
        case 4:
            
            self.star1.image = #imageLiteral(resourceName: "star")
            self.star2.image = #imageLiteral(resourceName: "star")
            self.star3.image = #imageLiteral(resourceName: "star")
            self.star4.image = #imageLiteral(resourceName: "star")
            self.star5.image = #imageLiteral(resourceName: "starLess")
            
        case 5:
            
            self.star1.image = #imageLiteral(resourceName: "star")
            self.star2.image = #imageLiteral(resourceName: "star")
            self.star3.image = #imageLiteral(resourceName: "star")
            self.star4.image = #imageLiteral(resourceName: "star")
            self.star5.image = #imageLiteral(resourceName: "star")
            
        default:
            break
        }
        
        
    }
    
    
    
    
    
}
