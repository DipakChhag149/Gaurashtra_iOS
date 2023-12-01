//
//  NoificationTVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 09/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit

typealias TapOnIndxPath = (_ tapOnIndxPath : UIButton) -> ()

class NotificationTVC: UITableViewCell {

    fileprivate var tapOnIndxPath:TapOnIndxPath = {tapOnIndxPath in}
    
    
    @IBOutlet weak var btnIndexPath: UIButton!
    
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var lblDecs: UILabel!
    
    
    
    @IBOutlet weak var lblOffer: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var subView2: UIView!
    
    var strData : String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        kSharedInstance.setShadow(withSubView: subView, cornerRedius: 0)
        
        subView.layer.cornerRadius = 4
        subView.clipsToBounds = false
        
        kSharedInstance.setShadow(withSubView: subView2, cornerRedius: 0)
        subView2.layer.cornerRadius = 4
        subView2.clipsToBounds = false
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(withDictData dictData : Dictionary<String,Any> , forIndxPath indxPath : IndexPath,btnIndexPath : @escaping TapOnIndxPath )
    {
        //category_id
       // self.strData = String.getString(dictData["name"])
        
       // self.lblTitle.text =  String.getString(dictData["category_id"])
        
      //  self.lblDecs.text = arrData[indxPath.row]
//
//        if Int.getInt(dictData["selecteIndex"]) == indxPath.row {
//
//            switch Int.getInt(dictData["selectetag"]){
//
//            case 1:
//
//                print(Int.getInt(dictData["selecteIndex"]))
//                print(indxPath.row)
//                print(dictData)
//
//                self.lblDecs.text = String.getString(dictData["name"])
//
//
//            default:
//                break
//
//            }
//
//
//
//
//        }
        
       tapOnIndxPath =  btnIndexPath
    }
    
    
    @IBAction func tapToIndexBtn(_ sender: UIButton) {
        tapOnIndxPath(sender)
        
    }
    
    
}
