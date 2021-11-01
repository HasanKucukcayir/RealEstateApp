//
//  BaseViewController.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 30/09/2021.
//

import UIKit

class BaseViewController: UIViewController {
  var isNavigationBarHiddden: Bool = true

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(isNavigationBarHiddden, animated: true)
  }
}
