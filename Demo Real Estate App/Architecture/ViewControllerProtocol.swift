//
//  ViewControllerProtocol.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 30/09/2021.
//

import UIKit

protocol ViewControllerProtocol: UIViewController {
  associatedtype ViewType: BaseView
  associatedtype ViewModelType: ViewModel
  
  init (view: ViewType, viewModel: ViewModelType)
}
