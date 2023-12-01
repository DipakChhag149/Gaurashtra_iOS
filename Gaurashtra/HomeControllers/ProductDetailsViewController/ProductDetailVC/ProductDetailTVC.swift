//
//  ProductDetailTVC.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 30/07/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//

import UIKit

///typealias TapOnAddCart = (_ tapOnAddCart: UIButton) -> ()


class ProductDetailTVC: UITableViewCell {

    fileprivate var tapOnAddCart : TapOnAddCart = {tapOnAddCart in }
    
    @IBOutlet weak var btnAddCart: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(withDictData dictData : Dictionary<String,Any>,  AndAddCart btnCart : @escaping TapOnAddCart)
    {
        tapOnAddCart = btnCart
        
        
        let product_quantity = String.getString(dictData["product_quantity"])
               
        //print(product_quantity)
        
          if Int.getInt(product_quantity) != 0
           {
               self.btnAddCart.setTitle("Add to Cart", for: .normal)
               self.btnAddCart.backgroundColor = UIColor(red: 254.0/255.0, green: 85.0/255.0, blue: 22.0/255.0, alpha: 1.0)
           }else{
               
                self.btnAddCart.setTitle("Notify Me", for: .normal)
                self.btnAddCart.backgroundColor = UIColor(red: 176.0/255.0, green: 223.0/255.0, blue: 229.0/255.0, alpha: 1.0)
           }
    }
    
    
    @IBAction func tapToAddCart(_ sender: UIButton) {
        
        tapOnAddCart(sender)
        
    }
    
}
