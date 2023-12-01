//
//  UIViewControllerExtension.swift
//  Abwab
//
//  Created by ABC on 22/03/17.
//  Copyright © 2017 ABC. All rights reserved.
//

import UIKit

extension UIViewController
{
  func presentViewC(withIdentifier identifier: String, fromStoryBoard storyboard: String, withAnimation animated: Bool)
  {
    let sb = UIStoryboard.init(name: storyboard, bundle: nil)
    let viewC = sb.instantiateViewController(withIdentifier: identifier)
    present(viewC, animated: animated, completion: nil)
  }
  
  func dismissViewC(withAnimation animated: Bool, _ completion: (() -> ())?)
  {
    dismiss(animated: animated, completion: completion)
  }
  
  static func storyboardId() -> String
  {
    return String.init(describing: self)
  }
  func callByStoryBoardNameWithViewC(_ storyboardName:String, viewCIdentifier: String)
  {
    let storyBoard = UIStoryboard(name: storyboardName, bundle: nil)
    let viewC = storyBoard.instantiateViewController(withIdentifier: viewCIdentifier)
      self.navigationController?.present(viewC, animated: true, completion: nil)
  }
}
