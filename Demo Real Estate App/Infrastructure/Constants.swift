//
//  Constants.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 05/10/2021.
//

import Foundation

struct Constants {
  // General
  static let baseAPIUrl: String = "https://intern.docker-dev.d-tt.nl/api/house"
  static let imageUrl: String = "https://intern.docker-dev.d-tt.nl/"
  static let companyWebsiteUrl: String = "https://www.d-tt.nl"
  static let companyWebsiteText: String = "d-tt.nl"
  static let mapsAppRouteUrl: String = "http://maps.apple.com/?daddr="
  static let defaultLatitude = "52.367301"
  static let defaultLongitude = "4.899820"

  // Localized Strings
  struct LocalizedStrings {
    static let errorMessage: String = "error.message"
    static let okey: String = "okey"
    static let cancel: String = "cancel"
    static let retry: String = "retry"
    static let navigationText: String = "navigation.text"
    static let searchBarPlaceholder: String = "searchBar.placeholder"
    static let locationAlertDescription: String = "default.location.alert.description"
    static let permissionDeniedAlert: String = "permission.denied.alert"
    static let APICallError: String = "API.call.error"
    static let APICallErrorDescription: String = "API.call.error.description"
    static let emptyResultLabelTextRow1: String = "emptyResultLabel.text.row1"
    static let emptyResultLabelTextRow2: String = "emptyResultLabel.text.row2"
    static let homePinTitle: String = "homePin.title"
    static let descriptionTitle: String = "descriptionHeaderLabel.text"
    static let locationLabelText: String = "locationLabel.text"
    static let companyNameLabelText: String = "companyNameLabel.text"
    static let secondHeaderLabelText: String = "secondHeaderLabel.text"
    static let topHeaderLabelText: String = "topHeaderLabel.text"
  }

}
