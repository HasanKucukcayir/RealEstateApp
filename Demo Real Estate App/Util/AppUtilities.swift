//
//  AppUtilities.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 18/10/2021.
//

import Foundation
import CoreLocation

/// Calculates distance between user location and home location
/// - Parameter _latitude: home latitude
/// - Parameter _longitude: home longitude
func calculateDistance(latitude:Int, longitude:Int) -> String {
  let defaults = UserDefaults.standard
  
  let userLocation = CLLocation(latitude: CLLocationDegrees(defaults.object(forKey: UserDefaultsKeyHelper.amsterdamLatitude) as! String)!, longitude: CLLocationDegrees(defaults.object(forKey: UserDefaultsKeyHelper.amsterdamLongitude) as! String)!)
  
  let targetLocation = CLLocation(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
  
  //Measuring distance (in km)
  let distance = userLocation.distance(from: targetLocation) / 1000
  
  //Display the result in km
  return String(format: "%.01f km", distance)
}

func getDefaultLatitudeFromInfoPlist () -> String {
  let latitude:String = Bundle.main.object(forInfoDictionaryKey: UserDefaultsKeyHelper.amsterdamLatitude) as! String
  return latitude
}

func getDefaultLongitudeFromInfoPlist () -> String {
  let Longitude:String = Bundle.main.object(forInfoDictionaryKey: UserDefaultsKeyHelper.amsterdamLongitude) as! String
  return Longitude
}

func setUserCurrentLocationCoordinates (latitude:String, longitude:String) {
  let defaults = UserDefaults.standard
  defaults.set(latitude, forKey:UserDefaultsKeyHelper.amsterdamLatitude)
  defaults.set(longitude, forKey:UserDefaultsKeyHelper.amsterdamLongitude)
}



