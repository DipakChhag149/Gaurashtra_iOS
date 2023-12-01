//
//  BestOfferTVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 28/12/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class BestOfferTVC: UITableViewCell {

     fileprivate var tapOnViewMore:TapOnViewMore = {tapOnViewMore in}
    
    @IBOutlet weak var btnViewMore: UIButton!
    
    @IBOutlet weak var bestOfferCV: UICollectionView!
    
    @IBOutlet weak var imgViewBackGround: UIImageView!
    
    @IBOutlet weak var lblDealRemainingTime: UILabel!
    @IBOutlet weak var lblArt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.registerNib()
        self.btnViewMore.tag = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func registerNib() -> Void
    {
        let nibCards = UINib(nibName: BestOfferCVC.identifier(), bundle: nil)
        self.bestOfferCV.register(nibCards, forCellWithReuseIdentifier: BestOfferCVC.identifier())
    }
    
    func configureCellBestOffer(withDictData dictData : Dictionary<String,Any>,arrDataCount arrCount : [Any], forIndxPath indxPath : IndexPath, buttonViewMore: @escaping TapOnViewMore)
    {
        tapOnViewMore = buttonViewMore
        
        
        let background = kSharedInstance.getDictionary(dictData["background"])
        
        self.lblArt.text = String.getString(background["alt"])
        
        let imageURL = String.getString(background["image"])
        
        guard let urlBrand = URL.init(string: imageURL) else { return }
        self.imgViewBackGround.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
        
        let dealStartTime = Int.getInt(String.getString(dictData["dealStartTime"]))
        
        let dealEndTime = Int.getInt(String.getString(dictData["dealEndTime"]))
        
        let remainingTime = (dealEndTime - dealStartTime)*3600
        let remTime = transToHourMinSec(time: Float(remainingTime))
        self.lblDealRemainingTime.text = "\(remTime) Remaining"
        
    }
    
    
    func transToHourMinSec(time: Float) -> String
    {
        let allTime: Int = Int(time)
        var hours = 0
        var minutes = 0
        var seconds = 0
        var hoursText = ""
        var minutesText = ""
        var secondsText = ""
        
        hours = allTime / 3600
        hoursText = hours > 9 ? "\(hours)" : "0\(hours)"
        
        minutes = allTime % 3600 / 60
        minutesText = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        seconds = allTime % 3600 % 60
        secondsText = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        
        return "\(hoursText) h:\(minutesText)m:\(secondsText) s"
    }
    
//    dealDate = "2021-06-23";
//    dealEndTime = 24;
//    dealStartTime = 1;
    @IBAction func tapToViewMore(_ sender: UIButton) {
        tapOnViewMore(sender)
    }
    
    func getDevice()
    {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136://iphone 5/5S/SE
                
                self.btnViewMore.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 11)
                self.lblArt.font = UIFont(name: "Poppins-Medium", size: 15)
                
                
            case 1334://iphone 6/6S/7/8
                self.btnViewMore.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 13)
                
                self.lblArt.font = UIFont(name: "Poppins-Medium", size: 17)
                
                
            case 2208://iphone 6+/6S+/7+/8+
                
                self.btnViewMore.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 13)
                
                self.lblArt.font = UIFont(name: "Poppins-Medium", size: 19)
                
            case 2436://iphone X/XS
                
                self.btnViewMore.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 13)
                
                self.lblArt.font = UIFont(name: "Poppins-Medium", size: 20)
                
                print("iphone XS")
                
            case 2688://iphone XS Max
                
                print("iphone XS Max")
                self.lblArt.font = UIFont(name: "Poppins-Medium", size: 22)
                
                self.btnViewMore.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 13)
            case 1792://iphone XR
                
                print("iphone XR")
                
                
                self.lblArt.font = UIFont(name: "Poppins-Medium", size: 22)
                
                self.btnViewMore.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 13)
                
                
            default:
                print("unknown")
                
                
            }
            
        }
        
    }
   
}
extension BestOfferTVC
{
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        bestOfferCV.delegate = dataSourceDelegate
        bestOfferCV.dataSource = dataSourceDelegate
        bestOfferCV.tag = 3
        //   collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        bestOfferCV.reloadData()
    }
    
}
