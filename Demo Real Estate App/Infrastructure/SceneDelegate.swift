//
//  SceneDelegate.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 29/09/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow.init(frame: windowScene.coordinateSpace.bounds)
    self.window?.rootViewController = TabBarController()
    window?.windowScene = windowScene
    window?.makeKeyAndVisible()
  }
}

