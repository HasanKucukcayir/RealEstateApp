//
//  ProductsView.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 05/10/2021.
//

import UIKit

protocol ProductsViewDelegate: UIViewController {
  func searchBarSearchButtonClicked(_ text: String?)
  func searchBarCancelButtonClicked()
  func didSelectItem(at indexPath: IndexPath)
  func searchBarDidBeginEditing()
}

final class ProductsView: BaseView {
  private var navigationLabel: UILabel!
  private var searchBar: UISearchBar!
  private var tableView: UITableView!
  private var dataSource: [ProductTableViewCellModel] = []
  private var searchFlag = false
  weak var delegate: ProductsViewDelegate?

  private enum ViewTraits {
    static let searchBarHeight: CGFloat = 44
    static let headerHeight: CGFloat = 44
    static let defaultPadding: CGFloat = 16
    static let contentPadding: CGFloat = 10
    static let navigationPadding: CGFloat = 24
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUIComponents()
    addSubviews()
    setupConstraints()
    arrangeRightView(isSearchActive: false)
  }

}

// MARK: - Public
extension ProductsView {

  func provideDataSource(_ dataSource: [ProductTableViewCellModel]) {
    self.dataSource = dataSource
    searchFlag = true
    tableView.reloadData()
  }
}

// MARK: - UITableViewDataSource
extension ProductsView: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let rowCount = dataSource.count

    if rowCount == 0 && searchFlag {
      tableView.backgroundView?.isHidden = false
    } else {
      tableView.backgroundView?.isHidden = true
    }
    return rowCount
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as? ProductTableViewCell else {
      assertionFailure("Please provide a propper cell")
      return .init()
    }
    let model = dataSource[indexPath.row]
    cell.prepareCell(with: model)
    return cell
  }
}

// MARK: - UITableViewDelegate
extension ProductsView: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.didSelectItem(at: indexPath)
  }
}

extension ProductsView: UISearchBarDelegate {

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    delegate?.searchBarSearchButtonClicked(searchBar.text)
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    delegate?.searchBarCancelButtonClicked()
  }

  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    arrangeRightView(isSearchActive: true)
//    searchBar.text = nil
//    delegate?.searchBarCancelButtonClicked()
  }

  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    arrangeRightView(isSearchActive: false)
  }

}

// MARK: - Private
private extension ProductsView {

  func setupUIComponents() {
    backgroundColor = ColorHelper.lightGray
    setupNavigationBarHeader()
    setupSearchBar()
    setupTableView()
  }

  func setupNavigationBarHeader() {
    navigationLabel = UILabel()
    navigationLabel.text = localizedString(forKey: Constants.LocalizedStrings.navigationText)
    navigationLabel.textColor = ColorHelper.strong
    navigationLabel.font = UIFont(name: FontHelper.bold, size: 18)
  }

  func setupSearchBar() {
    searchBar = UISearchBar()
    searchBar.backgroundColor = .clear
    searchBar.searchTextField.clearButtonMode = .whileEditing
    searchBar.searchTextField.rightViewMode = .unlessEditing
    searchBar.searchBarStyle = .minimal
    searchBar.searchTextField.leftView = nil
    searchBar.searchTextField.font = UIFont(name: FontHelper.light, size: 12)
    searchBar.searchTextField.textColor = ColorHelper.strong
    searchBar.placeholder = localizedString(forKey: Constants.LocalizedStrings.searchBarPlaceholder)
    searchBar.delegate = self
  }

  func setupTableView() {
    tableView = UITableView()
    tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.separatorStyle = .none
    tableView.backgroundColor = ColorHelper.lightGray
    tableView.backgroundView = EmptyResultView()
    tableView.backgroundView?.isHidden = true
  }
}

// MARK: - Constraints
private extension ProductsView {

  func addSubviews() {
    addSubviewVC(navigationLabel)
    addSubviewVC(searchBar)
    addSubviewVC(tableView)
  }

  func setupConstraints() {
    NSLayoutConstraint.activate([
      navigationLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: ViewTraits.contentPadding),
      navigationLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: ViewTraits.navigationPadding),
      navigationLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -ViewTraits.navigationPadding),
      navigationLabel.heightAnchor.constraint(equalToConstant: ViewTraits.headerHeight),

      searchBar.topAnchor.constraint(equalTo: navigationLabel.bottomAnchor, constant: ViewTraits.contentPadding),
      searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: ViewTraits.defaultPadding),
      searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -ViewTraits.defaultPadding),
      searchBar.heightAnchor.constraint(equalToConstant: ViewTraits.searchBarHeight),

      tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: ViewTraits.contentPadding),
      tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

// MARK: - SearchBar rightView Events
private extension ProductsView {

  func arrangeRightView(isSearchActive: Bool) {
    DispatchQueue.main.async { [self] in
      searchBar.showsBookmarkButton = true
      if isSearchActive {
        if let rightButtonActive = searchBar.searchTextField.rightView as? UIButton {
          rightButtonActive.addTarget(self, action: #selector(didPressRightButton), for: .touchUpInside)

          rightButtonActive.setImage(AssetHelper.closeImage, for: .normal)
          rightButtonActive.setImage(AssetHelper.closeImage, for: .highlighted)

          if let clearButton = searchBar.searchTextField.value(forKeyPath: "_clearButton") as? UIButton {
            clearButton.setImage(AssetHelper.closeImage, for: .normal)
            clearButton.addTarget(self, action: #selector(didPressClearButton), for: .touchUpInside)
          }
        }
      } else {
        if let rightButtonPassive = searchBar.searchTextField.rightView as? UIButton {
          rightButtonPassive.setImage(AssetHelper.searchImage, for: .normal)
          rightButtonPassive.setImage(AssetHelper.searchImage, for: .highlighted)
        }
      }
    }
  }

}

@objc private extension ProductsView {
  func didPressClearButton(_ sender: UIButton) {
    searchBar.resignFirstResponder()
    delegate?.searchBarCancelButtonClicked()
  }

  func didPressRightButton(_ sender: UIButton, isSearchActive: Bool) {
    searchBar.resignFirstResponder()
  }
}
