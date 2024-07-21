//
//  ProductDecoder.swift
//  Demo Real Estate App
//
//  Created by Hasan on 30/06/2024.
//

import Foundation
import SwiftSoup

protocol ProductDecoderDelegate: AnyObject {
  func didFinishDecoding()
}

class ProductDecoder {

  weak var delegate: ProductDecoderDelegate?

  let queue = DispatchQueue.global(qos: .userInitiated)
  let group = DispatchGroup()

  var counter = 0 {
    didSet {
//      if counter >= stores.count {
      if counter >= 2 {
        delegate?.didFinishDecoding()
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
    do {
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
        let title = productTitle
        let deal = tag
        let numberOfBathroom = "" // Replace with actual property if available in product
        let size = "" // Replace with actual property if available in product
        let unit = pricePerUnitF
        let cellModel = ProductTableViewCellModel(
          imageUrl: productImageUrl,
          price: priceFormatted,
          productName: title,
          promotion: deal,
          numberOfBathroom: numberOfBathroom,
          size: size,
          unitCount: unit,
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

  func decodeKruidvat(html: String) {
    do {
      let document = try SwiftSoup.parse(html)
      let productListCols = try document.select(".product__list-col")

      for productListCol in productListCols {
        let impressionTrackers = try productListCol.select("e2-impression-tracker")

        for tracker in impressionTrackers {

          // Extracting the image src
          let imageElement = try tracker.select("img.tile__product-slide-image").first()
          let imageSrc = try imageElement!.attr("src")

          // Extracting the link href
          let linkElement = try tracker.select("a.ClickSearchResultEvent_Class.tile__product-slide-link").first()
          let linkHref = try linkElement!.attr("href")

          let className = try tracker.attr("class")
          let viewHandler = try tracker.attr("view-handler")
          let dataType = try tracker.attr("data-type")
          let dataCurrency = try tracker.attr("data-currency")
          let dataItemName = try tracker.attr("data-item-name")
          let dataCode = try tracker.attr("data-code")
          let dataPrice = try tracker.attr("data-price")

          let cellModel = ProductTableViewCellModel(
            imageUrl: URL(string: "https://www.kruidvat.nl/\(imageSrc)"),
            price: "€\(dataPrice)",
            productName: className,
            promotion: "1",
            numberOfBathroom: "",
            size: dataCurrency,
            unitCount: dataType,
            logo: StoreImageHelper.logoKruidvat
          )

          gDataSource.append(cellModel)
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
        let name = product.title
        let smartLabel = product.smartLabel?.text ?? ""
        let promotion = (product.shield?.text ?? "") + " " + smartLabel
        let numberOfBathroom = "" // Replace with actual property if available in product
        let size = "" // Replace with actual property if available in product
        let unit = product.price?.unitSize ?? ""

        let cellModel = ProductTableViewCellModel(
          imageUrl: imageUrl,
          price: price,
          productName: name,
          promotion: promotion,
          numberOfBathroom: numberOfBathroom,
          size: size,
          unitCount: unit,
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
