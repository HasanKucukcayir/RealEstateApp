//
//  EmptyResultView.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 16/10/2021.
//

import UIKit

final class EmptyResultView: BaseView {
  private var emptyResultImageView: UIImageView!
  private var emptyResultLabel: UILabel!

  private enum ViewTraits {
    static let defaultPadding: CGFloat = 60
    static let contentPadding: CGFloat = 15
    static let emptyResultImageViewWidthMultiplier: CGFloat = 0.64
  }

  override init(frame: CGRect) {
    super .init(frame: frame)
    setupUIComponents()
    addSubviews()
    setupConstraints()
  }
}

// MARK: - Private
private extension EmptyResultView {

  func setupUIComponents() {
    backgroundColor = ColorHelper.lightGray
    setupEmptyResultImageView()
    setupEmptyResultLabel()
  }

  func setupEmptyResultImageView() {
    emptyResultImageView = UIImageView()
    emptyResultImageView.contentMode = .scaleAspectFit
    emptyResultImageView.image = AssetHelper.emptyResultImage
  }

  func setupEmptyResultLabel() {
    emptyResultLabel = UILabel()
    emptyResultLabel.text = """
    \(localizedString(forKey: Constants.LocalizedStrings.emptyResultLabelTextRow1))
    \(localizedString(forKey: Constants.LocalizedStrings.emptyResultLabelTextRow2))
    """
    emptyResultLabel.numberOfLines = 0
    emptyResultLabel.textColor = ColorHelper.medium
    emptyResultLabel.textAlignment = .center
    emptyResultLabel.font = UIFont(name: FontHelper.book, size: 14)
  }

}

// MARK: - Constraints
private extension EmptyResultView {

  func addSubviews() {
    addSubviewVC(emptyResultImageView)
    addSubviewVC(emptyResultLabel)
  }

  func setupConstraints() {
    NSLayoutConstraint.activate([
      emptyResultImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      emptyResultImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -25.0),
      emptyResultImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: ViewTraits.emptyResultImageViewWidthMultiplier),

      emptyResultLabel.topAnchor.constraint(equalTo: emptyResultImageView.bottomAnchor, constant: ViewTraits.contentPadding),
      emptyResultLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: ViewTraits.defaultPadding),
      emptyResultLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -ViewTraits.defaultPadding)

    ])
  }

}
