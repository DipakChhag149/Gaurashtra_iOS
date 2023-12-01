//
//  BrandListViewController.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 22/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class BrandListViewController: GaurashtraBaseVC {

    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    @IBOutlet weak var lblHeader: UILabel!
    var imgArr3 =  [#imageLiteral(resourceName: "p1"),#imageLiteral(resourceName: "p2"),#imageLiteral(resourceName: "p3"),#imageLiteral(resourceName: "p4"), #imageLiteral(resourceName: "p1"),#imageLiteral(resourceName: "p2"),#imageLiteral(resourceName: "p3"),#imageLiteral(resourceName: "p4")]
     var dictData :Dictionary<String,Any> = ["":""]
    var darkMode = false
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
        
    }
    
    @IBOutlet weak var brandTbl: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDevice()
    setNeedsStatusBarAppearanceUpdate()
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
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
//#MARK:  UITableViewDelegate,UITableViewDataSource 
extension BrandListViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imgArr3.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = brandTbl.dequeueReusableCell(withIdentifier: BrandListTVC.cellIdentifier(), for: indexPath) as! BrandListTVC
        if indexPath.row % 2 != 0
        {
           
            cell.headerView.backgroundColor =  UIColor(red: 231.0/255.0, green: 240.0/255.0, blue: 241.0/255.0, alpha: 1.0)
            
        }else{
            
            cell.headerView.layer.shadowOpacity = 0.9
            cell.headerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            
            cell.headerView.layer.shadowRadius = 3.0
            cell.headerView.layer.shadowColor = UIColor(red: 168.0/255.0, green: 210.0/255.0, blue: 223.0/255.0, alpha: 1.0).cgColor
            cell.headerView.backgroundColor =  UIColor.white
        }
        
        cell.configureCellBrandListTVC(withDictData: dictData, forIndxPath: indexPath, allArrData: self.imgArr3)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.brandDetailVC()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
   
    
//    func brandDetailVC()
//    {
//        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
//        
//        let nextViewController = sb.instantiateViewController(withIdentifier: BrandDetailVC.storyboardId()) as! BrandDetailVC
//        
//        self.navigationController?.pushViewController(nextViewController, animated: true)
//    }
    
}
