//
//  UIButtonExtended.swift
//  OneClickWash
//
//  Created by RUCHIN SINGHAL on 15/09/16.
//  Copyright © 2016 Appslure. All rights reserved.
//

import UIKit

class UIButtonExtended: UIButtonSublayerBorderWidthAndColor
{
  override func layoutSubviews()
  {
    super.layoutSubviews()
    if makeCircle
    {
      layer.cornerRadius = self.bounds.size.width / 2
      clipsToBounds = true
    }
    
    if leftSublayer
    {
      setLeftBorderWithCALayer()
    }
    
    if rightSublayer
    {
      setRightBorderWithCALayer()
    }
    
    if bottomSublayer
    {
      setBottomBorderWithCALayer()
    }
    
    if topSublayer
    {
      setTopBorderWithCALayer()
    }
  }
  
  fileprivate func setLeftBorderWithCALayer()
  {
    let border = CALayer()
    border.backgroundColor = self.isSelected ? sublayerBorderColorSelected?.cgColor : sublayerBorderColorNormal?.cgColor
    
    border.frame = CGRect(x: 0, y: 0, width: sublayerBorderWidth, height: self.frame.size.height)
    self.layer.addSublayer(border)
  }
  
  fileprivate func setRightBorderWithCALayer()
  {
    let border = CALayer()
    border.backgroundColor = self.isSelected ? sublayerBorderColorSelected?.cgColor : sublayerBorderColorNormal?.cgColor
    
    border.frame = CGRect(x: self.frame.size.width - sublayerBorderWidth, y: 0, width: sublayerBorderWidth, height: self.frame.size.height)
    self.layer.addSublayer(border)
  }
  
  fileprivate func setTopBorderWithCALayer()
  {
    let border = CALayer()
    border.backgroundColor = self.isSelected ? sublayerBorderColorSelected?.cgColor : sublayerBorderColorNormal?.cgColor
    
    border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: sublayerBorderWidth)
    self.layer.addSublayer(border)
  }
  
  fileprivate func setBottomBorderWithCALayer()
  {
    let border = CALayer()
    border.backgroundColor = self.isSelected ? sublayerBorderColorSelected?.cgColor : sublayerBorderColorNormal?.cgColor
    
    border.frame = CGRect(x: 0, y: self.frame.size.height - sublayerBorderWidth, width: self.frame.size.width, height: sublayerBorderWidth)
    self.layer.addSublayer(border)
  }
}
