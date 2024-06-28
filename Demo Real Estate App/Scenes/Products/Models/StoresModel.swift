//
//  StoresModel.swift
//  Demo Real Estate App
//
//  Created by Hasan on 22/06/2024.
//

import Foundation

let urlsdsds = [
    URL(string: "https://www.ah.nl/zoeken?query=magnum")!,
    URL(string: "https://www.jumbo.com/producten/?searchType=keyword&searchTerms=magnum")!,
    URL(string: "https://www.kruidvat.nl/search?q=dove&text=dove&searchType=manual")!,
    URL(string: "https://www.etos.nl/search/?lang=nl_NL&q=pampers")!,
//    URL(string: "https://www.hoogvliet.com/product/pampers-baby-dry-pants-maat-62")!,
    URL(string: "https://www.lidl.nl/q/search?q=tuinslang")!,
    URL(string: "https://www.praxis.nl/search?text=gardena")!,
    URL(string: "https://www.trekpleister.nl/search?q=pampers&text=pampers&searchType=manual")!
]

enum StoreModel {
  case albertHeijn
  case jumbo
  case kruidvat
  case etos
  case lidl
  case trekpleister
}

struct DataModel {
  var store: StoreModel
  var data: Data

  init(store: StoreModel, data: Data) {
    self.store = store
    self.data = data
  }
}

class StoreModelImplementation {

  func getBaseUrl(store: StoreModel, searchText: String) -> String {
    switch store {
    case .albertHeijn:
      return "https://www.ah.nl/zoeken?query="+replaceSpaceCharWithUnicodeChar(searchText: searchText)
    case .jumbo:
      return "https://www.jumbo.com/producten/?searchType=keyword&searchTerms="+replaceSpaceCharWithPlusChar(searchText: searchText)
    case .kruidvat:
      let replaced = replaceSpaceCharWithPlusChar(searchText: searchText)
      return "https://www.kruidvat.nl/search?q="+replaced+"&text="+replaced+"&searchType=manual"
    case .etos:
      return "https://www.etos.nl/search/?q="+replaceSpaceCharWithUnicodeChar(searchText: searchText)
    case .lidl:
      let replaced = replaceSpaceCharWithPlusChar(searchText: searchText)
      return "https://www.lidl.nl/q/search?q="+replaced
    case .trekpleister:
      let replaced = replaceSpaceCharWithPlusChar(searchText: searchText)
      return "https://www.trekpleister.nl/search?q="+replaced+"&text="+replaced+"&searchType=manual"
    }
  }

  private func replaceSpaceCharWithUnicodeChar(searchText: String) -> String {
    return searchText.replacingOccurrences(of:" ", with: "%20")
  }

  private func replaceSpaceCharWithPlusChar(searchText: String) -> String {
    return searchText.replacingOccurrences(of:" ", with: "+")
  }

}
