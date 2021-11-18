//
//  TabBarController.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 10/10/2021.
//

import UIKit

class TabBarController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()

    UITabBar.appearance().tintColor = ColorHelper.strong
    UITabBar.appearance().backgroundColor = ColorHelper.white
    UITabBar.appearance().unselectedItemTintColor = ColorHelper.light

    setupVCs()
  }

  func setupVCs() {
    viewControllers = [
      createNavController(for: ProductsViewController(view: ProductsView(), viewModel: ProductsViewModel(productAPIService: ProductApiService())), title: "", image: AssetHelper.homeImage!),
      createNavController(for: InfoViewController(view: InfoView()), title: "", image: AssetHelper.infoImage!)
    ]
  }

  fileprivate func createNavController(for rootViewController: UIViewController,
                                       title: String,
                                       image: UIImage) -> UIViewController {
    let navController = UINavigationController(rootViewController: rootViewController)
    navController.tabBarItem.title = title
    navController.tabBarItem.image = image
    rootViewController.navigationItem.title = title
    return navController
  }
}
