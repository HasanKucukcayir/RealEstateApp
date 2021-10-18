//
//  InfoView.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 10/10/2021.
//

import UIKit

protocol InfoViewDelegate: UIViewController {
  func companyWebsiteButtonClicked(_ text:String?)
}

final class InfoView: BaseView {
  private var topHeaderLabel: UILabel!
  private var descriptionLabel: UILabel!
  private var secondHeaderLabel: UILabel!
  private var companyLogoImageView: UIImageView!
  private var companyNameLabel: UILabel!
  private var companyWebsiteButton: UIButton!
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
    setupCompanyLogoImageView()
    setupCompanyNameLabel()
    setupCompanyWebsiteButton()
  }
  
  func setupTopHeaderLabel () {
    topHeaderLabel = UILabel()
    topHeaderLabel.text = "ABOUT"
    topHeaderLabel.textColor = ColorHelper.strong
    topHeaderLabel.font = UIFont(name: FontHelper.bold, size: 18)
  }

  func setupDescriptionLabel () {
    descriptionLabel = UILabel()
    descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ultrices risus eu sapien ullamcorper pellentesque. Nullam eu elementum lacus. Integer id nisi mauris. Sed blandit hendrerit eros, sed imperdiet odio tempor eget. Pellentesque volutpat lectus ut est lobortis ornare. Etiam tristique vestibulum turpis, eget egestas justo porta sit amet. Nullam massa ligula, fermentum non sagittis ac, sodales eget justo. Sed id turpis rhoncus, rhoncus ipsum eget, facilisis tellus. Aliquam consectetur tincidunt sapien, id feugiat nibh porta eu. Duis porta finibus condimentum. Integer luctus tellus sit amet neque rhoncus porta. Cras lobortis lorem ut ornare facilisis. In hac habitasse platea dictumst. Nunc mattis urna tempus eleifend rhoncus. Ut molestie nec justo ac gravida."
    descriptionLabel.textColor = ColorHelper.medium
    descriptionLabel.numberOfLines = 0
    descriptionLabel.font = UIFont(name: FontHelper.book, size: 12)
  }
  
  func setupSecondHeaderLabel () {
    secondHeaderLabel = UILabel()
    secondHeaderLabel.text = "Design and Development"
    secondHeaderLabel.textColor = ColorHelper.strong
    secondHeaderLabel.font = UIFont(name: FontHelper.bold, size: 18)
  }
  
  func setupCompanyLogoImageView () {
    companyLogoImageView = UIImageView()
    companyLogoImageView.contentMode = .scaleAspectFit
    companyLogoImageView.image = AssetHelper.dttLogo
  }
  
  func setupCompanyNameLabel () {
    companyNameLabel = UILabel()
    companyNameLabel.text = "by DTT"
    companyNameLabel.textColor = ColorHelper.strong
    companyNameLabel.font = UIFont(name: FontHelper.book, size: 12)
  }
  
  func setupCompanyWebsiteButton () {
    companyWebsiteButton = UIButton()
    companyWebsiteButton.setTitle("d-tt.nl", for: .normal)
    companyWebsiteButton.setTitleColor(.systemBlue, for: .normal)
    companyWebsiteButton.titleLabel?.font = UIFont(name: FontHelper.book, size: 12)
    companyWebsiteButton.addTarget(self, action: #selector(didPressCompanyWebSiteButton), for: .touchUpInside)
  }
  
}

// MARK: - Constraints
private extension InfoView {
  
  func addSubviews() {
    addSubviewVC(topHeaderLabel)
    addSubviewVC(descriptionLabel)
    addSubviewVC(secondHeaderLabel)
    addSubviewVC(companyLogoImageView)
    addSubviewVC(companyNameLabel)
    addSubviewVC(companyWebsiteButton)
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      topHeaderLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: ViewTraits.contentPadding),
      topHeaderLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: ViewTraits.defaultPadding),
      topHeaderLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -ViewTraits.defaultPadding),
      topHeaderLabel.heightAnchor.constraint(equalToConstant: ViewTraits.headerHeight),
      
      descriptionLabel.topAnchor.constraint(equalTo: topHeaderLabel.bottomAnchor, constant: ViewTraits.contentPadding),
      descriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: ViewTraits.defaultPadding),
      descriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -ViewTraits.defaultPadding),

      secondHeaderLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: ViewTraits.contentPadding),
      secondHeaderLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: ViewTraits.defaultPadding),
      secondHeaderLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -ViewTraits.defaultPadding),
      secondHeaderLabel.heightAnchor.constraint(equalToConstant: ViewTraits.headerHeight),
      
      companyLogoImageView.topAnchor.constraint(equalTo: secondHeaderLabel.bottomAnchor, constant: ViewTraits.smallPadding),
      companyLogoImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: ViewTraits.defaultPadding),
      companyLogoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: ViewTraits.companyImageViewWidthMultiplier),
      
      companyNameLabel.leadingAnchor.constraint(equalTo: companyLogoImageView.trailingAnchor, constant: ViewTraits.defaultPadding),
      companyNameLabel.bottomAnchor.constraint(equalTo: companyLogoImageView.centerYAnchor),
      
      companyWebsiteButton.leadingAnchor.constraint(equalTo: companyLogoImageView.trailingAnchor, constant: ViewTraits.defaultPadding),
      companyWebsiteButton.topAnchor.constraint(equalTo: companyLogoImageView.centerYAnchor),
      companyWebsiteButton.heightAnchor.constraint(equalToConstant: ViewTraits.companyWebSiteButtonHeight)
      
    ])
  }
  
}

@objc private extension InfoView {
  func didPressCompanyWebSiteButton(_ sender: UIButton) {
    delegate?.companyWebsiteButtonClicked("https://www.d-tt.nl")
  }
}
