//
//  SharedClass.swift
//  HealthTotal
//
//  Created by Office on 23/05/16.
//  Copyright © 2016 Collabroo. All rights reserved.
//

import UIKit
import MapKit

class SharedClass: NSObject
{
  static let sharedInstance = SharedClass()
  
  private override init()
  {
  }
//    func fetchDateAndTime()
//    {
//        let date = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//
//        let result = formatter.string(from: date)
//
//        kSharedAppDelegate.headerApiDate = String.getString(result)
//
//
//
//        let strValue = "\(kAlgosoft)\(result)"
//
//        let str = String.getString(strValue)
//
//        let md5Data = kSharedInstance.MD5(string:str)
//
//        let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
//
//
//        kSharedAppDelegate.hearderValue = String.getString(md5Hex)
//
//
//    }
    
//
//    func MD5(string: String) -> Data {
//        let messageData = string.data(using:.utf8)!
//        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
//
//        _ = digestData.withUnsafeMutableBytes {digestBytes in
//            messageData.withUnsafeBytes {messageBytes in
//                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
//            }
//        }
//
//        return digestData
//    }

   
    
    
    func setShadow(withSubView subView:UIView , cornerRedius : Int)
    {
        
        subView.layer.cornerRadius = CGFloat(cornerRedius)
        //        subView.clipsToBounds = true
        subView.layer.shadowOpacity = 0.9
        subView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        subView.layer.shadowRadius = 3.0
        subView.layer.shadowColor = UIColor.lightGray.cgColor
       // subView.layer.shadowColor = UIColor(red: 228.0/255.0, green: 235.0/255.0, blue: 251.0/255.0, alpha: 1.0).cgColor
        subView.backgroundColor = UIColor.white
    }
    
    let gradientLayer = CAGradientLayer()
    
    func setupShimmeringImage(withView view: UIView , backGrroundImgV bgImageView : UIImageView , shimmerImageView : UIImageView) {
        bgImageView.contentMode = .scaleAspectFill
        shimmerImageView.contentMode = .scaleAspectFill
         
           if UIDevice().userInterfaceIdiom == .phone {
               switch UIScreen.main.nativeBounds.height {
               case 1136,1334,2208://iphone 5/5S/SE
              
                   
                   bgImageView.frame = CGRect(x: 0, y: 64, width: Int(kScreenWidth), height: Int(kScreenHeight))
                            
                  shimmerImageView.frame = CGRect(x: 0, y: 64, width: Int(kScreenWidth), height: Int(kScreenHeight))
             
                   
               case 2436,2688,1792://iphone X/XS
                   

                
                   bgImageView.frame = CGRect(x: 0, y: 85, width: Int(kScreenWidth), height: Int(kScreenHeight))
                
                   shimmerImageView.frame = CGRect(x: 0, y: 85, width: Int(kScreenWidth), height: Int(kScreenHeight))
                
               default:
           
                
                break
                                             
                   
               }
               
           }
      
           
           if UIDevice().userInterfaceIdiom == .pad {
                 switch UIScreen.main.nativeBounds.height {
                     
                 //lblOffer lblProductDetail
                 case 2048,2224,1668,2732 : //ipad mini 2/ 5th/6th/Air/Air 2 generation /12.9-inch iPad Pro
                     
                      bgImageView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
                                                             
                      shimmerImageView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height:kScreenHeight)
                     
              
                     
                     
                 default:
                     print("unknown")
                     
                     }
                 }
           
           
           view.addSubview(shimmerImageView)
           view.addSubview(bgImageView)
           
           // let gradientLayer = CAGradientLayer()
           gradientLayer.colors = [
               UIColor.clear.cgColor, UIColor.clear.cgColor,
               UIColor.black.cgColor, UIColor.black.cgColor,
               UIColor.clear.cgColor, UIColor.clear.cgColor
           ]
           
           gradientLayer.locations = [0, 0.2, 0.4, 0.6, 0.8, 1]
           
           let angle = -60 * CGFloat.pi / 180
           let rotationTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
           gradientLayer.transform = rotationTransform
           view.layer.addSublayer(gradientLayer)
           gradientLayer.frame = view.frame
           
           bgImageView.layer.mask = gradientLayer
           
           gradientLayer.transform = CATransform3DConcat(gradientLayer.transform, CATransform3DMakeScale(3, 3, 0))
           
           let animation = CABasicAnimation(keyPath: "transform.translation.x")
           animation.duration = 2
           animation.repeatCount = Float.infinity
           animation.autoreverses = false
           animation.fromValue = -3.0 * view.frame.width
           animation.toValue = 3.0 * view.frame.width
           animation.isRemovedOnCompletion = false
           animation.fillMode = CAMediaTimingFillMode.forwards
           gradientLayer.add(animation, forKey: "shimmerKey")
       }

        func imageOrientation(_ src:UIImage)->UIImage {
               if src.imageOrientation == UIImage.Orientation.up {
                   return src
               }
               var transform: CGAffineTransform = CGAffineTransform.identity
               switch src.imageOrientation {
               case UIImage.Orientation.down, UIImage.Orientation.downMirrored:
                   transform = transform.translatedBy(x: src.size.width, y: src.size.height)
                   transform = transform.rotated(by: CGFloat(Double.pi))
                   break
               case UIImage.Orientation.left, UIImage.Orientation.leftMirrored:
                   transform = transform.translatedBy(x: src.size.width, y: 0)
                   transform = transform.rotated(by: CGFloat(Double.pi))
                   break
               case UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
                   transform = transform.translatedBy(x: 0, y: src.size.height)
                   transform = transform.rotated(by: CGFloat(-Double.pi / 2))
                   break
               case UIImage.Orientation.up, UIImage.Orientation.upMirrored:
                   break
               }
               
               switch src.imageOrientation {
               case UIImage.Orientation.upMirrored, UIImage.Orientation.downMirrored:
                   transform.translatedBy(x: src.size.width, y: 0)
                   transform.scaledBy(x: -1, y: 1)
                   break
               case UIImage.Orientation.leftMirrored, UIImage.Orientation.rightMirrored:
                   transform.translatedBy(x: src.size.height, y: 0)
                   transform.scaledBy(x: -1, y: 1)
               case UIImage.Orientation.up, UIImage.Orientation.down, UIImage.Orientation.left, UIImage.Orientation.right:
                   break
               }
               
               let ctx:CGContext = CGContext(data: nil, width: Int(src.size.width), height: Int(src.size.height), bitsPerComponent: (src.cgImage)!.bitsPerComponent, bytesPerRow: 0, space: (src.cgImage)!.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
               
               ctx.concatenate(transform)
               
               switch src.imageOrientation {
               case UIImage.Orientation.left, UIImage.Orientation.leftMirrored, UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
                   ctx.draw(src.cgImage!, in: CGRect(x: 0, y: 0, width: src.size.height, height: src.size.width))
                   break
               default:
                   ctx.draw(src.cgImage!, in: CGRect(x: 0, y: 0, width: src.size.width, height: src.size.height))
                   break
               }
               
               let cgimg:CGImage = ctx.makeImage()!
               let img:UIImage = UIImage(cgImage: cgimg)
               
               return img
           }
 
    
  func showOkAlertViewController(withTitle title: String, withMessage message: String, fromViewController viewController: UIViewController)
  {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let okAction =  (UIAlertAction(title: kOk, style: .cancel, handler: nil))
    alert.addAction(okAction)
    viewController.present(alert, animated: true, completion: nil)
  }
  
  func getArray(_ array: Any?) -> [Any]
  {
    guard let arr = array as? [Any] else
    {
      return []
    }
    return arr
  }
  
  func getStringArray(_ array: Any?) -> [String]
  {
    guard let arr = array as? [String] else
    {
      return []
    }
    return arr
  }
  
  func getArray(withDictionary array: Any?) -> [Dictionary<String, Any>]
  {
    guard let arr = array as? [Dictionary<String, Any>] else
    {
      return []
    }
    return arr
  }
  
  func getDictionary(_ dictData: Any?) -> Dictionary<String, Any>
  {
    guard let dict = dictData as? Dictionary<String, Any> else
    {
      guard let arr = dictData as? [Any] else
      {
        return ["":""]
      }
      return getDictionary(arr.count > 0 ? arr[0] : ["":""])
    }
    return dict
  }
  
  func convertJSONToString(fromDict dict: Dictionary<String, Any>) -> String
  {
    do
    {
      let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
      return String.init(data: jsonData, encoding: .utf8) ?? ""
    }
    catch let error
    {
      print(error)
    }
    return ""
  }
  
  func convertStringToJSON(fromString strJSON: String) -> Dictionary<String, Any>
  {
    guard let data = strJSON.data(using: .utf8) else { return ["":""] }
    
    do
    {
      let dict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
      return getDictionary(dict)
    }
    catch let error
    {
      print(error)
    }
    return ["":""]
  }
    

}
