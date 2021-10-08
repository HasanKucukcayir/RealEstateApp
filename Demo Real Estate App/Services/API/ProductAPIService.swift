//
//  ProductAPIService.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 03/10/2021.
//

import Foundation

protocol ProductApiServiceProtocol: NetworkService<ProductTarget> {
    
    ///  Fetches Products by ID
    /// - Parameters:
    ///   - id: Product specific id
    ///   - completion: Result with Success(Product) or Failure( NetworkError)
    func fetchProductByID(_ id: String, completion: @escaping (Result<Product, NetworkError>) -> Void)
    
    /// Fetches all Products
    /// - Parameter completion: Result with Success(ProductList) or Failure( NetworkError)
    func fetchAllProducts(completion: @escaping (Result<ProductList, NetworkError>) -> Void)
}

final class ProductApiService: NetworkService<ProductTarget> { }

// MARK: - ProductApiServiceProtocol
extension ProductApiService: ProductApiServiceProtocol {
  
  func fetchProductByID(_ id: String, completion: @escaping (Result<Product, NetworkError>) -> Void) {
    request(target: .productByID(id), completion: completion)
  }
  
  func fetchAllProducts(completion: @escaping (Result<ProductList, NetworkError>) -> Void) {
    request(target: .product, completion: completion)
  }
}
