//
//  AddressTVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 20/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

typealias TapOnEdit = (_ tapOnEdit:UIButton) -> ()

class AddressTVC: UITableViewCell {

    fileprivate var tapOnEdit :TapOnEdit = {tapOnEdit in}
    @IBOutlet weak var locationImgIcon: UIImageView!
    
    @IBOutlet weak var btnEditAddress: UIButton!
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var lblPhoneNo: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblDefault: UILabel!
    
    @IBOutlet weak var lblAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        btnEditAddress.tag = 1
        subView.layer.cornerRadius = 5
        //        subView.clipsToBounds = true
        subView.layer.shadowOpacity = 0.9
        subView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        subView.layer.shadowRadius = 4.0
        subView.layer.shadowColor = UIColor(red: 168.0/255.0, green: 210.0/255.0, blue: 223.0/255.0, alpha: 1.0).cgColor
        subView.backgroundColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.locationImgIcon.image   = selected ? #imageLiteral(resourceName: "map_pin") : #imageLiteral(resourceName: "address_2")
        self.subView.backgroundColor = selected ? UIColor.lightGray : UIColor.white
        self.lblAddress.textColor = selected ? UIColor.white : UIColor.darkText
        self.lblName.textColor    = selected ? UIColor.white : UIColor.darkText
        self.lblPhoneNo.textColor = selected ? UIColor.white : UIColor.darkText    }

    
    func configureCell(withDictData dictData: Dictionary<String,Any>, forIndxPath indxPath : IndexPath , buttonEdit : @escaping TapOnEdit )
    {
        
        tapOnEdit = buttonEdit
        let firstname = String.getString(dictData["firstname"])
        let lastname = String.getString(dictData["lastname"])
        let address_1 = String.getString(dictData["address_1"])
        let address_2 = String.getString(dictData["address_2"])
        let city      = String.getString(dictData["city"])
        let postcode  = String.getString(dictData["postcode"])
        let phoneNo   = String.getString(dictData["custom_field"])
        
        let address_id = String.getString(dictData["address_id"])
        
        let default_address_id  = String.getString(dictData["default_address_id"])
        
        self.lblPhoneNo.text = phoneNo
        self.lblAddress.text = address_1 + " " + address_2 + " " + city + " " + postcode
        
        
        
        self.lblName.text = firstname + " " + lastname
        
        if String.getString(address_id) == String.getString(default_address_id)
        {
            self.lblDefault.isHidden = false
        }else{
            self.lblDefault.isHidden = true
        }
        
    }
    
    @IBAction func tapToEditAddress(_ sender: UIButton) {
        tapOnEdit(sender)
    }
    
    
}
