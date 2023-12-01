//
//  UIButtonGradiant.swift
//  Abwab
//
//  Created by ABC on 21/03/17.
//  Copyright © 2017 ABC. All rights reserved.
//

import UIKit
@IBDesignable
class UIButtonGradiant: UIButton {
    
    @IBInspectable var firstColor:UIColor = UIColor.clear {
        didSet{
            updateVC()
        }
    }
    @IBInspectable var secondColor:UIColor = UIColor.clear {
        didSet{
            updateVC()
        }
    }
    
//    override class var layerClass:AnyClass {
//        get {
//            return CAGradientLayer.self
//        }
//    }
    
    override func layoutSubviews() {
       // updateVC()
    }
     func updateVC() {
        
        let layer = CAGradientLayer()
        layer.colors = [APP_THEME_UP.cgColor,APP_THEME_DOWN.cgColor]
        layer.frame = self.bounds
        self.layer.insertSublayer(layer, at: 0)
      //  layer.locations [ 0.5 ]
        
    }
}
