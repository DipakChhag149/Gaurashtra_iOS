//
//  GetUserLocation.swift
//  Abwab
//
//  Created by Fluper on 02/04/17.
//  Copyright © 2017 ABC. All rights reserved.
//

import UIKit
import CoreLocation

class GetUserLocation: CLLocationManager
{
  var currentLocation: CLLocation?
  
  fileprivate var sendLocation = {(_ location: CLLocation?) -> () in }
  
  static let sharedInstance = GetUserLocation()
  private override init()
  {
  }
		
  func checkIfLocationPermissionAuthorized() -> Bool
  {
    if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse
    {
      return true
    }
    else
    {
      return false
    }
  }
  
  func getCurrentLocation(getLocation: @escaping (_ location: CLLocation?) -> ())
  {
    self.delegate = self
    self.distanceFilter = kCLDistanceFilterNone
    self.desiredAccuracy = kCLLocationAccuracyBest
    
    requestWhenInUsagePermission()
    sendLocation = getLocation
  }
  
  func requestWhenInUsagePermission()
  {
    if CLLocationManager.locationServicesEnabled()
    {
      if self.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization))
      {
        self.requestWhenInUseAuthorization()
      }
    }
    self.startUpdatingLocation()
  }
  
  func requestAlwaysUsagePermission()
  {
    if CLLocationManager.locationServicesEnabled()
    {
      if self.responds(to: #selector(CLLocationManager.requestAlwaysAuthorization))
      {
        self.requestAlwaysAuthorization()
      }
    }
    self.startUpdatingLocation()
  }
}

//MARK:- ----------CLLocation Manager Delegates---------
extension GetUserLocation: CLLocationManagerDelegate
{
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
  {
    self.stopUpdatingLocation()
    if locations.count > 0 && currentLocation == nil
    {
      currentLocation = locations.last
      sendLocation(locations.last)
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
  {
  }
}
