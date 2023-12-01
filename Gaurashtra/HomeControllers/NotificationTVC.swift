//
//  NotificationTVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 29/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit

class NotificationTVC: UITableViewCell {

    @IBOutlet weak var lblTime: UILabel!
    
    
    @IBOutlet weak var lblOffer: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var subView1: UIView!
    
    @IBOutlet weak var subview2: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        kSharedInstance.setShadow(withSubView: self.subView1, cornerRedius: 0)
        subView1.layer.cornerRadius = 2
        subView1.clipsToBounds = false
        
       
        kSharedInstance.setShadow(withSubView: self.subview2, cornerRedius: 0)
        subview2.layer.cornerRadius = 2
        subview2.clipsToBounds = false
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureNotCell(withDictData dictData : Dictionary<String,Any> , forIndxPath indxPath : IndexPath)
    {
        
        self.lblTitle.text = String.getString(dictData["notification_title"])
        
         self.lblOffer.text = String.getString(dictData["notification_sub_title"])
        
         let dateAsString = String.getString(dictData["notification_date"])
        
        //print(String.getLength(dateAsString))
        
        if String.getLength(dateAsString) != 0
        {
            let isoDate = dateAsString
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"

            let date = dateFormatter.date(from:isoDate)!
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour ,.minute ,.second], from: date)
            let finalDate = calendar.date(from:components)

            let pastDate = finalDate

            self.lblTime.text = pastDate!.timeAgoDisplay()
        }
        
        
        
    }

}
extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        //print(secondsAgo)
        
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo < minute {
            return "Just Now"
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute) minutes ago"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour) hours ago"
        } else if secondsAgo < week {
            return "\(secondsAgo / day) days ago"
        }
        return "\(secondsAgo / week) weeks ago"
    }
}
