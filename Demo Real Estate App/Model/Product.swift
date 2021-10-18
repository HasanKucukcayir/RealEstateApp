//
//  Product.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 03/10/2021.
//

import Foundation

typealias ProductList = [Product]

// MARK: - Product
struct Product:Codable {
  let id: Int
  let imgURL: String
  let price: Int
  let bedrooms: Int
  let bathrooms: Int
  let size: Int
  let description: String
  let zip: String
  let city: String
  let latitude: Int
  let longitude: Int
  let createdDate: String
  
  enum CodingKeys: String, CodingKey {
    case id, price, bedrooms, bathrooms, size, description, zip, city,latitude, longitude, createdDate
    case imgURL = "image"
  }
}

// MARK: - Equatable
extension Product: Equatable {
  
  static func == (lhs: Product, rhs: Product) -> Bool {
    lhs.id == rhs.id &&
    lhs.imgURL == rhs.imgURL &&
    lhs.price == rhs.price &&
    lhs.bedrooms == rhs.bedrooms &&
    lhs.bathrooms == rhs.bathrooms &&
    lhs.size == rhs.size &&
    lhs.description == rhs.description &&
    lhs.zip == rhs.zip &&
    lhs.city == rhs.city &&
    lhs.latitude == rhs.latitude &&
    lhs.longitude == rhs.longitude &&
    lhs.createdDate == rhs.createdDate
  }
}
