//
//  NetworkTarget.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 02/10/2021.
//

import Foundation

typealias Parameters = [String : Any]

protocol NetworkTarget {
  var baseURL: URL { get }
  var accessKey: String { get }
  var path: String { get }
  var methodType: MethodType { get }
  var contentType: ContentType { get }
  var workType: WorkType { get }
}

enum MethodType: String {
  case get = "GET"
  case post = "POST"
}

enum ContentType: String {
  case applicationJson = "application/json"
}

enum WorkType {
  case requestWithBodyParameters(parameters: Parameters)
  case requestWithUrlParameters(parameters: Parameters)
  case requestPlain
}
