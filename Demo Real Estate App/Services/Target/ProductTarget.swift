//
//  ProductTarget.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 03/10/2021.
//

import Foundation

enum ProductTarget {
  case product
  case productByID(_ id: String)
}

extension ProductTarget: NetworkTarget {
  var baseURL: URL { URL(string: Constants.baseAPIUrl)! }
  var accessKey: String { "98bww4ezuzfePCYFxJEWyszbUXc7dxRx" }
  
  var path: String {
    switch self {
    case .product:
      return ""
    case let.productByID(id):
      return "product/\(id).json"
    }
  }
  
  var methodType: MethodType { .get }
  
  var contentType: ContentType { .applicationJson }
  
  var workType: WorkType { .requestPlain }
  

}
