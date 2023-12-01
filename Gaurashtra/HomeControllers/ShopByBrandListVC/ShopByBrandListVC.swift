//
//  ShopByBrandListVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 05/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit
import Toast_Swift

class ShopByBrandListVC: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var headerViewConstraintH: NSLayoutConstraint!
    
    @IBOutlet weak var tblShopbyBrand: UITableView!
    
    
    var brandsListArr : [Any] = []
    private var dictParams = [kUserId: ""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDevice()
        self.dictParams[kUserId] = String.getString(LoginDataModel.getLoggedInUserDetails().customer_id)
        self.callBrandsListWebService()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        
        
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
//#MARK:----    -----
extension ShopByBrandListVC : UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brandsListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tblShopbyBrand.dequeueReusableCell(withIdentifier: ShopByBrandListTVC.cellIdentifier(), for: indexPath) as! ShopByBrandListTVC
        
        if indexPath.row % 2 != 0
        {
            
            cell.subView.backgroundColor =  UIColor(red: 231.0/255.0, green: 240.0/255.0, blue: 241.0/255.0, alpha: 1.0)
            
        }else{
            
            cell.subView.layer.shadowOpacity = 0.9
            cell.subView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            cell.subView.layer.shadowRadius = 3.0
            cell.subView.layer.shadowColor = UIColor(red: 168.0/255.0, green: 210.0/255.0, blue: 223.0/255.0, alpha: 1.0).cgColor
            cell.subView.backgroundColor =  UIColor.white
        }
        
        
        cell.configureBrandsCell(withDictData: kSharedInstance.getDictionary(self.brandsListArr[indexPath.row]), forIndxPath: indexPath)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dictData = kSharedInstance.getDictionary(self.brandsListArr[indexPath.row])
        
        
        
        self.categoryDetailVC(withserviceName: kGetBrandProductList, HeaderTitle: String.getString(dictData["brand_name"]), withId: 6, brandId: String.getString(dictData["brand_id"]))
        
        // self.categoryDetailVC(withCatId: String.getString(dictdata["category_id"]))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //#MARK:-----------callLoginWebService---------
    private func callBrandsListWebService()
    {
        
        
        let dictImg:[String : Any] = ["image" : UIImage(),
                                      "imageName" : "uploaded_file"]
        
        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: kGetBrandList, requestMethod: .post, requestImages: [dictImg], withProgressHUD: true, withProgessHUDTitle: "Loading...", requestVideos: [String:  Any](), requestData: dictParams, completionClosure: {[weak self] (response: Any?, error: Error?, errorType: ErrorType, statusCode: Int?) in
            guard let strongSelf = self else { return }
            if errorType == .requestSuccess
            {
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let dictResponse = kSharedInstance.getDictionary(response)
                
                if Int.getInt(dictResponse["success"]) == 1
                {
                    let result = kSharedInstance.getDictionary(dictResponse["result"])
                    strongSelf.brandsListArr = kSharedInstance.getArray(result["shopByBrandData"])
                    strongSelf.tblShopbyBrand.reloadData()
                    
                }else{
                    
              strongSelf.view.makeToast(String.getString(dictResponse[kMessage]), duration: 1.5, position: .center)
                    
                }
                
            }
            else if errorType == .requestFailed
            {
                UIApplication.shared.endIgnoringInteractionEvents()
            }
            else
            {
            }
        })
    }
    
    func categoryDetailVC(withserviceName serviceName : String, HeaderTitle title: String, withId id : Int , brandId : String)
    {
        
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextViewController = sb.instantiateViewController(withIdentifier: CategoryDetailVC.storyboardId()) as! CategoryDetailVC
        
        nextViewController.headerTitle = title
        nextViewController.serviceName = serviceName
        nextViewController.idNo        = id
        nextViewController.brandId     = brandId
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
