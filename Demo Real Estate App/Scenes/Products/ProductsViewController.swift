//
//  ProductsViewController.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 05/10/2021.
//

import UIKit

protocol ProductsViewModelDelegate: UIViewController {
  func didGetProducts(dataSource: [ProductTableViewCellModel])
  func didFailForGettingProducts()
}

final class ProductsViewController: BaseViewController, ViewControllerProtocol {
  typealias ViewModelType = ProductsViewModel
  typealias ViewType = ProductsView
  
  private let mainView: ProductsView
  private let viewModel: ProductsViewModelProtocol
  
  init(view: ProductsView, viewModel viewModel: ProductsViewModel) {
    self.mainView = view
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    viewModel.delegate = self
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    mainView.delegate = self
    view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.fetchAllProducts()
  }
}

extension ProductsViewController: ProductsViewDelegate {
  
  func didSelectItem(at indexPath: IndexPath) {
    let product = viewModel.selectItem(at: indexPath)
//    let viewController = ProductDetailViewController(view: ProductDetailView(), viewModel: ProductDetailViewModel(product: product, productAPIService: ProductApiService(), reviewAPIService: ReviewApiService()))
//    navigationController?.pushViewController(viewController, animated: true)
  }
  
  func searchBarSearchButtonClicked(_ text: String?) {
    mainView.provideDataSource(viewModel.filterProduct(with: text))
  }
  
  func searchBarCancelButtonClicked() {
    mainView.provideDataSource(viewModel.filterProduct(with: nil))
  }
}

// MARK: - ProductsViewModelDelegate
extension ProductsViewController: ProductsViewModelDelegate {
  func didGetProducts(dataSource: [ProductTableViewCellModel]) {
    DispatchQueue.main.async {
      self.mainView.provideDataSource(dataSource)
    }
  }
  
  func didFailForGettingProducts() {
    DispatchQueue.main.async {
      let title = "Failed To get Products"
      let description = "Ooops something went wrong :("
      let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
      alert.addAction(.init(title: "Cancel", style: .destructive))
      alert.addAction(.init(title: "Retry", style: .default, handler: { _ in
        self.viewModel.fetchAllProducts()
      }))
      self.present(alert, animated: true)
    }
  }
}
