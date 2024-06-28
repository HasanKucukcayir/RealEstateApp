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

var gDataSource: [ProductTableViewCellModel] = []
var storeViewModel = StoreModelImplementation()
var dataList: [DataModel] = []

let stores = [
  StoreModel.albertHeijn,
  StoreModel.jumbo,
  StoreModel.kruidvat,
  StoreModel.etos
]

var startTime = CFAbsoluteTimeGetCurrent()
var endTime = CFAbsoluteTimeGetCurrent()

final class ProductsViewController: BaseViewController, ViewControllerProtocol {
  typealias ViewModelType = ProductsViewModel
  typealias ViewType = ProductsView

  private let mainView: ProductsView
  private let viewModel: ProductsViewModelProtocol

  private var items: [String] = []

  var searchText: String = "Magnum" {
    didSet {
      self.performAction()
    }
  }

  var counter = 0 {
    didSet {
      if counter >= stores.count {
        DispatchQueue.main.async {
          self.mainView.provideDataSource(gDataSource)
          endTime = CFAbsoluteTimeGetCurrent()
          print("- - - TookC \(endTime - startTime)")
        }
      }
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
    counter = 0
    gDataSource.removeAll()
    dataList.removeAll()
  }

  func decodeHtmlFiles() {
    for data in dataList {
      let html = String(data: data.data, encoding: .utf8)!

      counter += 1

      switch data.store {
      case .albertHeijn:
        decodeAH(html: html)
      case .jumbo:
        print("Jumbo")
      case .kruidvat:
        print("Jumbo")
      case .etos:
        print("Jumbo")
      case .lidl:
        print("Jumbo")
      case .trekpleister:
        print("trekpleister")
      }

    }
  }

  //MARK: - Decode -

  func decodeAH(html: String) {
    do {
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

  func decodeJumbo(html: String) {

  }

  //MARK: - AH -
  func fetchKruidvatProductPrices() async {
    endTime = CFAbsoluteTimeGetCurrent()
    print("- - - TookKruidvatStart\(endTime - startTime)")
    let replacedString = searchText.replacingOccurrences(of:" ", with: "+")
    //    let urlString = "https://www.jumbo.com/producten/?searchType=keyword&searchTerms=\(replacedString)"

    let urlString = "https://www.etos.nl/search/?q=robijn%20color"
    guard let url = URL(string: urlString) else { return }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data1 = data, error == nil else { return }
      endTime = CFAbsoluteTimeGetCurrent()
      print("- - - TookKruidvatEnd \(endTime - startTime)")
      do {
        let html = String(data: data1, encoding: .utf8)!

        let document = try SwiftSoup.parse(html)
        let productListCols = try document.select(".product__list-col")



        for productListCol in productListCols {
          let impressionTrackers = try productListCol.select("e2-impression-tracker")

          for tracker in impressionTrackers {
            let className = try tracker.attr("class")
            let viewHandler = try tracker.attr("view-handler")
            let dataType = try tracker.attr("data-type")
            let dataCurrency = try tracker.attr("data-currency")
            let dataItemName = try tracker.attr("data-item-name")
            let dataCode = try tracker.attr("data-code")
            let dataPrice = try tracker.attr("data-price")

            //                  print("Class: \(className)")
            //                  print("View Handler: \(viewHandler)")
            //                  print("Data Type: \(dataType)")
            //                  print("Data Currency: \(dataCurrency)")
            //                  print("Data Item Name: \(dataItemName)")
            //                  print("Data Code: \(dataCode)")
            //                  print("Data Price: \(dataPrice)")
            //                  print("---------------------")
          }
        }

        endTime = CFAbsoluteTimeGetCurrent()
        print("- - - TooKruidvatEndResult\(endTime - startTime)")
        self.counter += 1
      } catch Exception.Error(let type, let message) {
        print("Message: \(message)")
      } catch {
        print("error")
      }
    }
    task.resume()
  }

  //MARK: - AH -
  func fetchAHProductPrices() async {
    let replacedString = searchText.replacingOccurrences(of:" ", with: "%20")
    let urlString = "https://www.ah.nl/zoeken?query=\(replacedString)"

    endTime = CFAbsoluteTimeGetCurrent()
    print("- - - TookAHStart\(endTime - startTime)")

    guard let url = URL(string: urlString) else { return }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in

      endTime = CFAbsoluteTimeGetCurrent()
      print("- - - TookAHEnd\(endTime - startTime)")
      guard let data1 = data, error == nil else { return }
      do {
        let html1 = String(data: data1, encoding: .utf8)!

        let document = try SwiftSoup.parse(html1)
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

  //MARK: - Jumbo -
  func fetchJumboProductPrices() async {

    endTime = CFAbsoluteTimeGetCurrent()
    print("- - - TookJumboStart\(endTime - startTime)")

    let replacedString = searchText.replacingOccurrences(of:" ", with: "+")
    let urlString = "https://www.jumbo.com/producten/?searchType=keyword&searchTerms=\(replacedString)"

    guard let url = URL(string: urlString) else { return }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      endTime = CFAbsoluteTimeGetCurrent()
      print("- - - TookJumboEnd\(endTime - startTime)")
      guard let data1 = data, error == nil else { return }
      do {
        let html = String(data: data1, encoding: .utf8)!
        let document = try SwiftSoup.parse(html)
        let productList = try document.select("div.jum-card")

        //        var index = 0
        for product in productList.array() {

          //          if index >= 10 {
          //            break
          //          }

          var productTitle = ""
          if let titleElement = try product.select("a.title-link").first(),
             let title = try? titleElement.text(),
             let link = try? titleElement.attr("href") {
            productTitle = title
          }

          // Extract price-per-unit
          if let pricePerUnitElement = try product.select("div.price-per-unit").first(),
             let pricePerUnit = try? pricePerUnitElement.text() {
          }

          var pricePerUnitF = ""
          if let pricePerUnitElement = try product.select("div.price-per-unit").first(),
             let pricePerUnit = try? pricePerUnitElement.text() {
            pricePerUnitF = pricePerUnit

          }

          // Extract whole and fractional values
          var price = "N/A"
          if let wholeElement = try product.select("span.whole").first(),
             let fractionalElement = try product.select("sup.fractional").first(),
             let whole = try? wholeElement.text(),
             let fractional = try? fractionalElement.text() {
            price = "\(whole).\(fractional)"
          }

          var tag = ""
          // Extract tag-line elements
          let tagLineElements = try product.select("span.tag-line")
          for tagLineElement in tagLineElements {
            if let tagLine = try? tagLineElement.text() {
              tag += " \(tagLine)"
            }
          }

          var imageUrl = ""
          if let productImageElement = try product.select("div.product-image img").first(),
             let productImageSrc = try? productImageElement.attr("src") {
            imageUrl = productImageSrc
          }

          let productImageUrl = URL(string: imageUrl)
          let priceFormatted = "€\(price)"
          let address = productTitle
          let numberOfBedroom = tag
          let numberOfBathroom = "" // Replace with actual property if available in product
          let size = "" // Replace with actual property if available in product
          let distance = pricePerUnitF
          let cellModel = ProductTableViewCellModel(
            imageUrl: productImageUrl,
            price: priceFormatted,
            address: address,
            numberOfBedroom: numberOfBedroom,
            numberOfBathroom: numberOfBathroom,
            size: size,
            distance: distance,
            logo: StoreImageHelper.logoJumbo
          )

          gDataSource.append(cellModel)
          //          index += 1
        }

        endTime = CFAbsoluteTimeGetCurrent()
        print("- - - TooJumboEndResult\(endTime - startTime)")
        self.counter += 1
      } catch Exception.Error(let type, let message) {
        print("Message: \(message)")
      } catch {
        print("error")
      }
    }
    task.resume()
  }

  // MARK: - Extensions -
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

    //    var index = 0
    for result in results {

      guard let products = result.products else {
        continue
      }

      //      if index >= 10 {
      //        break
      //      }

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
          distance: distance,
          logo: StoreImageHelper.logoAlbertHeijn
        )

        gDataSource.append(cellModel)
        //        index += 1
      }
    }
    endTime = CFAbsoluteTimeGetCurrent()
    print("- - - TookAHEndResult\(endTime - startTime)")
    counter += 1

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
  func searchBarDidBeginEditing() {
    counter = 0
  }

  func didSelectItem(at indexPath: IndexPath) {
        let product = viewModel.selectItem(at: indexPath)
    //    let viewController = ProductDetailViewController(view: ProductDetailView(), viewModel: ProductDetailViewModel(product: product))
    //    navigationController?.pushViewController(viewController, animated: true)
  }

  func searchBarSearchButtonClicked(_ text: String?) {
    //    mainView.provideDataSource(viewModel.filterProduct(with: text))
    searchText = text ?? ""
    counter = 0
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
