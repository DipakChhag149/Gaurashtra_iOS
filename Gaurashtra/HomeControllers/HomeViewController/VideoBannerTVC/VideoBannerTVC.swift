//
//  VideoBannerTVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 28/12/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//https://www.youtube.com/watch?v=NJpwx9i042E

import UIKit
import AVKit
import AVFoundation
import WebKit

typealias TapOnSubscribe = (_ tapOnSubscribe : UIButton) -> ()



class VideoBannerTVC: UITableViewCell {

     private var tapOnSubscribe : TapOnSubscribe = { tapOnSubscribe in }
    
    @IBOutlet weak var webKitView: WKWebView!
    
   
   // @IBOutlet weak var playerView: YouTubePlayerView!
    
    
    @IBOutlet weak var btnSubscribe: UIButton!
    @IBOutlet weak var lblDecs: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCellVideoBanner(withBannerData dictData : Dictionary<String,Any> , andIndxPath indxPath : IndexPath , btnSubScribe : @escaping TapOnSubscribe )
    {
        
        tapOnSubscribe = btnSubScribe
       
        let videoLink = String.getString(dictData["videoUrl"])
        //print(videoLink)
        
        guard let youtubeURL = URL(string: "\(videoLink)") else {
        return
        }
        //self.webKitView.load(URLRequest(url: youtubeURL))
        
        self.lblTitle.text = String.getString(dictData["videoTitle"])
        self.lblDecs.text = String.getString(dictData["videoDescription"])
        
        
        //        let imageUrl = String.getString(dictData["bannerImage"])
        //
        //        guard let urlBrand = URL.init(string: imageUrl) else { return }
        //        self.imgViewVideoBanner.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
    }
    
    @IBAction func tapToSubscribed(_ sender: UIButton) {
        
        tapOnSubscribe(sender)
        
    }
    
  
}
