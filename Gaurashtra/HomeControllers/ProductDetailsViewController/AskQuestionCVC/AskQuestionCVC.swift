//
//  AskQuestionCVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 26/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class AskQuestionCVC: UICollectionViewCell {

    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
   
   
  
    
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var ansNameLbl: UILabel!
    @IBOutlet weak var ansLbl: UILabel!
    @IBOutlet weak var quesLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        kSharedInstance.setShadow(withSubView: subView, cornerRedius: 0)
    }

    
    func configureAskQuestionCell(withDictData dictData : Dictionary<String,Any> , forindxPath : IndexPath)
    {
        self.nameLbl.text = String.getString(dictData["questioner_name"])
        self.quesLbl.text = String.getString(dictData["questioner_content"])
        
        self.ansLbl.text = String.getString(dictData["replayer_content"])
        
        let questioner_date = String.getString(dictData["questioner_date"])
        
        let onlyDate = questioner_date.components(separatedBy: " ")
        
        let date = onlyDate[0]
        
        let dateSeperate = date.components(separatedBy: "-")
        
        let year = dateSeperate[0]
        
        let month = dateSeperate[1]
        
        let dateStr = dateSeperate[2]
        
        self.dateLbl.text = "\(dateStr)-\(month)-\(year)"
        
        let replayer_name  = String.getString(dictData["replayer_name"])
        
        let replayer_date = String.getString(dictData["replayer_date"])
        
        let onlyReplyDate = replayer_date.components(separatedBy: " ")
        
        let replydate = onlyReplyDate[0]
        
        let replyDateSeperate = replydate.components(separatedBy: "-")
        
        let year1 = replyDateSeperate[0]
        
        let month1 = replyDateSeperate[1]
        
        let dateStr1 = replyDateSeperate[2]
        
        
        self.ansNameLbl.text = "\(replayer_name), \(dateStr1)/\(month1)/\(year1)"
        
    }
   
}
