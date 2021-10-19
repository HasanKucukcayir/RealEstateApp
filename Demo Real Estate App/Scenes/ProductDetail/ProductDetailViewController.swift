//
//  ProductDetailViewController.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 10/10/2021.
//

import UIKit
import MapKit

protocol ProductDetailViewModelDelegate: UIViewController {
  func getProductDetail()
}

final class ProductDetailViewController: BaseViewController {

  typealias ViewModelType = ProductDetailViewModel
  typealias ViewType = ProductDetailView
  
  private let mainView: ViewType
  private let viewModel: ViewModelType
  
  init(view: ProductDetailView, viewModel: ProductDetailViewModel) {
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
    getProductDetail()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tabBarController?.tabBar.isHidden = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.tabBarController?.tabBar.isHidden = false
  }
  
}

// MARK: - ProductDetailViewModelDelegate
extension ProductDetailViewController: ProductDetailViewModelDelegate {

  func getProductDetail() {
    mainView.prepareView(viewModel.getProduct())
  }
}

// MARK: - ProductDetailViewDelegate
extension ProductDetailViewController: ProductDetailViewDelegate {
  func didPressBack() {
    navigationController?.popViewController(animated: true)
  }
}
