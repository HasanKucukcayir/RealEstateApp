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
func calculateDistance(latitude: Int, longitude: Int) -> String {
  let defaults = UserDefaults.standard

  guard let userLatitude = CLLocationDegrees(defaults.object(forKey: UserDefaultsKeyHelper.userLatitude) as? String ?? getDefaultLatitudeFromInfoPlist()) else { return Constants.defaultLatitude }

  guard let userLongitude = CLLocationDegrees(defaults.object(forKey: UserDefaultsKeyHelper.userLongitude) as? String ?? getDefaultLongitudeFromInfoPlist()) else { return Constants.defaultLongitude }

  let userLocation = CLLocation(latitude: userLatitude, longitude: userLongitude)

  let targetLocation = CLLocation(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))

  // Measuring distance (in km)
  let distance = userLocation.distance(from: targetLocation) / 1000

  // Display the result in km
  return String(format: "%.01f km", distance)
}

func getDefaultLatitudeFromInfoPlist () -> String {
  let latitude: String = Bundle.main.object(forInfoDictionaryKey: UserDefaultsKeyHelper.amsterdamLatitude) as? String ?? Constants.defaultLatitude
  return latitude
}

func getDefaultLongitudeFromInfoPlist () -> String {
  let longitude: String = Bundle.main.object(forInfoDictionaryKey: UserDefaultsKeyHelper.amsterdamLongitude) as? String ?? Constants.defaultLongitude
  return longitude
}

func setUserCurrentLocationCoordinates (latitude: String, longitude: String) {
  let defaults = UserDefaults.standard
  defaults.set(latitude, forKey: UserDefaultsKeyHelper.userLatitude)
  defaults.set(longitude, forKey: UserDefaultsKeyHelper.userLongitude)
}

// gets localized strings from Default table
func localizedString(forKey key: String) -> String {
    let result = Bundle.main.localizedString(forKey: key, value: nil, table: "Default")
    return result
}
