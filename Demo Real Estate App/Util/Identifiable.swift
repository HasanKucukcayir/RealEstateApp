//
//  Identifiable.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 05/10/2021.
//

import UIKit

protocol Identifiable {
  static var identifier: String { get }
}

extension Identifiable {
  static var identifier: String {
    String(describing: Self.self)
  }
}

extension UITableViewCell: Identifiable { }
