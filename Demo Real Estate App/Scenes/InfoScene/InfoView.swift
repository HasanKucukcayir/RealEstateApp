//
//  InfoView.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 10/10/2021.
//

import UIKit

protocol InfoViewDelegate: UIViewController {
  func companyWebsiteButtonClicked(_ text: String?)
}

final class InfoView: BaseView {
  private var topHeaderLabel: UILabel!
  private var descriptionLabel: UILabel!
  private var secondHeaderLabel: UILabel!
  private var companyLogoImageView: UIImageView!
  private var companyNameLabel: UILabel!
  private var companyWebsiteButton: UIButton!
  private var scrollView: UIScrollView!
  private var stackView: UIStackView!
  private var containerView: UIView!
  weak var delegate: InfoViewDelegate?

  private enum ViewTraits {
    static let defaultPadding: CGFloat = 24
    static let contentPadding: CGFloat = 14
    static let smallPadding: CGFloat = 8
    static let headerHeight: CGFloat = 44
    static let companyImageHeight: CGFloat = 100
    static let companyWebSiteButtonHeight: CGFloat = 20
    static let companyImageViewWidthMultiplier: CGFloat = 0.33
  }

  override init(frame: CGRect) {
    super .init(frame: frame)
    setupUIComponents()
    addSubviews()
    setupConstraints()
  }
}

// MARK: - Private
private extension InfoView {

  func setupUIComponents() {
    backgroundColor = ColorHelper.lightGray
    setupTopHeaderLabel()
    setupDescriptionLabel()
    setupSecondHeaderLabel()
    setupContainerView()
    setupCompanyLogoImageView()
    setupCompanyNameLabel()
    setupCompanyWebsiteButton()
    setupScrollView()
    setupStackView()
  }

  func setupScrollView() {
    scrollView = UIScrollView()
  }

  func setupStackView() {
    stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = ViewTraits.contentPadding
  }

  func setupTopHeaderLabel () {
    topHeaderLabel = UILabel()
    topHeaderLabel.text = localizedString(forKey: Constants.LocalizedStrings.topHeaderLabelText)
    topHeaderLabel.textColor = ColorHelper.strong
    topHeaderLabel.font = UIFont(name: FontHelper.bold, size: 18)
  }

  func setupDescriptionLabel () {
    descriptionLabel = UILabel()
    descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    descriptionLabel.textColor = ColorHelper.medium
    descriptionLabel.numberOfLines = 0
    descriptionLabel.font = UIFont(name: FontHelper.book, size: 12)
  }

  func setupSecondHeaderLabel () {
    secondHeaderLabel = UILabel()
    secondHeaderLabel.text = localizedString(forKey: Constants.LocalizedStrings.secondHeaderLabelText)
    secondHeaderLabel.textColor = ColorHelper.strong
    secondHeaderLabel.font = UIFont(name: FontHelper.bold, size: 18)
  }

  func setupContainerView() {
    containerView = UIView()
    containerView.backgroundColor = ColorHelper.lightGray
  }

  func setupCompanyLogoImageView () {
    companyLogoImageView = UIImageView()
    companyLogoImageView.contentMode = .scaleAspectFit
    companyLogoImageView.image = AssetHelper.githubLogo
  }

  func setupCompanyNameLabel () {
    companyNameLabel = UILabel()
    companyNameLabel.text = localizedString(forKey: Constants.LocalizedStrings.companyNameLabelText)
    companyNameLabel.textColor = ColorHelper.strong
    companyNameLabel.font = UIFont(name: FontHelper.book, size: 12)
  }

  func setupCompanyWebsiteButton () {
    companyWebsiteButton = UIButton()
    companyWebsiteButton.setTitle(Constants.companyWebsiteText, for: .normal)
    companyWebsiteButton.setTitleColor(.systemBlue, for: .normal)
    companyWebsiteButton.titleLabel?.font = UIFont(name: FontHelper.book, size: 12)
    companyWebsiteButton.addTarget(self, action: #selector(didPressCompanyWebSiteButton), for: .touchUpInside)
  }

}

// MARK: - Constraints
private extension InfoView {

  func addSubviews() {
    addSubviewVC(scrollView)

    scrollView.addSubviewVC(stackView)

    containerView.addSubviewVC(companyLogoImageView)
    containerView.addSubviewVC(companyNameLabel)
    containerView.addSubviewVC(companyWebsiteButton)

    stackView.addArrangedSubview(topHeaderLabel)
    stackView.addArrangedSubview(descriptionLabel)
    stackView.addArrangedSubview(secondHeaderLabel)
    stackView.addArrangedSubview(containerView)
  }

  func setupConstraints() {
    NSLayoutConstraint.activate([
      topHeaderLabel.heightAnchor.constraint(equalToConstant: ViewTraits.headerHeight),

      secondHeaderLabel.heightAnchor.constraint(equalToConstant: ViewTraits.headerHeight),

      companyLogoImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
      companyLogoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      companyLogoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: ViewTraits.companyImageViewWidthMultiplier),

      containerView.heightAnchor.constraint(equalTo: companyLogoImageView.heightAnchor),

      companyNameLabel.leadingAnchor.constraint(equalTo: companyLogoImageView.trailingAnchor, constant: ViewTraits.defaultPadding),
      companyNameLabel.bottomAnchor.constraint(equalTo: companyLogoImageView.centerYAnchor),

      companyWebsiteButton.leadingAnchor.constraint(equalTo: companyLogoImageView.trailingAnchor, constant: ViewTraits.defaultPadding),
      companyWebsiteButton.topAnchor.constraint(equalTo: companyLogoImageView.centerYAnchor),
      companyWebsiteButton.heightAnchor.constraint(equalToConstant: ViewTraits.companyWebSiteButtonHeight),

      scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -ViewTraits.defaultPadding),
      scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: ViewTraits.defaultPadding),
      scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -ViewTraits.defaultPadding),

      stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),

      stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    ])
  }

}

@objc private extension InfoView {
  func didPressCompanyWebSiteButton(_ sender: UIButton) {
    delegate?.companyWebsiteButtonClicked(Constants.companyWebsiteUrl)
  }
}
