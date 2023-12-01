//
//  OrderTrankingVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 15/06/20.
//  Copyright © 2020 Gaurashtra. All rights reserved.
//

import UIKit
import WebKit


class OrderTrankingVC: GaurashtraBaseVC,WKUIDelegate,WKNavigationDelegate {
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    @IBOutlet weak var containerView: UIView!
    var trackingUrl : String = ""
    let Activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
    @IBOutlet weak var wkView: WKWebView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addWebViewPage()
    }
     func addWebViewPage()
       {
            //let link = "https://gaurashtra.shiprocket.co/tracking/1904127305223"
           ////print(link)
           guard let url = URL(string:trackingUrl ) else { return }
           wkView.translatesAutoresizingMaskIntoConstraints = false
           
           wkView.isUserInteractionEnabled = true
           wkView.navigationDelegate = self
           //self.containerView.addSubview(self.webView)
           self.containerView.addSubview(self.Activity)
           let request = URLRequest(url: url)
           wkView.load(request)
           
           // add activity
           self.Activity.color = UIColor(red: 238.0/255.0, green: 203.0/255.0, blue: 84.0/255.0, alpha: 1.0)
           self.Activity.center = self.view.center
           self.Activity.startAnimating()
           self.wkView.navigationDelegate = self
           self.Activity.hidesWhenStopped = true
       }
       
       func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
           self.Activity.stopAnimating()
       }
       
       func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
           self.Activity.stopAnimating()
       }

    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
