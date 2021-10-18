//
//  InfoViewController.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 10/10/2021.
//

import SafariServices

final class InfoViewController: BaseViewController {

  typealias ViewType = InfoView
  
  private let mainView: InfoView
  
  init(view: InfoView) {
    self.mainView = view
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    mainView.delegate = self
    view = mainView
  }
  
}

extension InfoViewController: InfoViewDelegate {
  func companyWebsiteButtonClicked(_ text: String?) {
    DispatchQueue.main.async {
      let webUrl = text
      let safariController = SFSafariViewController(url: URL(string: webUrl!)!)
      self.present(safariController, animated: true, completion: nil)
    }
  }
}
