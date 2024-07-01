//
//  ProductsViewController.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 05/10/2021.
//

import UIKit
import MapKit

protocol ProductsViewModelDelegate: AnyObject {
  func didGetProducts(dataSource: [ProductTableViewCellModel])
  func didFailForGettingProducts()
}

var gDataSource: [ProductTableViewCellModel] = []
var storeViewModel = StoreModelImplementation()
var dataList: [DataModel] = []

let stores = [
  StoreModel.albertHeijn,
  StoreModel.jumbo,
  StoreModel.kruidvat,
  StoreModel.etos,
//  StoreModel
]

var startTime = CFAbsoluteTimeGetCurrent()
var endTime = CFAbsoluteTimeGetCurrent()

final class ProductsViewController: BaseViewController, ViewControllerProtocol {

  typealias ViewModelType = ProductsViewModel
  typealias ViewType = ProductsView

  private let mainView: ProductsView
  private let viewModel: ProductsViewModelProtocol

  let decoder = ProductDecoder()

  private var items: [String] = []

  var searchText: String = "Robijn wasmiddel" {
    didSet {
      self.performAction()
    }
  }

  var locationManager: CLLocationManager?

  init(view: ProductsView, viewModel: ProductsViewModel) {
    self.mainView = view
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    viewModel.delegate = self
    decoder.delegate = self
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
    //    locationManager = CLLocationManager()
    //    locationManager?.delegate = self
    //    checkAuthorizationForLocation()
    //    viewModel.fetchAllProducts()

    performAction()
  }

  func performRequest(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
      let task = URLSession.shared.dataTask(with: url, completionHandler: completion)
      task.resume()
  }

  func performAction() {
    clearDataSources()

    let dispatchGroup = DispatchGroup()
    startTime = CFAbsoluteTimeGetCurrent()

    for store in stores {
      let urlString = storeViewModel.getBaseUrl(store: store, searchText: searchText)
      guard let url = URL(string: urlString) else { return }
      dispatchGroup.enter()
      performRequest(url: url) { data, response, error in
        defer { dispatchGroup.leave() }

        if let error = error {
          print("Error: \(error.localizedDescription)")
        } else if let data = data, let response = response as? HTTPURLResponse {
          print("Response Code: \(response.statusCode), Data: \(data.count) bytes")
          dataList.append(DataModel(store: store, data: data))
        }
      }
    }

    // Notify when all requests are complete
    dispatchGroup.notify(queue: .main) {
        print("All requests completed")
      self.decodeHtmlFiles()
      endTime = CFAbsoluteTimeGetCurrent()
      print("- - - \(endTime - startTime)")
    }

    // Keep the main thread alive to wait for async tasks
//    RunLoop.main.run()
  }

  func clearDataSources() {
    decoder.counter = 0
    gDataSource.removeAll()
    dataList.removeAll()
  }

  func decodeHtmlFiles() {
    for data in dataList {
      let html = String(data: data.data, encoding: .utf8)!
      switch data.store {
      case .albertHeijn:
        decoder.decodeAH(html: html)
      case .jumbo:
        decoder.decodeJumbo(html: html)
      case .kruidvat:
//        decoder.decodeKruidvat(html: html)
        print("Jumbo")
      case .etos:
        print("Jumbo")
      case .lidl:
        print("Jumbo")
      case .trekpleister:
        print("trekpleister")
      case .action:
        print("action")
      }

    }
  }

  //MARK: - AH -

}

// MARK: - CLLocationManagerDelegate
extension ProductsViewController: CLLocationManagerDelegate {

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
      setUserCurrentLocationCoordinates(latitude: String(location.coordinate.latitude), longitude: String(location.coordinate.longitude))
      viewModel.fetchAllProducts()
    }
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    showPermissionDeniedAlert(title: localizedString(forKey: Constants.LocalizedStrings.errorMessage))
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
      let description = localizedString(forKey: Constants.LocalizedStrings.locationAlertDescription)
      let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
      alert.addAction(.init(title: localizedString(forKey: Constants.LocalizedStrings.okey), style: .default))
      self.present(alert, animated: true)
    }
  }

  private func checkAuthorizationForLocation() {
    if CLLocationManager.locationServicesEnabled() {
      switch locationManager!.authorizationStatus {
      case .authorizedAlways, .authorizedWhenInUse:
        locationManager!.requestLocation()
      case .denied, .restricted:
        showPermissionDeniedAlert(title: localizedString(forKey: Constants.LocalizedStrings.permissionDeniedAlert))
      case  .notDetermined:
        locationManager?.requestAlwaysAuthorization()
      @unknown default:
        viewModel.fetchAllProducts()
      }
    } else {
      locationManager?.requestAlwaysAuthorization()
    }
  }

}

// MARK: - ProductsViewDelegate
extension ProductsViewController: ProductDecoderDelegate {
  func didFinishDecoding() {
    DispatchQueue.main.async {
      self.mainView.provideDataSource(gDataSource)
      endTime = CFAbsoluteTimeGetCurrent()
      print("- - - TookC \(endTime - startTime)")
    }
  }
}

// MARK: - ProductsViewDelegate
extension ProductsViewController: ProductsViewDelegate {
  func searchBarDidBeginEditing() {
    decoder.counter = 0
  }

  func didSelectItem(at indexPath: IndexPath) {
        let product = viewModel.selectItem(at: indexPath)
    //    let viewController = ProductDetailViewController(view: ProductDetailView(), viewModel: ProductDetailViewModel(product: product))
    //    navigationController?.pushViewController(viewController, animated: true)
  }

  func searchBarSearchButtonClicked(_ text: String?) {
    //    mainView.provideDataSource(viewModel.filterProduct(with: text))
    searchText = text ?? ""
    decoder.counter = 0
  }

  func searchBarCancelButtonClicked() {
    mainView.provideDataSource(viewModel.filterProduct(with: nil))
  }

  func arrangeSearchBarImages() {

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
      let title = localizedString(forKey: Constants.LocalizedStrings.APICallError)
      let description = localizedString(forKey: Constants.LocalizedStrings.APICallErrorDescription)
      let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
      alert.addAction(.init(title: localizedString(forKey: Constants.LocalizedStrings.cancel), style: .destructive))
      alert.addAction(.init(title: localizedString(forKey: Constants.LocalizedStrings.retry), style: .default, handler: { _ in
        self.viewModel.fetchAllProducts()
      }))
      self.present(alert, animated: true)
    }
  }
}
