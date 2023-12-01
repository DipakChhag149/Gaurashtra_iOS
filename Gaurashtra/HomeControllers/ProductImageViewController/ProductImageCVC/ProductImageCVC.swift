//
//  ProductImageCVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 24/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit
import WebKit

class ProductImageCVC: UICollectionViewCell,WKUIDelegate,WKNavigationDelegate {

    @IBOutlet weak var webKit: WKWebView!
    
       let Activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
  
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(withArrData imgArr : [String], forindxPath indxPath : IndexPath)
    {
        
        let img1 = String.getString(imgArr[indxPath.item])
        
        let replacedURL = img1.replacingOccurrences(of: ".jpg", with: "-1100x1100.jpg")
        
        let imageUrl = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL)
        
        // guard let urlBrand = URL.init(string: imageUrl) else { return }
        // self.imgView.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
        
        
        
        guard let url = URL(string: imageUrl) else { return }
        // webKit = WKWebView(frame: self.view.frame)
        webKit.translatesAutoresizingMaskIntoConstraints = false
        
        
        webKit.isUserInteractionEnabled = true
        webKit.navigationDelegate = self as WKNavigationDelegate
        //        self.containerView.addSubview(self.webView)
        //        self.containerView.addSubview(self.Activity)
        
        self.webKit.addSubview(self.Activity)
        
        let request = URLRequest(url: url)
        webKit.load(request)
        
        // add activity
        self.Activity.color = UIColor(red: 63.0/255.0, green: 76.0/255.0, blue: 117.0/255.0, alpha: 1.0)
        self.Activity.center = self.webKit.center
        self.Activity.startAnimating()
        self.webKit.navigationDelegate = self
        self.Activity.hidesWhenStopped = true
        
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.Activity.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.Activity.stopAnimating()
    }
    

}
