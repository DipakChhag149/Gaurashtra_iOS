//
//  MyReviewVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 30/01/20.
//  Copyright © 2020 Gaurashtra. All rights reserved.
//

import UIKit

class MyReviewVC: GaurashtraBaseVC {

   
    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btnReviewed: UIButton!
    
    @IBOutlet weak var lblMyReviews: UILabel!
    @IBOutlet weak var btnMyReviewed: UIButton!
    
    @IBOutlet weak var lblToBeReviewed: UILabel!
    fileprivate var currentView = UIViewController()
    fileprivate var myReviewListVC : MyReviewListVC!
    fileprivate var toBeReviewedVC : ToBeReviewedVC!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getDevice()
        self.configureView()
    }
    
    fileprivate func configureView()
       {
           
           let sb = UIStoryboard(name: kHome, bundle: nil)
           myReviewListVC = sb.instantiateViewController(withIdentifier: MyReviewListVC.getStotyboardId()) as? MyReviewListVC
           toBeReviewedVC = sb.instantiateViewController(withIdentifier: ToBeReviewedVC.getStotyboardId()) as? ToBeReviewedVC
           
        
           
           
           
           btnReviewed.isSelected = true
           btnMyReviewed.isSelected = false
         
           
           if btnReviewed.isSelected
           {
               lblToBeReviewed.backgroundColor = UIColor(red: 41.0/255.0, green: 54.0/255.0, blue: 102.0/255.0, alpha: 1.0)
               lblMyReviews.backgroundColor = UIColor.clear
               
               
           }
           addChildViewC(toBeReviewedVC)
           currentView = toBeReviewedVC
           
       }
       
    
     fileprivate func addChildViewC(_ childViewC: UIViewController)
     {
         self.addChild(childViewC)
         childViewC.view.frame = containerView.bounds
         self.containerView.addSubview(childViewC.view)
     }
     
     fileprivate func setSelectedViewCAsChildView(_ selectedViewC: UIViewController)
     {
         if currentView != selectedViewC
         {
             self.view.isUserInteractionEnabled = false
             addChildViewC(selectedViewC)
             moveToNewController(selectedViewC)
         }
     }
     fileprivate func moveToNewController(_ controller: UIViewController)
     {
         currentView.willMove(toParent: nil)
         self.transition(from: currentView, to: controller, duration: 0.6, options: .curveLinear, animations: nil)
         { (finished) in
             self.currentView.removeFromParent()
             controller.didMove(toParent: self)
             self.currentView = controller
             self.view.isUserInteractionEnabled = true
         }
     }
     
     fileprivate func setButtonSelected(_ sender: UIButton)
     {
         for button in [btnReviewed, btnMyReviewed]
         {
             if button == sender
             {
                 sender.isSelected = true
                 
             }
             else
             {
                 button?.isSelected = false
             }
         }
         
     }
    
    
    

    @IBAction func backAction(_ sender: UIBarButtonItem) {
    self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func tapToReviewed(_ sender: UIButton) {
        
        if !sender.isSelected
         {
            
             btnReviewed.isSelected = true
             btnMyReviewed.isSelected = false
                     
             
             lblToBeReviewed.backgroundColor = UIColor(red: 41.0/255.0, green: 54.0/255.0, blue: 102.0/255.0, alpha: 1.0)
             lblMyReviews.backgroundColor = UIColor.clear
         
        
             setButtonSelected(sender)
             setSelectedViewCAsChildView(toBeReviewedVC)
         }
        
        
        
    }
    
    @IBAction func tapToMyReviews(_ sender: UIButton) {
        
        
        if !sender.isSelected
        {
           
            btnMyReviewed.isSelected = true
            btnReviewed.isSelected = false
                    
            
            lblToBeReviewed.backgroundColor = UIColor.clear
            lblMyReviews.backgroundColor = UIColor(red: 41.0/255.0, green: 54.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        
       
            setButtonSelected(sender)
            setSelectedViewCAsChildView(myReviewListVC)
        }
        
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
