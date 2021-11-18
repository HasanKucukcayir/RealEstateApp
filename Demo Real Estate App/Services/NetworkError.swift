//
//  NetworkError.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 02/10/2021.
//

import Foundation

enum NetworkError: Error {
  case unknown
  case sessionError(Error)
  case decodingError(Error)
  case unsuccessfulStatusCode(code: Int)
}
