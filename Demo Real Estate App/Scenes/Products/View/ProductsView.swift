//
//  ProductsView.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 05/10/2021.
//

import UIKit

protocol ProductsViewDelegate: UIViewController {
  func searchBarSearchButtonClicked(_ text:String?)
  func searchBarCancelButtonClicked()
  func didSelectItem(at indexPath:IndexPath)
}

final class ProductsView: BaseView {
  private var searchBar: UISearchBar!
  private var tableView: UITableView!
  private var dataSource: [ProductTableViewCellModel] = []
  weak var delegate: ProductsViewDelegate?
  
  private enum ViewTraits {
    static let searchBarHeight: CGFloat = 44
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUIComponents()
    addSubviews()
    setupConstraints()
  }
}

// MARK: - Public
extension ProductsView {
  
  func provideDataSource(_ dataSource: [ProductTableViewCellModel]) {
    self.dataSource = dataSource
    tableView.reloadData()
  }
}

// MARK: - UITableViewDataSource
extension ProductsView: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    dataSource.count
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
}

// MARK: - Private
private extension ProductsView {
  
  func setupUIComponents() {
    backgroundColor = ColorHelper.white
    setupSearchBar()
    setupTableView()
  }
  
  func setupSearchBar() {
    searchBar = UISearchBar()
    searchBar.backgroundColor = .clear
    searchBar.showsCancelButton = true
    searchBar.delegate = self
  }
  
  func setupTableView() {
    tableView = UITableView()
    tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.separatorStyle = .none
  }
}

// MARK: - Constraints
private extension ProductsView {
  
  func addSubviews() {
    addSubviewVC(searchBar)
    addSubviewVC(tableView)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      searchBar.heightAnchor.constraint(equalToConstant: ViewTraits.searchBarHeight),
      
      tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}
