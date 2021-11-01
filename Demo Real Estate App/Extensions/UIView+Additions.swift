//
//  UIView+Additions.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 04/10/2021.
//

import UIKit

extension UIView {

  /// sets translatesAutoresizingMaskIntoConstraints to ´False´ and calls ´addSubview´
  func addSubviewVC(_ view: UIView) {
    view.translatesAutoresizingMaskIntoConstraints = false
    addSubview(view)
  }
}
