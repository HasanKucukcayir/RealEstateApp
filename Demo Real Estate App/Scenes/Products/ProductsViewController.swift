//
//  ProductsViewController.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 05/10/2021.
//

import UIKit
import MapKit

protocol ProductsViewModelDelegate: UIViewController {
  func didGetProducts(dataSource: [ProductTableViewCellModel])
  func didFailForGettingProducts()
}

final class ProductsViewController: BaseViewController, ViewControllerProtocol {
  typealias ViewModelType = ProductsViewModel
  typealias ViewType = ProductsView
  
  private let mainView: ProductsView
  private let viewModel: ProductsViewModelProtocol
  
  var locationManager: CLLocationManager?
  
  init(view: ProductsView, viewModel: ProductsViewModel) {
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
    locationManager = CLLocationManager()
    locationManager?.delegate = self
    checkAuthorizationForLocation()
  }
  
}

// MARK: - CLLocationManagerDelegate
extension ProductsViewController: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      if let location = locations.first{
        setUserCurrentLocationCoordinates(latitude: String(location.coordinate.latitude), longitude: String(location.coordinate.longitude))
        viewModel.fetchAllProducts()
      }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    showPermissionDeniedAlert(title: "An error occured!")
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    checkAuthorizationForLocation()
  }
  
  private func setDefaultLocationValues() {
    let latitude = getDefaultLatitudeFromInfoPlist()
    let longitude = getDefaultLongitudeFromInfoPlist()
    setUserCurrentLocationCoordinates(latitude: latitude, longitude: longitude)
  }
  
  private func showPermissionDeniedAlert(title: String) {
    setDefaultLocationValues()
    viewModel.fetchAllProducts()
    DispatchQueue.main.async {
      let title = title
      let description = "Amsterdam is set as your default location."
      let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
      alert.addAction(.init(title: "Okey", style: .default))
      self.present(alert, animated: true)
    }
  }
  
  private func checkAuthorizationForLocation() {
    if CLLocationManager.locationServicesEnabled() {
      switch locationManager!.authorizationStatus {
      case .authorizedAlways, .authorizedWhenInUse:
        locationManager!.requestLocation()
      case .denied, .restricted:
        showPermissionDeniedAlert(title: "Location permission denied!")
      case  .notDetermined:
        locationManager?.requestAlwaysAuthorization()
      @unknown default:
        viewModel.fetchAllProducts()
      }
    }
    else {
      locationManager?.requestAlwaysAuthorization()
    }
  }
  
}

// MARK: - ProductsViewDelegate
extension ProductsViewController: ProductsViewDelegate {
  
  func didSelectItem(at indexPath: IndexPath) {
    let product = viewModel.selectItem(at: indexPath)
    let viewController = ProductDetailViewController(view: ProductDetailView(), viewModel: ProductDetailViewModel(product: product))
    navigationController?.pushViewController(viewController, animated: true)
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
