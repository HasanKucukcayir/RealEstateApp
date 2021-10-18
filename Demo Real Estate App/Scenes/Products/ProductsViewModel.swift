//
//  ProductsViewModel.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 05/10/2021.
//

import CoreLocation

protocol ProductsViewModelProtocol: ViewModel {
  /// Fetches All Products
  func fetchAllProducts()
  
  /// Filters Products based on id
  /// - Parameter id: id to be filter parameter
  func filterProduct(with id: String?) -> [ProductTableViewCellModel]
  
  /// Select description
  /// - Parameter indexPath: current indexpath of item
  func selectItem(at indexPath: IndexPath) -> Product
}

final class ProductsViewModel: ViewModel {
  weak var delegate: ProductsViewModelDelegate?
  private let productAPIService: ProductApiServiceProtocol

  private var productList: ProductList = []
  private var filteredList: ProductList?
  
  init (productAPIService: ProductApiServiceProtocol) {
    self.productAPIService = productAPIService
  }
}

// MARK: - ProductsViewModelProtocol
extension ProductsViewModel: ProductsViewModelProtocol {
  
  func fetchAllProducts() {
    cleanDataSource()
    productAPIService.fetchAllProducts { result in
      switch result {
      case .failure:
        self.delegate?.didFailForGettingProducts()
        
      case .success(var productList):
        productList.sort {$0.price < $1.price}
        self.productList = productList
        let dataSource = self.generateProductTableViewCellModel(from: productList)
        self.delegate?.didGetProducts(dataSource: dataSource)
      }
    }
  }
  
  func filterProduct(with id: String?) -> [ProductTableViewCellModel] {
    guard let id = id else {
      filteredList = nil
      return generateProductTableViewCellModel(from: productList)
    }
    filteredList = productList.filter { $0.zip.lowercased().range(of: id.lowercased()) != nil || $0.city.lowercased().range(of: id.lowercased()) != nil}
    return generateProductTableViewCellModel(from: filteredList!)
  }
  
  func selectItem(at indexPath: IndexPath) -> Product {
    let row = indexPath.row
    guard let filtered = filteredList else {
      return self.productList[row]
    }
    return filtered[row]
  }
}

// MARK: - Private
extension ProductsViewModel {

  func generateProductTableViewCellModel(from dataSource: ProductList) -> [ProductTableViewCellModel] {
    dataSource.map {
      
      let imageUrl = URL(string: Constants.imageUrl)!.appendingPathComponent($0.imgURL)
      let address = "\($0.zip.filter{!$0.isWhitespace}) \($0.city)"
      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      let price = "$\(formatter.string(from: NSNumber(value: $0.price))!)"
      let numberOfBedroom = "\($0.bedrooms)"
      let numberOfBathroom = "\($0.bathrooms)"
      let size = "\($0.size)"
      let distance = calculateDistance(_latitude: $0.latitude, _longitude: $0.longitude)

      return ProductTableViewCellModel(imageUrl: imageUrl, price: price, address: address, numberOfBedroom: numberOfBedroom, numberOfBathroom: numberOfBathroom, size: size, distance: distance)
    }
  }
  
  func cleanDataSource() {
    filteredList = nil
    productList = []
  }
  
}
