//
//  MyReviewListTVC.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 30/01/20.
//  Copyright © 2020 Gaurashtra. All rights reserved.
//

import UIKit

class MyReviewListTVC: UITableViewCell {

    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lblOrdered: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    
  //  @IBOutlet weak var lblPaymentMode: UILabel!
    @IBOutlet weak var lblDelivered: UILabel!
 //   @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var img1: UIImageView!
    
    @IBOutlet weak var img2: UIImageView!
    
    @IBOutlet weak var img3: UIImageView!
    
    @IBOutlet weak var img5: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    
    
    @IBOutlet weak var lblReview: UILabel!
    
    private var tapOnEdit : TapOnEdit = { tapOnEdit in }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
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

        // Configure the view for the selected state
    }
    
    
    func configureCell(withDictData dictData : Dictionary<String,Any> , forIndxPath indxPath : IndexPath,btnEdit : @escaping TapOnEdit )
     {
        //print(dictData)
         tapOnEdit = btnEdit
//         let symbol             = String.getString( CurrencyDataModel.getCurrencySavedDetails().symbol)
//         let value              = CurrencyDataModel.getCurrencySavedDetails().value
//         let currecyDoubleValue = Double.getDouble(value)
        self.lblDelivered.text = String.getString(dictData["orderDate"])
         let orderId = String.getString(dictData["orderId"])
         
         self.lblOrdered.text = "Order No. " + orderId
         
         self.lblName.text = String.getString(dictData["productName"])
         
//         self.lblPaymentMode.text = String.getString(dictData["paymentMethod"])
         
        // let product_price = String.getString(dictData["productPrice"])
         
//          let product_priceDbl = Double.getDouble(product_price)*currecyDoubleValue
//
//          let priceFloat    = Double(round(100*product_priceDbl)/100)
//
//         self.lblPrice.text = "\(symbol)\(priceFloat)"
         
        
        self.lblReview.text = String.getString(dictData["reviewText"])
         
         let imgURL = String.getString(dictData["productImage"])
               
               //        let str = "Swift 3.0 is the best version of Swift to learn, so if you're starting fresh you should definitely learn Swift 3.0."
         let replacedURL = imgURL.replacingOccurrences(of: ".jpg", with: "-300x300.jpg")
       //https://www.gaurashtra.com/image/cache/catalog/cow-products/shampoo/Gaurashtra-Panchgavya-Reetha-Hair-Shampoo-300x300.jpg
         let imageUrl = "https://www.gaurashtra.com/image/cache/" + String.getString(replacedURL)
         guard let urlBrand = URL.init(string: imageUrl) else { return }
         self.imgView.af_setImage(withURL: urlBrand, placeholderImage: #imageLiteral(resourceName: "placeholderImg"))
        
                let rating = String.getString(dictData["reviewRating"])
        
                let productRating = Double.getDouble(rating)
        
        //print(productRating)
        
        
                if productRating >= 1.0 && productRating < 2.0
                {
                    if productRating == 1.0
                    {
                        img1.image = #imageLiteral(resourceName: "star")
                        img2.image = #imageLiteral(resourceName: "starLess")
                        img3.image = #imageLiteral(resourceName: "starLess")
                        img4.image = #imageLiteral(resourceName: "starLess")
                        img5.image = #imageLiteral(resourceName: "starLess")
        
        
                    }else{
        
                        img1.image = #imageLiteral(resourceName: "star")
                        img2.image = #imageLiteral(resourceName: "halfStar")
                        img3.image = #imageLiteral(resourceName: "starLess")
                        img4.image = #imageLiteral(resourceName: "starLess")
                        img5.image = #imageLiteral(resourceName: "starLess")
        
                    }
        
        
                }else if productRating >= 2.0 && productRating < 3.0
                {
        
                    if productRating == 2.0
                    {
                        img1.image = #imageLiteral(resourceName: "star")
                        img2.image = #imageLiteral(resourceName: "star")
                        img3.image = #imageLiteral(resourceName: "starLess")
                        img4.image = #imageLiteral(resourceName: "starLess")
                        img5.image = #imageLiteral(resourceName: "starLess")
        
        
                    }else{
                        img1.image = #imageLiteral(resourceName: "star")
                        img2.image = #imageLiteral(resourceName: "star")
                        img3.image = #imageLiteral(resourceName: "halfStar")
                        img4.image = #imageLiteral(resourceName: "starLess")
                        img5.image = #imageLiteral(resourceName: "starLess")
        
                    }
        
                }else if productRating >= 3.0 && productRating < 4.0
                {
                    if productRating == 3.0
                    {
                        img1.image = #imageLiteral(resourceName: "star")
                        img2.image = #imageLiteral(resourceName: "star")
                        img3.image = #imageLiteral(resourceName: "star")
                        img4.image = #imageLiteral(resourceName: "starLess")
                        img5.image = #imageLiteral(resourceName: "starLess")
        
                    }else{
                        img1.image = #imageLiteral(resourceName: "star")
                        img2.image = #imageLiteral(resourceName: "star")
                        img3.image = #imageLiteral(resourceName: "star")
                        img4.image = #imageLiteral(resourceName: "halfStar")
                        img5.image = #imageLiteral(resourceName: "starLess")
        
                    }
        
                }else if productRating >= 4.0 && productRating < 5.0
                {
                    if productRating == 4.0
                    {
                        img1.image = #imageLiteral(resourceName: "star")
                        img2.image = #imageLiteral(resourceName: "star")
                        img3.image = #imageLiteral(resourceName: "star")
                        img4.image = #imageLiteral(resourceName: "star")
                        img5.image = #imageLiteral(resourceName: "starLess")
        
                    }else{
        
                        img1.image = #imageLiteral(resourceName: "star")
                        img2.image = #imageLiteral(resourceName: "star")
                        img3.image = #imageLiteral(resourceName: "star")
                        img4.image = #imageLiteral(resourceName: "star")
                        img5.image = #imageLiteral(resourceName: "halfStar")
                        
                    }
        
                }else if productRating == 5.0
                {
                    img1.image = #imageLiteral(resourceName: "star")
                    img2.image = #imageLiteral(resourceName: "star")
                    img3.image = #imageLiteral(resourceName: "star")
                    img4.image = #imageLiteral(resourceName: "star")
                    img5.image = #imageLiteral(resourceName: "star")
        
                }
        
    
     }
     
    
    
    @IBAction func tapToEdit(_ sender: UIButton) {
        
        tapOnEdit(sender)
        
    }
    

}
