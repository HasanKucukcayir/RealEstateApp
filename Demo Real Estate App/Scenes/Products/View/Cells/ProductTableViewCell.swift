//
//  ProductTableViewCell.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 03/10/2021.
//

import UIKit

final class ProductTableViewCell: UITableViewCell {
  private var containerView: UIView!
  private var productImageView: UIImageView!
  private var priceLabel: UILabel!
  private var addressLabel: UILabel!
  private var bedroomImageView: UIImageView!
  private var bedroomLabel: UILabel!
  private var bathroomImageView: UIImageView!
  private var bathroomLabel: UILabel!
  private var sizeImageView: UIImageView!
  private var sizeLabel: UILabel!
  private var distanceImageView: UIImageView!
  private var distanceLabel: UILabel!
  private var homePropertiesStackView: UIStackView!

  private enum ViewTrait {
    static let containerPadding: CGFloat = 24
    static let defaultPadding: CGFloat = 20
    static let mediumPadding: CGFloat = 18
    static let smallPadding: CGFloat = 8
    static let contentPadding: CGFloat = 8.5
    static let productImageViewWidthMultiplier: CGFloat = 0.22
    static let featureLogosWidthMultiplier: CGFloat = 0.07
    static let featureLabelsWidthMultiplier: CGFloat = 0.06
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUIComponents()
    addSubviews()
    setupConstraints()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Public
extension ProductTableViewCell {
  func prepareCell(with model: ProductTableViewCellModel) {
    if let url = model.imageUrl {
      productImageView.setCachedImage(from: url, placeholder: AssetHelper.productPlaceHolderImage, isTemplate: false)
    }
    priceLabel.text = model.price
    addressLabel.text = model.address
    bedroomImageView.image = model.logo
    bedroomLabel.text = model.numberOfBedroom
    bathroomImageView.image = AssetHelper.bathroomImage
    bathroomLabel.text = model.numberOfBathroom
    sizeImageView.image = AssetHelper.sizeImage
    sizeLabel.text = model.size
    distanceImageView.image = AssetHelper.distanceImage
    distanceLabel.text = model.distance
  }
}

// MARK: - Private
private extension ProductTableViewCell {

  func setupUIComponents() {
    backgroundColor = ColorHelper.lightGray
    selectionStyle = .none
    setupContainerView()
    setupProductImageView()
    setupPriceLabel()
    setupAddressLabel()
    setupBedroomImageView()
    setupBedroomLabel()
    setupBathroomImageView()
    setupBathroomLabel()
    setupSizeImageView()
    setupSizeLabel()
    setupDistanceImageView()
    setupDistanceLabel()
    setupHomePropertiesStackView()
  }

  func setupContainerView() {
    containerView = UIView()
    containerView.backgroundColor = ColorHelper.white
    containerView.layer.cornerRadius = 6
    containerView.clipsToBounds = true
  }

  func setupProductImageView() {
    productImageView = UIImageView()
    productImageView.tintColor = ColorHelper.lightGray
    productImageView.contentMode = .scaleAspectFill
    productImageView.image = AssetHelper.productPlaceHolderImage
    productImageView.clipsToBounds = true
    productImageView.layer.cornerRadius = 8
  }

  func setupPriceLabel () {
    priceLabel = UILabel()
    priceLabel.font = UIFont(name: FontHelper.medium, size: 16)
    priceLabel.textColor = ColorHelper.strong
  }

  func setupAddressLabel () {
    addressLabel = UILabel()
    addressLabel.font = UIFont(name: FontHelper.book, size: 12)
    addressLabel.textColor = ColorHelper.medium
  }

  func setupHomePropertiesStackView() {
    homePropertiesStackView = UIStackView()
    homePropertiesStackView.alignment = .center
    homePropertiesStackView.axis = .horizontal
    homePropertiesStackView.spacing = ViewTrait.smallPadding
  }

  func setupBedroomImageView () {
    bedroomImageView = UIImageView()
    bedroomImageView.tintColor = .clear
    bedroomImageView.contentMode = .scaleAspectFit
//    bedroomImageView.image = AssetHelper.bedroomImage
  }

  func setupBedroomLabel () {
    bedroomLabel = UILabel()
    bedroomLabel.font = UIFont(name: FontHelper.book, size: 10)
    bedroomLabel.textColor = .orange
  }

  func setupBathroomImageView () {
    bathroomImageView = UIImageView()
    bathroomImageView.tintColor = .clear
    bathroomImageView.contentMode = .scaleAspectFit
    bathroomImageView.image = AssetHelper.bathroomImage
  }

  func setupBathroomLabel () {
    bathroomLabel = UILabel()
    bathroomLabel.font = UIFont(name: FontHelper.book, size: 10)
    bathroomLabel.textColor = ColorHelper.medium
  }

  func setupSizeImageView () {
    sizeImageView = UIImageView()
    sizeImageView.tintColor = .clear
    sizeImageView.contentMode = .scaleAspectFit
    sizeImageView.image = AssetHelper.sizeImage
  }

  func setupSizeLabel () {
    sizeLabel = UILabel()
    sizeLabel.font = UIFont(name: FontHelper.book, size: 10)
    sizeLabel.textColor = ColorHelper.medium
  }

  func setupDistanceImageView () {
    distanceImageView = UIImageView()
    distanceImageView.tintColor = .clear
    distanceImageView.contentMode = .scaleAspectFit
    distanceImageView.image = AssetHelper.distanceImage
  }

  func setupDistanceLabel () {
    distanceLabel = UILabel()
    distanceLabel.font = UIFont(name: FontHelper.book, size: 10)
    distanceLabel.textColor = ColorHelper.medium
  }
}

// MARK: - Constraints
private extension ProductTableViewCell {

  func addSubviews() {
    contentView.addSubviewVC(containerView)
    containerView.addSubviewVC(productImageView)
    containerView.addSubviewVC(bedroomLabel)
    containerView.addSubviewVC(priceLabel)
    containerView.addSubviewVC(addressLabel)
    containerView.addSubviewVC(distanceLabel)
    containerView.addSubviewVC(homePropertiesStackView)
    homePropertiesStackView.addArrangedSubview(bedroomImageView)
//    homePropertiesStackView.addArrangedSubview(bedroomLabel)
//    homePropertiesStackView.addArrangedSubview(bathroomImageView)
    homePropertiesStackView.addArrangedSubview(bathroomLabel)
//    homePropertiesStackView.addArrangedSubview(sizeImageView)
    homePropertiesStackView.addArrangedSubview(sizeLabel)
//    homePropertiesStackView.addArrangedSubview(distanceImageView)
//    homePropertiesStackView.addArrangedSubview(distanceLabel)
  }

  func setupConstraints() {
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewTrait.contentPadding),
      containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewTrait.containerPadding),
      containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ViewTrait.containerPadding),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ViewTrait.contentPadding)
    ])
    setupContainerViewConstraints()
  }

  func setupContainerViewConstraints() {
    NSLayoutConstraint.activate([

      productImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: ViewTrait.containerPadding),
      productImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ViewTrait.smallPadding),
      productImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: ViewTrait.productImageViewWidthMultiplier),
      productImageView.heightAnchor.constraint(equalTo: productImageView.widthAnchor),
      productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

      bedroomLabel.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: -16),
      bedroomLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: ViewTrait.mediumPadding),
      bedroomLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewTrait.mediumPadding),

      priceLabel.topAnchor.constraint(equalTo: productImageView.topAnchor),
      priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: ViewTrait.mediumPadding),
      priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewTrait.mediumPadding),

      addressLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
      addressLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: ViewTrait.mediumPadding),
      addressLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewTrait.mediumPadding),

      homePropertiesStackView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: ViewTrait.defaultPadding),
      homePropertiesStackView.bottomAnchor.constraint(equalTo: productImageView.bottomAnchor),
      homePropertiesStackView.heightAnchor.constraint(equalTo: bedroomImageView.widthAnchor),

      bedroomImageView.bottomAnchor.constraint(equalTo: homePropertiesStackView.bottomAnchor),
      bedroomImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: ViewTrait.featureLogosWidthMultiplier),
      bedroomImageView.heightAnchor.constraint(equalTo: bedroomImageView.widthAnchor),

//      bedroomLabel.bottomAnchor.constraint(equalTo: homePropertiesStackView.bottomAnchor),
//      bedroomLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: ViewTrait.featureLabelsWidthMultiplier),

//      bathroomImageView.bottomAnchor.constraint(equalTo: homePropertiesStackView.bottomAnchor),
//      bathroomImageView.widthAnchor.constraint(equalTo: bedroomImageView.widthAnchor),

//      bathroomLabel.bottomAnchor.constraint(equalTo: homePropertiesStackView.bottomAnchor),
//      bathroomLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: ViewTrait.featureLabelsWidthMultiplier),

//      sizeImageView.bottomAnchor.constraint(equalTo: homePropertiesStackView.bottomAnchor),
//      sizeImageView.widthAnchor.constraint(equalTo: bedroomImageView.widthAnchor),

//      sizeLabel.bottomAnchor.constraint(equalTo: homePropertiesStackView.bottomAnchor),
//      sizeLabel.widthAnchor.constraint(equalTo: bathroomLabel.widthAnchor),

//      distanceImageView.bottomAnchor.constraint(equalTo: homePropertiesStackView.bottomAnchor),
//      distanceImageView.widthAnchor.constraint(equalTo: bathroomLabel.widthAnchor),

      distanceLabel.leadingAnchor.constraint(equalTo: bedroomLabel.leadingAnchor),
      distanceLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor)

    ])
  }

}

struct ProductTableViewCellModel {
  let imageUrl: URL?
  let price: String?
  let address: String?
  let numberOfBedroom: String
  let numberOfBathroom: String
  let size: String
  let distance: String
  let logo: UIImage?
}
