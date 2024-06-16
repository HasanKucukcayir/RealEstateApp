//
//  ProductsViewController.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 05/10/2021.
//

import UIKit
import MapKit
import SwiftSoup

protocol ProductsViewModelDelegate: UIViewController {
  func didGetProducts(dataSource: [ProductTableViewCellModel])
  func didFailForGettingProducts()
}

var gDataSource:[ProductTableViewCellModel] = []

final class ProductsViewController: BaseViewController, ViewControllerProtocol {
  typealias ViewModelType = ProductsViewModel
  typealias ViewType = ProductsView

  private let mainView: ProductsView
  private let viewModel: ProductsViewModelProtocol

  private var items: [String] = []

  var searchText: String = "Magnum" {
    didSet {
      self.fetchProductPrices()
    }
  }

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
    //    locationManager = CLLocationManager()
    //    locationManager?.delegate = self
    //    checkAuthorizationForLocation()
    //    viewModel.fetchAllProducts()

    fetchProductPrices()
  }

  func fetchProductPrices() {
    let replacedString = searchText.replacingOccurrences(of:" ", with: "%20")
    let urlString = "https://www.ah.nl/zoeken?query=\(replacedString)"

    guard let url = URL(string: urlString) else { return }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data, error == nil else { return }
      do {
        let html = String(data: data, encoding: .utf8)!

        let document = try SwiftSoup.parse(html)
        // Select the script tag containing the window.__INITIAL_STATE__
        let scriptTags = try document.select("script")

        // Iterate over script tags to find the one containing __INITIAL_STATE__
        for script in scriptTags {
          let scriptContent = try script.html()

          // Check if the script contains the __INITIAL_STATE__ variable
          if scriptContent.contains("window.__INITIAL_STATE") {

            let pattern = #"window\.__INITIAL_STATE__\s*=\s*(\{.*?\})\s*window\.__APOLLO_STATE__"#
            if let regex = try? NSRegularExpression(pattern: pattern, options: []),
               let match = regex.firstMatch(in: scriptContent, options: [], range: NSRange(location: 0, length: scriptContent.utf16.count)) {
              if let range = Range(match.range(at: 1), in: scriptContent) {
                let jsonString = String(scriptContent[range])
                let converted = self.convertUndefinedToNull(in: jsonString)
                guard let decodedString = self.replaceUnicodeCharacters(in: converted) else {
                  break
                }
                self.parseJson(jsonString: decodedString)
                break
              }
            }
          }
        }
      } catch {
        print("Error: \(error)")
      }
    }
    task.resume()
  }

  func replaceUnicodeCharacters(in jsonString: String) -> String? {
    guard let data = jsonString.data(using: .utf8) else { return nil }
    do {
      // Decode the JSON data

      guard let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
        return nil
      }

      // Convert the dictionary back to JSON data
      let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)

      // Convert JSON data to string
      var jsonString = String(data: jsonData, encoding: .utf8)

      // Replace unicode characters
      jsonString = jsonString?.replacingOccurrences(of: "\\u", with: "\\\\u")

      return jsonString
    } catch {
      print("Error: \(error)")
      return nil
    }
  }

  func parseJson(jsonString: String) {
    let jsonData = Data(jsonString.utf8)
    guard let aHListModel = try? JSONDecoder().decode(AHListModel.self, from: jsonData) else { return }
    mapDataSource(with: aHListModel)
  }

  func mapDataSource(with model: AHListModel) {

    guard let results = model.search?.results else {
      return
    }

    gDataSource.removeAll()
    for result in results {

      guard let products = result.products else {
        continue
      }

      for product in products {
        let imageUrl = product.images?.first?.url.flatMap { URL(string: $0) }
        let price = product.price?.now.flatMap { String(format: "€%.2f", $0) }
        let address = product.title
        let numberOfBedroom = product.shield?.text ?? ""
        let numberOfBathroom = "" // Replace with actual property if available in product
        let size = "" // Replace with actual property if available in product
        let distance = product.price?.unitSize ?? ""

        let cellModel = ProductTableViewCellModel(
          imageUrl: imageUrl,
          price: price,
          address: address,
          numberOfBedroom: numberOfBedroom,
          numberOfBathroom: numberOfBathroom,
          size: size,
          distance: distance
        )

        gDataSource.append(cellModel)
      }
    }

    DispatchQueue.main.async {
      self.mainView.provideDataSource(gDataSource)
    }

  }

  func convertUndefinedToNull(in jsonString: String) -> String {
    // Replace all instances of `undefined` with `null`
    let convertedString = jsonString.replacingOccurrences(of: "undefined", with: "null")
    return convertedString
  }
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
extension ProductsViewController: ProductsViewDelegate {

  func didSelectItem(at indexPath: IndexPath) {
//    let product = viewModel.selectItem(at: indexPath)
//    let viewController = ProductDetailViewController(view: ProductDetailView(), viewModel: ProductDetailViewModel(product: product))
//    navigationController?.pushViewController(viewController, animated: true)
  }

  func searchBarSearchButtonClicked(_ text: String?) {
//    mainView.provideDataSource(viewModel.filterProduct(with: text))
    searchText = text ?? ""
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
