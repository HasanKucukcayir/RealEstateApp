//
//  LocationService.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 09/10/2021.
//

import Foundation
import CoreLocation

protocol LocationServiceProtocol:CLLocationManagerDelegate {
  func fetchCurrentPosition()
  func didFailWithLocationError(error: Error)
}

class LocationService {
  
  //My location
  let myLocation = CLLocation(latitude: 59.244696, longitude: 17.813868)

  //My buddy's location
  let myBuddysLocation = CLLocation(latitude: 59.326354, longitude: 18.072310)
  
  func gg () {
    //Measuring my distance to my buddy's (in km)
    let distance = myLocation.distance(from: myBuddysLocation) / 1000

    //Display the result in km
    print(String(format: "The distance to my buddy is %.01fkm", distance))
  }
  
}
