//
//  ProductDetailsViewController.swift
//  Gaurashtra
//
//  Created by Vivek Verma on 22/11/18.
//  Copyright © 2018 Gaurashtra. All rights reserved.
//

import UIKit

class ProductDetailsViewController: GaurashtraBaseVC {

    
    @IBOutlet weak var orderTimeView: UIView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var productCollectionImg: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         kSharedInstance.setShadow(withSubView: orderTimeView, cornerRedius: 0)
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    

}
