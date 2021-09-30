//
//  BaseView.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 30/09/2021.
//

import UIKit

class BaseView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  @available (*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

