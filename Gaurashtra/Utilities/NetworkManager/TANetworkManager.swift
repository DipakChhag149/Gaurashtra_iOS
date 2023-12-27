//
//  TANetworkManager.swift
//  TANetworkingSwift
//
//  Created by Girijesh Kumar on 09/01/16.
//  Copyright © 2016 Girijesh Kumar. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

public enum kHTTPMethod: String
{
  case GET, POST, PUT, PATCH, DELETE
}

public enum ErrorType: Error
{
  case noNetwork, requestSuccess, requestFailed, requestCancelled
}

public class TANetworkManager
{
  // MARK: - Properties
  
  /**
   A shared instance of `Manager`, used by top-level Alamofire request methods, and suitable for use directly
   for any ad hoc requests.
   */
  internal static let sharedInstance: TANetworkManager =
    {
      return TANetworkManager()
  }()
  
  
  //MARK:- Public Method
  /**
   *  Initiates HTTPS or HTTP request over |kHTTPMethod| method and returns call back in success and failure block.
   *
   *  @param serviceName  name of the service
   *  @param method       method type like Get and Post
   *  @param postData     parameters
   *  @param responeBlock call back in block
   */ // [String : AnyObject]? = [:] Dictionary<String, Any>
    func requestApi(withServiceName serviceName: String, requestMethod method: kHTTPMethod, requestParameters postData:[String:String] , withProgressHUD showProgress: Bool,withProgressHUDTitle:String, completionClosure:@escaping (_ result: Any?, _ error: Error?, _ errorType: ErrorType, _ statusCode: Int?) -> ()) -> Void
    {
        if NetworkReachabilityManager()?.isReachable == true
        {
            if showProgress {
                showProgressHUD(withTitle: withProgressHUDTitle)
            }
            
            let headers = getHeaderWithAPIName(serviceName: serviceName)
            //,kApiKey:"2349eefbabd85d3c9d06715cc1655caf"
            
            let serviceUrl = getServiceUrl(string: serviceName)
            
            let params  = getPrintableParamsFromJson(postData: postData)
            
            print_debug(items: "Connecting to Host with URL \(kBASEURL)\(serviceName) with parameters: \(params)")
            
            //NSAssert Statements
            assert(method != .GET || method != .POST, "kHTTPMethod should be one of kHTTPMethodGET|kHTTPMethodPOST|kHTTPMethodPOSTMultiPart.");
            
            switch method
            {
            case .GET:
                AF.request(serviceUrl, method: .get, parameters: postData, encoding: URLEncoding.default, headers: headers).responseJSON(completionHandler:
                    { (DataResponse) in
                        SVProgressHUD.dismiss()
                        switch DataResponse.result
                        {
                        case .success(let JSON):
                            print_debug_fake(items: "Success with JSON: \(JSON)")
                            print_debug(items: "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                            let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                            completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                        case .failure(let error):
                            print_debug(items: "json error: \(error.localizedDescription)")
                            if error.localizedDescription == "cancelled"
                            {
                                completionClosure(nil, error, .requestCancelled, Int.getInt(DataResponse.response?.statusCode))
                            }
                            else
                            {
                                completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                            }
                        }
                })
               
            case .POST:
                AF.request(serviceUrl, method: .post, parameters: postData, encoding: JSONEncoding.prettyPrinted, headers: headers).responseJSON(completionHandler:
                    { (DataResponse) in
                        SVProgressHUD.dismiss()
                        switch DataResponse.result
                        {
                        case .success(let JSON):
                            print_debug_fake(items: "Success with JSON: \(JSON)")
                            print_debug(items: "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                            let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                            completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                        case .failure(let error):
                            print_debug(items: "json error: \(error.localizedDescription)")
                            completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                        }
                })
            case .PUT:
                AF.request(serviceUrl, method: .put, parameters: postData, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler:
                    { (DataResponse) in
                        SVProgressHUD.dismiss()
                        switch DataResponse.result
                        {
                        case .success(let JSON):
                            print_debug_fake(items: "Success with JSON: \(JSON)")
                            print_debug(items: "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                            let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                            completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                        case .failure(let error):
                            print_debug(items: "json error: \(error.localizedDescription)")
                            completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                        }
                })
            case .PATCH:
                AF.request(serviceUrl, method: .patch, parameters: postData, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler:
                    { (DataResponse) in
                        SVProgressHUD.dismiss()
                        switch DataResponse.result
                        {
                        case .success(let JSON):
                            print_debug_fake(items: "Success with JSON: \(JSON)")
                            print_debug(items: "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                            let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                            completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                        case .failure(let error):
                            print_debug(items: "json error: \(error.localizedDescription)")
                            completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                        }
                })
            case .DELETE:
                AF.request(serviceUrl, method: .delete, parameters: postData, encoding: URLEncoding.default, headers: headers).responseJSON(completionHandler:
                    { (DataResponse) in
                        SVProgressHUD.dismiss()
                        switch DataResponse.result
                        {
                        case .success(let JSON):
                            print_debug_fake(items: "Success with JSON: \(JSON)")
                            print_debug(items: "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                            let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                            completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                        case .failure(let error):
                            print_debug(items: "json error: \(error.localizedDescription)")
                            completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                        }
                })
            }
        }
        else
        {
            SVProgressHUD.dismiss()
            completionClosure(nil, nil, .noNetwork, nil)
        }
    }
    
    
  
  /**
   *  Upload multiple images and videos via multipart
   *
   *  @param serviceName  name of the service
   *  @param imagesArray  array having images in NSData form
   *  @param videosArray  array having videos file path
   *  @param postData     parameters
   *  @param responeBlock call back in block
   */
    func requestMultiPart(withServiceName serviceName: String, requestMethod method: HTTPMethod, requestImages arrImages: [Dictionary<String, Any>],withProgressHUD showProgress: Bool,withProgessHUDTitle:String, requestVideos arrVideos: Dictionary<String, Any>, requestData postData: Dictionary<String, Any>, completionClosure: @escaping (_ result: Any?, _ error: Error?, _ errorType: ErrorType, _ statusCode: Int?) -> ()) -> Void
    {
        if NetworkReachabilityManager()?.isReachable == true
        {
            if showProgress
            {
                showProgressHUD(withTitle: withProgessHUDTitle)
            }
            let serviceUrl = getServiceUrl(string: serviceName)
            let params  = getPrintableParamsFromJson(postData: postData)
 
            let headers: HTTPHeaders = [
                    kApiKey: "2349eefbabd85d3c9d06715cc1655caf", kApiDate: "2018-11-16",
                    "Content-Type": "application/json"
                ]
  
            print_debug(items: "Connecting to Host with URL \(kBASEURL)\(serviceName) with parameters: \(params)")
    
            AF.upload(multipartFormData: { (multipartFormData: MultipartFormData) in
                do {
                    for (key, value) in postData {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    }
                } catch let error {
                    print_debug(items: error)
                }

                for dictImage in arrImages {
                    let validDict = kSharedInstance.getDictionary(dictImage)
                    if let image = validDict["image"] as? UIImage
                        {//UIImage.jpegData(compressionQuality:)
                        //let imageData = image.jpegData(compressionQuality: 0.75)
                
                    if let imageData = image.jpegData(compressionQuality: 0.5)
                        //   if let imageData: Data = UIImage.jpegData(compressionQuality:image,0.5)
                    {
                        multipartFormData.append(imageData, withName: String.getString(validDict["imageName"]), fileName: String.getString(NSNumber.getNSNumber(message: self.getCurrentTimeStamp()).intValue) + ".jpeg", mimeType: "image/jpeg")
                    }
                }
            }
            }, to: serviceUrl,method: method, headers: headers)
            .responseString(completionHandler: { res in
                print("Json: \(res.debugDescription)")
            })
            .responseJSON(queue: .main, options: .allowFragments) { (res) in
                print("Json: \(res.debugDescription)")
                    
                switch res.result{
                    case .success(let value):
                        print("Json: \(value)")
                        completionClosure(value, res.error, .requestSuccess, Int.getInt(res.response?.statusCode))
                        //completionClosure(nil, #error, .requestFailed, 200)
                    case .failure(let error):
                        SVProgressHUD.dismiss()
                       // completionClosure(nil, error, .requestFailed, 200)
                        completionClosure(nil, error, .requestSuccess, Int.getInt(res.response?.statusCode))
                    }
                }.uploadProgress { (progress) in
                    SVProgressHUD.dismiss()
                    print("Progress: \(progress.fractionCompleted)")
                }
            
           /* AF.upload(multipartFormData:{ (multipartFormData: MultipartFormData) in
                do {
                    for (key, value) in postData {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    }
                } catch let error {
                    print_debug(items: error)
                }

                for dictImage in arrImages {
                    let validDict = kSharedInstance.getDictionary(dictImage)
                    if let image = validDict["image"] as? UIImage
                        {//UIImage.jpegData(compressionQuality:)
                        //let imageData = image.jpegData(compressionQuality: 0.75)
                
                    if let imageData = image.jpegData(compressionQuality: 0.5)
                        //   if let imageData: Data = UIImage.jpegData(compressionQuality:image,0.5)
                    {
                        multipartFormData.append(imageData, withName: String.getString(validDict["imageName"]), fileName: String.getString(NSNumber.getNSNumber(message: self.getCurrentTimeStamp()).intValue) + ".jpeg", mimeType: "image/jpeg")
                    }
                }
            }
        }, to: serviceUrl, method: method, headers: headers, encodingCompletion: { (encodingResult: SessionManager.MultipartFormDataEncodingResult) in
            switch encodingResult
            {
                case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                    upload.responseJSON(completionHandler: { (Response) in
                        SVProgressHUD.dismiss()
                        let response = self.getResponseDataDictionaryFromData(data: Response.data!)
                        completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(Response.response?.statusCode))
                    })
                case .failure(let error):
                    SVProgressHUD.dismiss()
                    completionClosure(nil, error, .requestFailed, 200)
            }
        })*/
    }
    else
    {
      SVProgressHUD.dismiss()
      completionClosure(nil, nil, .noNetwork, nil)
    }
            
  }
  
  func cancelAllRequests(completionHandler: @escaping () -> ())
  {
      AF.session.getTasksWithCompletionHandler { (dataTask: [URLSessionDataTask], uploadTask: [URLSessionUploadTask], downloadTask: [URLSessionDownloadTask]) in
      dataTask.forEach({ (task: URLSessionDataTask) in task.cancel() })
      uploadTask.forEach({ (task: URLSessionUploadTask) in task.cancel() })
      downloadTask.forEach({ (task: URLSessionDownloadTask) in task.cancel() })
      completionHandler()
    }
  }
  
  //
  //
  //  /**
  //   *  Download image and videos
  //   *
  //   *  @param serviceName  name of the service
  //   *  @param photoInfo  destination file name after download in DocumentDirectory
  //   *  @param ProgressClosure call back in block with download
  //   */
  //
  //  internal func requestApiToDownloadImage(serviceName: String,photoInfo: String,progressClosure: (totalBytesRead : Float) -> ()) -> Void {
  //
  //    let serviceUrl = kBASEURL + serviceName
  //
  //    NSLog("Connecting to Host with URL %@%@ jsonPara String: %@", kBASEURL, serviceName);
  //
  //    // Add AES authentication ...........
  //    let headers:[String:String] = getHeaderWithAPIName(serviceName)
  //
  //    let destination: (NSURL, NSHTTPURLResponse) -> (NSURL) = {
  //      (temporaryURL, response) in
  //
  //      let directoryURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
  //      return directoryURL.URLByAppendingPathComponent("\(photoInfo).\(response.suggestedFilename)")
  //    }
  //    // 5
  //    Alamofire.download(.GET, serviceUrl, headers: headers, destination: destination).progress {
  //
  //      (_, totalBytesRead, totalBytesExpectedToRead) in
  //
  //      dispatch_async(dispatch_get_main_queue()) {
  //        // 6
  //        progressClosure(totalBytesRead:Float(totalBytesRead) / Float(totalBytesExpectedToRead))
  //        // 7
  //        if totalBytesRead == totalBytesExpectedToRead {
  //          progressClosure(totalBytesRead: 1.0)
  //        }
  //      }
  //    }
  //  }
  
  //MARK:- Private Method
    private func showProgressHUD(withTitle title:String)
  {
    //SVProgressHUD.show(withStatus: "Please Wait")
     SVProgressHUD.show(withStatus: title)
     SVProgressHUD.setBackgroundColor(UIColor(red: 47.0/255.0, green: 53.0/255.0, blue: 76.0/255.0, alpha: 1.0))
     SVProgressHUD.setRingThickness(2)
     SVProgressHUD.setAnimationCurve(UIView.AnimationCurve.linear)
//    SVProgressHUD.setForegroundColor(UIColor(red: 246.0/255.0, green: 65.0/255.0, blue: 46.0/255.0, alpha: 1.0))
     SVProgressHUD.setForegroundColor(UIColor.white)
  }
  
    
  private func getHeaderWithAPIName(serviceName: String) -> HTTPHeaders
  {
    
      let headers:HTTPHeaders = [kApiKey : "2349eefbabd85d3c9d06715cc1655caf", kApiDate: "2018-11-16"]

    return headers
  }
  
    
//     func getHeaderWithAPIName(serviceName: String) -> [String: String]
//    {
//        // Add AES authentication ...........
//        let headers:[String:String] = ["AppVersion": kAppVersion, "Content-Type":"application/json", "Accept":"application/json", kAuthentication : encryptRequestString(requestStr: serviceName)]
//        // let headers:[String: String] = ["Content-Type": "application/json"]
//        //    if kSharedUserDefaults.isUserLoggedIn()
//        //    {
//        //      headers["Authorization"] = "token " + UserProfileModel.getCurrentLoggedInUser().userToken
//        //      print_debug(items: "Auth Token --------------------- \(UserProfileModel.getCurrentLoggedInUser().userToken)")
//        //    }
//        return headers
//    }
    
    
    
  private func getServiceUrl(string: String) -> String
  {
    if string.contains("http")
    {
      return string
    }
    else
    {
      return kBASEURL + string
    }
  }
  
  private func getPrintableParamsFromJson(postData: Dictionary<String, Any>) -> String
  {
    do
    {
      let jsonData = try JSONSerialization.data(withJSONObject: postData, options:JSONSerialization.WritingOptions.prettyPrinted)
      let theJSONText = String(data:jsonData, encoding:String.Encoding.ascii)
      return theJSONText ?? ""
    }
    catch let error as NSError
    {
      print_debug(items: error)
      return ""
    }
  }
  
  private func getResponseDataArrayFromData(data: Data) -> (responseData: [Any]?, error: NSError?)
  {
    do
    {
      let responseData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [Any]
      print("Success with JSON: \(String(describing: responseData))")
      return (responseData, nil)
    }
    catch let error as NSError
    {
      print_debug(items: "json error: \(error.localizedDescription)")
      return (nil, error)
    }
  }
  
  private func getResponseDataDictionaryFromData(data: Data) -> (responseData: Dictionary<String, Any>?, error: Error?)
  {
    do
    {
      let responseData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? Dictionary<String, Any>
      print("Success with JSON: \(String(describing: responseData))")
      return (responseData, nil)
    }
    catch let error
    {
      print_debug(items: "json error: \(error.localizedDescription)")
      return (nil, error)
    }
  }
  
//  private func printResponseDataForResponse(response: DataResponse<Any>)
//  {
//    print_debug(items: response.request)  // original URL request
//    print_debug(items: response.response) // URL response
//    print_debug(items: response.data)     // server data
//    print_debug(items: response.result)   // result of response serialization
//  }
  
  private func encryptRequestString(requestStr: String)-> String
  {
    //    let plainTextStr = requestStr+"_\(getCurrentTimeStamp())"
    //    let encyptedStrng = TAAESCrypt.encrypt(plainTextStr, password: kEncryptionKey)
    //    print("encyptedStrng: \(encyptedStrng)")
    return ""
  }
  
  private func getCurrentTimeStamp()-> TimeInterval
  {
    return NSDate().timeIntervalSince1970.rounded();
  }
}

