//
//  UIImageView+Additions.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 03/10/2021.
//

import UIKit

private let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
  @discardableResult
  func setCachedImage(from url: URL, placeholder: UIImage?, isTemplate: Bool) -> URLSessionDataTask? {
    updateImage(with: placeholder, isTemplate: isTemplate)
    
    guard let image = imageCache.object(forKey: url.absoluteString as NSString) else {
      return downloadImage(from: url, placeholder: placeholder, isTemplate: isTemplate)
    }
    
    updateImage(with: image, isTemplate: isTemplate)
    return nil
  }
}

// MARK: - Private
private extension UIImageView {
  
  func downloadImage(from url: URL, placeholder: UIImage?, isTemplate: Bool) -> URLSessionDataTask? {
    let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
      
      if let error = error as NSError?,
         error.code == NSURLErrorCancelled {
        self.updateImage(with: placeholder, isTemplate: isTemplate)
        return
      }
      
      guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
            let data = data,
            let image = UIImage(data: data) else {
        self.updateImage(with: placeholder, isTemplate: isTemplate)
        return
      }
      
      self.updateImage(with: image, isTemplate: isTemplate)
      imageCache.setObject(image, forKey: url.absoluteString as NSString)
    }
    dataTask.resume()
    return dataTask
  }
  
  func updateImage(with image: UIImage?, isTemplate: Bool) {
    DispatchQueue.main.async {
      self.image = isTemplate ? image?.withRenderingMode(.alwaysTemplate) : image
    }
  }
}

