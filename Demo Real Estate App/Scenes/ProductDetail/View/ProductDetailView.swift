//
//  ProductDetailView.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 10/10/2021.
//

import UIKit
import MapKit

protocol ProductDetailViewDelegate: UIViewController {
  func didPressBack()
}

final class ProductDetailView: BaseView {
  weak var delegate: ProductDetailViewDelegate?
  
  private var houseImageView: UIImageView!
  private var backButton: UIButton!
  private var containerView: UIView!
  private var priceLabel: UILabel!
  private var bedroomImageView: UIImageView!
  private var bedroomLabel: UILabel!
  private var bathroomImageView: UIImageView!
  private var bathroomLabel: UILabel!
  private var sizeImageView: UIImageView!
  private var sizeLabel: UILabel!
  private var distanceImageView: UIImageView!
  private var distanceLabel: UILabel!
  private var descriptionHeaderLabel: UILabel!
  private var descriptionLabel: UILabel!
  private var locationLabel: UILabel!
  private var mapView: MKMapView!
  //
  private var scrollView: UIScrollView!
  private var stackView: UIStackView!
  
  private enum ViewTraits {
    static let defaultPadding: CGFloat = 24
    static let contentPadding: CGFloat = 14
    static let mediumPadding: CGFloat = 18
    static let smallPadding: CGFloat = 6
    static let headerPadding: CGFloat = 40
    static let backButtonHeight: CGFloat = 15
    static let imageViewWidthMultiplier: CGFloat = 0.3
    static let containerViewRadius: CGFloat = 16
    static let houseImageViewHeight: CGFloat = 250
    static let featureLogosWidthMultiplier: CGFloat = 0.04
    static let mapViewWidthMultiplier: CGFloat = 3/4
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUIComponents()
    addSubviews()
    setupConstraints()
  }
  
}


// MARK: - Selectors
@objc private extension ProductDetailView {
  func didPressBack() {
    delegate?.didPressBack()
  }
}

// MARK: - MKMapViewDelegate
extension ProductDetailView: MKMapViewDelegate {
  
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    guard let annotation = view.annotation
    else {
      return
    }
    
    let urlString = "http://maps.apple.com/?daddr=\(annotation.coordinate.latitude),\(annotation.coordinate.longitude)"
    guard let url = URL(string: urlString) else
    {
      return
    }
    UIApplication.shared.open(url)
  }
  
}

// MARK: - Public
extension ProductDetailView {
  func prepareView(_ model: Product) {
    
    let imageUrl = URL(string: Constants.imageUrl)!.appendingPathComponent(model.imgURL)
    houseImageView.setCachedImage(from: imageUrl, placeholder: AssetHelper.productPlaceHolderImage, isTemplate: false)
    
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    let price = "$\(formatter.string(from: NSNumber(value: model.price))!)"
    priceLabel.text = price
    
    bedroomLabel.text = "\(model.bedrooms)"
    
    bathroomLabel.text = "\(model.bathrooms)"
    
    sizeLabel.text = "\(model.size)"
    
    let distance = calculateDistance(latitude: model.latitude, longitude: model.longitude)
    distanceLabel.text = distance
    
    descriptionLabel.text = model.description
    
    let homeLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(model.latitude), longitude: CLLocationDegrees(model.longitude))
    let homeRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: homeLocation.latitude, longitude: homeLocation.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    self.mapView.setRegion(homeRegion, animated: true)

    // Show home location on map with a pin.
    let homePin = MKPointAnnotation()
    homePin.coordinate = homeLocation
    homePin.title = "Home Location"
    mapView.addAnnotation(homePin)
    mapView.register(HomeAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
  }
}

// MARK: - Private
private extension ProductDetailView {
  func setupUIComponents() {
    backgroundColor = ColorHelper.lightGray
    setupHouseImageView()
    setupBackButton()
    setupContainerView()
    setupPriceLabel()
    setupBedroomImageView()
    setupBedroomLabel()
    setupBathroomImageView()
    setupBathroomLabel()
    setupSizeImageView()
    setupSizeLabel()
    setupDistanceImageView()
    setupDistanceLabel()
    setupDescriptionHeaderLabel()
    setupDescriptionLabel()
    setupLocationLabel()
    setupMapView()
    setupScrollView()
    setupStackView()
  }
  
  func setupHouseImageView() {
    houseImageView = UIImageView()
    houseImageView.tintColor = ColorHelper.lightGray
    houseImageView.contentMode = .scaleAspectFill
    houseImageView.clipsToBounds = true
  }
  
  func setupBackButton() {
    backButton = UIButton()
    backButton.setImage(AssetHelper.backButtonImage, for: .normal)
    backButton.tintColor = .black
    backButton.addTarget(self, action: #selector(didPressBack), for: .touchUpInside)
  }
  
  func setupContainerView() {
    containerView = UIView()
    containerView.backgroundColor = ColorHelper.lightGray
    containerView.layer.cornerRadius = ViewTraits.containerViewRadius
  }

  func setupPriceLabel() {
    priceLabel = UILabel()
    priceLabel.font = UIFont(name: FontHelper.bold , size: 18)
    priceLabel.textColor = ColorHelper.strong
  }
  
  func setupBedroomImageView() {
    bedroomImageView = UIImageView()
    bedroomImageView.tintColor = .clear
    bedroomImageView.contentMode = .scaleAspectFit
    bedroomImageView.image = AssetHelper.bedroomImage
  }
  
  func setupBedroomLabel() {
    bedroomLabel = UILabel()
    bedroomLabel.font = UIFont(name: FontHelper.book , size: 10)
    bedroomLabel.textColor = ColorHelper.medium
  }
  
  func setupBathroomImageView() {
    bathroomImageView = UIImageView()
    bathroomImageView.tintColor = .clear
    bathroomImageView.contentMode = .scaleAspectFit
    bathroomImageView.image = AssetHelper.bathroomImage
  }
  
  func setupBathroomLabel() {
    bathroomLabel = UILabel()
    bathroomLabel.font = UIFont(name: FontHelper.book , size: 10)
    bathroomLabel.textColor = ColorHelper.medium
  }
  
  func setupSizeImageView() {
    sizeImageView = UIImageView()
    sizeImageView.tintColor = .clear
    sizeImageView.contentMode = .scaleAspectFit
    sizeImageView.image = AssetHelper.sizeImage
  }
  
  func setupSizeLabel() {
    sizeLabel = UILabel()
    sizeLabel.font = UIFont(name: FontHelper.book , size: 10)
    sizeLabel.textColor = ColorHelper.medium
  }
  
  func setupDistanceImageView() {
    distanceImageView = UIImageView()
    distanceImageView.tintColor = .clear
    distanceImageView.contentMode = .scaleAspectFit
    distanceImageView.image = AssetHelper.distanceImage
  }
  
  func setupDistanceLabel() {
    distanceLabel = UILabel()
    distanceLabel.font = UIFont(name: FontHelper.book , size: 10)
    distanceLabel.textColor = ColorHelper.medium
  }
  
  func setupDescriptionHeaderLabel() {
    descriptionHeaderLabel = UILabel()
    descriptionHeaderLabel.font = UIFont(name: FontHelper.bold , size: 18)
    descriptionHeaderLabel.textColor = ColorHelper.strong
    descriptionHeaderLabel.text = "Description"
    descriptionHeaderLabel.numberOfLines = 0
  }
  
  func setupDescriptionLabel() {
    descriptionLabel = UILabel()
    descriptionLabel.textColor = ColorHelper.medium
    descriptionLabel.numberOfLines = 0
    descriptionLabel.font = UIFont(name: FontHelper.book, size: 12)
  }
  
  func setupLocationLabel() {
    locationLabel = UILabel()
    locationLabel.font = UIFont(name: FontHelper.bold , size: 18)
    locationLabel.textColor = ColorHelper.strong
    locationLabel.text = "Location"
    locationLabel.numberOfLines = 0
  }
  
  func setupScrollView() {
    scrollView = UIScrollView()
  }
  
  func setupStackView() {
    stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = ViewTraits.defaultPadding
  }
  
  func setupMapView() {
    mapView = MKMapView()
    mapView.delegate = self
  }
 
}

// MARK: - Constraints
private extension ProductDetailView {
  
  func addSubviews() {
    addSubviewVC(houseImageView)
    addSubviewVC(backButton)
    addSubviewVC(containerView)

    containerView.addSubviewVC(priceLabel)
    containerView.addSubviewVC(bedroomImageView)
    containerView.addSubviewVC(bedroomLabel)
    containerView.addSubviewVC(bathroomImageView)
    containerView.addSubviewVC(bathroomLabel)
    containerView.addSubviewVC(sizeImageView)
    containerView.addSubviewVC(sizeLabel)
    containerView.addSubviewVC(distanceImageView)
    containerView.addSubviewVC(distanceLabel)
    containerView.addSubviewVC(scrollView)
    scrollView.addSubviewVC(stackView)
    stackView.addArrangedSubview(descriptionHeaderLabel)
    stackView.addArrangedSubview(descriptionLabel)
    stackView.addArrangedSubview(locationLabel)
    stackView.addArrangedSubview(mapView)
    
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      houseImageView.topAnchor.constraint(equalTo: self.topAnchor),
      houseImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      houseImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      houseImageView.heightAnchor.constraint(equalToConstant: ViewTraits.houseImageViewHeight),
      
      backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: ViewTraits.contentPadding),
      backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: ViewTraits.defaultPadding),
      
      containerView.topAnchor.constraint(equalTo: houseImageView.bottomAnchor, constant: -ViewTraits.containerViewRadius),
      containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      containerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      
    ])
    
    setupContainerViewConstraints()
  }
  
  func setupContainerViewConstraints() {
    NSLayoutConstraint.activate([
          
      priceLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: ViewTraits.headerPadding),
      priceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ViewTraits.defaultPadding),
      
      distanceLabel.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor),
      distanceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewTraits.defaultPadding),
      
      distanceImageView.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor),
      distanceImageView.trailingAnchor.constraint(equalTo: distanceLabel.leadingAnchor, constant: -ViewTraits.smallPadding),
      distanceImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: ViewTraits.featureLogosWidthMultiplier),
      distanceImageView.heightAnchor.constraint(equalTo: distanceImageView.widthAnchor),
      
      sizeLabel.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor),
      sizeLabel.trailingAnchor.constraint(equalTo: distanceImageView.leadingAnchor, constant: -ViewTraits.mediumPadding),
      
      sizeImageView.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor),
      sizeImageView.trailingAnchor.constraint(equalTo: sizeLabel.leadingAnchor, constant: -ViewTraits.smallPadding),
      sizeImageView.widthAnchor.constraint(equalTo: distanceImageView.widthAnchor),
      sizeImageView.heightAnchor.constraint(equalTo: sizeImageView.widthAnchor),
      
      bathroomLabel.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor),
      bathroomLabel.trailingAnchor.constraint(equalTo: sizeImageView.leadingAnchor, constant: -ViewTraits.mediumPadding),
      
      bathroomImageView.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor),
      bathroomImageView.trailingAnchor.constraint(equalTo: bathroomLabel.leadingAnchor, constant: -ViewTraits.smallPadding),
      bathroomImageView.widthAnchor.constraint(equalTo: distanceImageView.widthAnchor),
      bathroomImageView.heightAnchor.constraint(equalTo: bathroomImageView.widthAnchor),

      bedroomLabel.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor),
      bedroomLabel.trailingAnchor.constraint(equalTo: bathroomImageView.leadingAnchor, constant: -ViewTraits.mediumPadding),
      
      bedroomImageView.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor),
      bedroomImageView.trailingAnchor.constraint(equalTo: bedroomLabel.leadingAnchor, constant: -ViewTraits.smallPadding),
      bedroomImageView.widthAnchor.constraint(equalTo: distanceImageView.widthAnchor),
      bedroomImageView.heightAnchor.constraint(equalTo: bedroomImageView.widthAnchor),
      
      scrollView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: ViewTraits.defaultPadding),
      scrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -ViewTraits.defaultPadding),
      scrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ViewTraits.defaultPadding),
      scrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ViewTraits.defaultPadding),
      
      stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      
      stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      
      mapView.widthAnchor.constraint(equalTo: descriptionLabel.widthAnchor),
      mapView.heightAnchor.constraint(equalTo: mapView.widthAnchor, multiplier: ViewTraits.mapViewWidthMultiplier)
    ])
  }
  
}
