//
//  ProductDetailViewModel.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 10/10/2021.
//

import UIKit

protocol ProductDetailViewModelProtocol: ViewModel {
    func getProduct() -> Product
}

final class ProductDetailViewModel: ViewModel {
  weak var delegate: ProductDetailViewModelDelegate?

  private var product: Product

  init(product: Product) {
    self.product = product
  }

}

// MARK: - ProductDetailViewModelProtocol
extension ProductDetailViewModel: ProductDetailViewModelProtocol {
  func getProduct() -> Product {
    return product
  }
}
