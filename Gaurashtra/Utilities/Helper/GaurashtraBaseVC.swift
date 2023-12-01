//
//  ToyBaseVC.swift
//  Toy
//
//  Created by Fluper on 10/08/17.
//  Copyright © 2017 Fluper. All rights reserved.
//

import UIKit


class GaurashtraBaseVC: UIViewController
{
  //MARK:- ----------View Life Cycle Methods----------
  override func viewDidLoad()
  {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool)
  {
    super.viewWillAppear(animated)
  }
  
  override func viewDidAppear(_ animated: Bool)
  {
    super.viewDidAppear(animated)
  }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
  }
  
  //MARK: - AlertView Controller
  func showOkAlert(withMessage message: String)
  {
    let alert = UIAlertController(title: kAppName, message: message, preferredStyle: .alert)
    let okAction =  (UIAlertAction(title: kOk, style: .cancel, handler: nil))
    alert.addAction(okAction)
    present(alert, animated: true, completion: nil)
  }
    
    func showOkAlertWithTitle(withMessage message: String,title:String, andHandler handler:@escaping () -> Void)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction =  UIAlertAction(title:kOk, style: .default)
        { (action) -> Void in
            return handler()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
  
  func showOkAlert(withMessage message: String, andHandler handler:@escaping () -> Void)
  {
    let alert = UIAlertController(title: kAppName, message: message, preferredStyle: .alert)
    let okAction =  UIAlertAction(title:kOk, style: .default)
    { (action) -> Void in
      return handler()
    }
    alert.addAction(okAction)
    present(alert, animated: true, completion: nil)
  }
    
    func showOkAlert2(withMessage message: String)
    {
        let alert = UIAlertController(title: kAppName, message: message, preferredStyle: .alert)
        let okAction =  (UIAlertAction(title: kOk, style: .cancel, handler: nil))
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showOkAlert2(withMessage message: String, andHandler handler:@escaping () -> Void)
    {
        let alert = UIAlertController(title: kAppName, message: message, preferredStyle: .alert)
        let okAction =  UIAlertAction(title:kYes, style: .default)
        { (action) -> Void in
            return handler()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
 //kNO
    
    func showOkAndCancelAlert2(withMessage message: String,withTitle alertTitleStr:String,andCancelTitle cancelTitle:String, andHandler handler:@escaping () -> Void , andCancelHandler cancelHandler:@escaping () -> Void)
    {
        let alert = UIAlertController(title: alertTitleStr, message: message, preferredStyle: .alert)
        let okAction =  UIAlertAction(title: alertTitleStr, style: .default) { (action) -> Void in
            return handler()
        }
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { (action) -> Void in
            
            return cancelHandler()
            
        }
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    func showOkAndCancelAlert3(withMessage message: String, andHandler handler:@escaping () -> Void)
    {
        let alert = UIAlertController(title: kConformation, message: message, preferredStyle: .alert)
        let okAction =  UIAlertAction(title: kYes, style: .default) { (action) -> Void in
            return handler()
        }
        let cancelAction = UIAlertAction(title: kNO, style: .cancel) { (action) -> Void in
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
  func showOkAndCancelAlert(withMessage message: String, andHandler handler:@escaping () -> Void)
  {
    let alert = UIAlertController(title: kAppName, message: message, preferredStyle: .alert)
    let okAction =  UIAlertAction(title: kOk, style: .default) { (action) -> Void in
      return handler()
    }
    let cancelAction = UIAlertAction(title: kCancel, style: .cancel) { (action) -> Void in
    }
    alert.addAction(okAction)
    alert.addAction(cancelAction)
    present(alert, animated: true, completion: nil)
  }
    func showOkAndCancelAlert4(withMessage message: String, andTitle:String,okTitle:String,cancelTitle:String, andHandler handler:@escaping () -> Void,andCancelHandler cancelHandler:@escaping () -> Void)
    {
        let alert = UIAlertController(title: andTitle, message: message, preferredStyle: .alert)
        let okAction =  UIAlertAction(title: okTitle, style: .default) { (action) -> Void in
            return handler()
        }
        let cancelAction = UIAlertAction(title: cancelTitle, style: .default) { (action) -> Void in
            return cancelHandler()
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
  
  func showTextFieldAlert(withMessage message: String, withTextFieldText strText: String, andHandler handler:@escaping (_ strText: String) -> Void)
  {
    let alert = UIAlertController(title: kAppName, message: message, preferredStyle: .alert)
    
    alert.addTextField { (txtFieldOffer: UITextField) in
      txtFieldOffer.placeholder = "Enter Offer"
      txtFieldOffer.text = strText
    }
    let okAction =  UIAlertAction(title: kOk, style: .default) { (action) -> Void in
      guard let textField = alert.textFields?.first else { return }
      return handler(String.getString(textField.text))
    }
    let cancelAction = UIAlertAction(title: kCancel, style: .cancel) { (action) -> Void in
    }
    alert.addAction(okAction)
    alert.addAction(cancelAction)
    present(alert, animated: true, completion: nil)
  }
  
    func notifyMeVC(withProductId prodId : String)
    {
      let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
      
      let nextVC = sb.instantiateViewController(withIdentifier: NotifyMeVC.storyboardId()) as! NotifyMeVC
      
      nextVC.prodId  = prodId
       
       nextVC.modalPresentationStyle = .overCurrentContext
      
      self.present(nextVC, animated: true, completion: nil)
       
    }
    
//    func pushViewCFromSWReveal(withStoryBoardName storyBoardName: String, andIdentifier identifier: String)
//    {
//        let storyB = UIStoryboard(name: storyBoardName, bundle: nil)
//        let vc = storyB.instantiateViewController(withIdentifier: identifier)
//
//        // guard let navigationViewC = kSharedAppDelegate.swrevealObject.frontViewController as? UINavigationController else { return }
//
//
//
//        guard (kSharedAppDelegate.swrevealObject.frontViewController as? UINavigationController) != nil else { return }
//
//
//
//        let navController = UINavigationController(rootViewController: vc)
//        navController.setViewControllers([vc], animated:true)
//        self.revealViewController().rightRevealToggle(animated: true)
//        self.revealViewController().pushFrontViewController(navController, animated: true)
//        self.navigationController?.isNavigationBarHidden = true
//
//
//        //navigationViewC.pushViewController(vc, animated: true)
//    }
//
    
    
    
    
    func showCartCount(withCartCount count : String)
    {
        
        //let saveButton = (UIView.self as? UIBarButtonItem)
        
       // let hub = BadgeHub(view: self.tabBarController!.tabBar)
       
        if let tabItems = tabBarController?.tabBar.items {
            // In this case we want to modify the badge number of the third tab:
            let tabItem = tabItems[4]
            
//            tabItem.badgeColor = .red
            
            if String.getLength(count) != 0
            {

                tabItem.badgeValue = "\(count)"
             
            }
            
        }
    }
    
    func notificationVC()
    {
        
        let sb : UIStoryboard = UIStoryboard(name: kHome, bundle: nil)
        
        let nextViewController = sb.instantiateViewController(withIdentifier: NotificationVC.storyboardId()) as! NotificationVC
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    func showActionSheetLogout(withTitle title: String?, withAlertMessage message: String?, withOptions options: [String], handler:@escaping (_ selectedIndex: Int) -> Void)
      {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.view.tintColor = UIColor(red: 63.0/255.0, green: 76.0/255.0, blue: 117.0/255.0, alpha: 1.0)
       
        for strAction in options
        {
          let anyAction =  UIAlertAction(title: strAction, style: .destructive)
          { (action) -> Void in
            return handler(options.index(of: strAction)!)
          }
       
         
          alert.addAction(anyAction)
        }
        
        let cancelAction = UIAlertAction(title:kCancel, style: .cancel)
        { (action) -> Void in
        }
        
        alert.addAction(cancelAction)
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        }
        present(alert, animated: true, completion: nil)
      }
    
    
    
    
  func showActionSheet(withTitle title: String?, withAlertMessage message: String?, withOptions options: [String], handler:@escaping (_ selectedIndex: Int) -> Void)
  {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    
    for strAction in options
    {
      let anyAction =  UIAlertAction(title: strAction, style: .default)
      { (action) -> Void in
        return handler(options.index(of: strAction)!)
      }
      alert.addAction(anyAction)
    }
    
    let cancelAction = UIAlertAction(title:kCancel, style: .cancel)
    { (action) -> Void in
    }
    
    alert.addAction(cancelAction)
    if let popoverController = alert.popoverPresentationController {
               popoverController.sourceView = self.view
    }
    present(alert, animated: true, completion: nil)
  }
}
extension UIViewController
{
  static func getStotyboardId() -> String
  {
    return String(describing: self)
  }
}

