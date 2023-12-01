//
//  UITextFieldExtended.swift
//  OneClickWash
//
//  Created by RUCHIN SINGHAL on 19/10/16.
//  Copyright © 2016 Appslure. All rights reserved.
//

import UIKit

class UITextFieldExtended: UITextFieldBorderWidthAndColor
{
  override func layoutSubviews()
  {
    super.layoutSubviews()
    if bottomSublayer
    {
      setBottomBorderWithCALayer()
    }
  }
  
  fileprivate func setBottomBorderWithCALayer()
  {
    let border = CALayer()
    border.backgroundColor = sublayerBorderColor?.cgColor
    
    border.frame = CGRect(x: 0, y: self.frame.size.height - sublayerBorderWidth, width: self.frame.size.width, height: sublayerBorderWidth)
    self.layer.addSublayer(border)
  }
  
  @IBInspectable var cornerRadius:CGFloat = 0.0 {
    didSet{
      self.layer.cornerRadius = cornerRadius
    }
  }
  
  @IBInspectable var rightImage:UIImage?{
    didSet{
      rightImageview()
      
      
    }
  }
  
  @IBInspectable var rightPadding:CGFloat = 0 {
    didSet{
      rightImageview()
      
    }
  }
  
  
  var isClicked = Bool()
  
  func rightImageview(){
    if let image = rightImage {
      rightViewMode = .always
      let imageView = UIImageView(frame: CGRect(x: rightPadding, y: 0, width: 20, height: 20))
      imageView.image = image
      imageView.tintColor = tintColor
      imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clearButtonPressed)))
      imageView.isUserInteractionEnabled = true
      var width = rightPadding + 20
      isClicked = true
        if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
        
        width = width + 5
        
      }
      
      let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
      view.addSubview(imageView)
      rightView = view
    }else{
      
      rightViewMode = .never
    }
  }
  
    @objc func clearButtonPressed(){
    
    if isClicked {
      isSecureTextEntry = false
      isClicked = false
    }else{
      isSecureTextEntry = true
      isClicked = true
    }
  }
  
  
}


