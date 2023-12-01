//
//  ThankyouVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 28/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit

class ThankyouVC: GaurashtraBaseVC {

    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var lblTxt: UILabel!
    
    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    
    @IBOutlet weak var lblOrderId: UILabel!
    
    var orderId : String = ""
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDevice()
        self.lblTxt.text = "Awesome! \nYour order has been placed"
        
        self.lblOrderId.text = "Order ID : \(orderId)"
    }
    
    @IBAction func tapToTrack(_ sender: UIButton) {
        
        self.orderDetail(withOrderId: orderId)
    }
    
    func orderDetail(withOrderId orderId : String)
    {
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextVC = sb.instantiateViewController(withIdentifier: OrderDetailsViewController.storyboardId()) as! OrderDetailsViewController
        
        nextVC.idetify = 1
        nextVC.orderId = orderId
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    
    @IBAction func tapToContinue(_ sender: UIButton) {
        
        kSharedAppDelegate.showSideMenu()
        
    }
    func getDevice()
       {
           if UIDevice().userInterfaceIdiom == .phone {
               switch UIScreen.main.nativeBounds.height {
               case 1136://iphone 5/5S/SE
                   
                   self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 12)
                   
                   self.headerViewConstraintH.constant = 64
                   
               case 1334://iphone 6/6S/7/8
                   self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 15)
                   self.headerViewConstraintH.constant = 64
               case 2208://iphone 6+/6S+/7+/8+
                   
                   self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
                   self.headerViewConstraintH.constant = 64
               case 2436://iphone X/XS
                   
                   self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
                   self.headerViewConstraintH.constant = 84
                   //print("iphone XS")
                   
               case 2688,2778://iphone XS Max
                   
                   //print("iphone XS Max")
                   self.headerViewConstraintH.constant = 84
                   self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
                   
               case 1792://iphone XR
                   self.headerViewConstraintH.constant = 84
                   self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
               default:
                   self.lblHeader.font = UIFont(name: "Poppins-Medium", size: 16)
                   self.headerViewConstraintH.constant = 84
               }
               
           }
           
       }
}
