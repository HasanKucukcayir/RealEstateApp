// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let aHListModel = try? JSONDecoder().decode(AHListModel.self, from: jsonData)

import Foundation

// MARK: - AHListModel
struct AHListModel: Codable {
    let common: Common?
    let alternatives: AHListModelAlternatives?
    let analytics: Analytics?
    let autocompleteProducts: AutocompleteProducts?
    let content: Content?
    let crossSells: CrossSells?
    let fakedoor: Fakedoor?
    let product: AHListModelProduct?
    let productRecommendations: ProductRecommendations?
    let recipe: Recipe?
    let search: Search?
    let superShops: SuperShops?
    let taxonomy: AHListModelTaxonomy?
    let uiState: UIState?
    let router: AHListModelRouter?
    let locale: String?
}

// MARK: - AHListModelAlternatives
struct AHListModelAlternatives: Codable {
    let state: String?
    let alternatives: [JSONAny]?
    let productID: Int?
    let dataLakeModel: DataLakeModel?
    let data: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case state, alternatives
        case productID = "productId"
        case dataLakeModel, data
    }
}

// MARK: - DataLakeModel
struct DataLakeModel: Codable {
    let name, version: String?
}

// MARK: - Analytics
struct Analytics: Codable {
    let filters: [JSONAny]?
    let latestUISearchInteraction: String?
}

// MARK: - AutocompleteProducts
struct AutocompleteProducts: Codable {
    let suggestions: [JSONAny]?
    let state: String?
    let timestamp: Int?
}

// MARK: - Common
struct Common: Codable {
    let ui: UI?
    let alternatives: AHListModelAlternatives?
    let basket: Basket?
    let member: Member?
    let notifications: Notifications?
    let globalSearch: GlobalSearch?
    let customHeaders: CustomHeaders?
    let server: Server?
    let productCard: ProductCard?
    let router: CommonRouter?
}

// MARK: - Basket
struct Basket: Codable {
    let products: [JSONAny]?
    let state: String?
    let summary: Summary?
    let list: [JSONAny]?
}

// MARK: - Summary
struct Summary: Codable {
    let quantity: Int?
}

// MARK: - CustomHeaders
struct CustomHeaders: Codable {
}

// MARK: - GlobalSearch
struct GlobalSearch: Codable {
    let suggestions: [JSONAny]?
    let state: String?
}

// MARK: - Member
struct Member: Codable {
    let state: String?
    let data: JSONNull?
    let memberStatus: String?
}

// MARK: - Notifications
struct Notifications: Codable {
    let state: String?
    let data: [JSONAny]?
}

// MARK: - ProductCard
struct ProductCard: Codable {
    let favorites: Favorites?
}

// MARK: - Favorites
struct Favorites: Codable {
    let state: String?
    let lists: [JSONAny]?
    let activeList: ActiveList?
}

// MARK: - ActiveList
struct ActiveList: Codable {
    let state: String?
}

// MARK: - CommonRouter
struct CommonRouter: Codable {
    let location: PurpleLocation?
}

// MARK: - PurpleLocation
struct PurpleLocation: Codable {
    let pathname: String?
}

// MARK: - Server
struct Server: Codable {
    let shouldNavigateTo: JSONNull?
}

// MARK: - UI
struct UI: Codable {
    let alternativesPanel: AlternativesPanel?
    let navigation: Navigation?
    let viewport: Viewport?
}

// MARK: - AlternativesPanel
struct AlternativesPanel: Codable {
    let isOpen, isLoading: Bool?
}

// MARK: - Navigation
struct Navigation: Codable {
    let personalMenuOpen, mainMenuOpen, searchIsOpen: Bool?
}

// MARK: - Viewport
struct Viewport: Codable {
    let mobileWebView, phone, tablet, desktop: Bool?
}

// MARK: - Content
struct Content: Codable {
    let state: String?
    let pages: Pages?
    let partials: Partials?
    let contentJSON: JSON?
    let preview: Bool?
    let documents: CustomHeaders?

    enum CodingKeys: String, CodingKey {
        case state, pages, partials
        case contentJSON = "json"
        case preview, documents
    }
}

// MARK: - JSON
struct JSON: Codable {
    let current: JSONNull?
    let state: String?
    let data: CustomHeaders?
}

// MARK: - Pages
struct Pages: Codable {
    let current: JSONNull?
    let state: String?
    let data, components: CustomHeaders?
    let error: JSONNull?
}

// MARK: - Partials
struct Partials: Codable {
    let state: String?
    let data: CustomHeaders?
}

// MARK: - CrossSells
struct CrossSells: Codable {
    let count: Int?
    let productID: JSONNull?
    let fetchProducts: Bool?

    enum CodingKeys: String, CodingKey {
        case count
        case productID = "productId"
        case fetchProducts
    }
}

// MARK: - Fakedoor
struct Fakedoor: Codable {
    let state: String?
    let invalidProductIDS: [JSONAny]?
    let popup: Popup?

    enum CodingKeys: String, CodingKey {
        case state
        case invalidProductIDS = "invalidProductIds"
        case popup
    }
}

// MARK: - Popup
struct Popup: Codable {
    let popupOpen: Bool?
    let card, freeProduct: JSONNull?

    enum CodingKeys: String, CodingKey {
        case popupOpen = "open"
        case card, freeProduct
    }
}

// MARK: - AHListModelProduct
struct AHListModelProduct: Codable {
    let state: String?
    let invalidProductIDS: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case state
        case invalidProductIDS = "invalidProductIds"
    }
}

// MARK: - ProductRecommendations
struct ProductRecommendations: Codable {
    let dataLake: DataLake?
    let productService, similarProducts: ProductService?
}

// MARK: - DataLake
struct DataLake: Codable {
    let state: String?
    let cards: [JSONAny]?
    let dataLakeModel: DataLakeModel?
    let title: JSONNull?
}

// MARK: - ProductService
struct ProductService: Codable {
    let state: String?
    let cards: [JSONAny]?
}

// MARK: - Recipe
struct Recipe: Codable {
    let state: String?
    let recipes: [JSONAny]?
}

// MARK: - AHListModelRouter
struct AHListModelRouter: Codable {
    let location: FluffyLocation?
    let action: String?
}

// MARK: - FluffyLocation
struct FluffyLocation: Codable {
    let pathname, search, hash: String?
    let state: JSONNull?
    let key: String?
    let query: Query?
}

// MARK: - Query
struct Query: Codable {
    let query: String?
}

// MARK: - Search
struct Search: Codable {
    let state, currentQuery: String?
    let timestamp: Int?
    let results: [Result]?
    let filters: SearchFilters?
    let page: Page?
    let taxonomies, querySuggestions: [JSONAny]?
    let suggestions: JSONNull?
}

// MARK: - SearchFilters
struct SearchFilters: Codable {
    let properties, brands: [Brand]?
    let taxonomies: [FiltersTaxonomy]?
    let prices: [PriceElement]?
}

// MARK: - Brand
struct Brand: Codable {
    let name: BrandEnum?
    let count: Int?
    let id, label: String?
    let attributes: Attributes?
}

// MARK: - Attributes
struct Attributes: Codable {
    let icon: Icon?
}

enum Icon: String, Codable {
    case diepvries = "diepvries"
    case vega = "vega"
    case veganColor = "vegan-color"
}

enum BrandEnum: String, Codable {
    case magnum = "Magnum"
}

// MARK: - PriceElement
struct PriceElement: Codable {
    let count: Int?
    let min, max: Double?
    let label: String?
}

// MARK: - FiltersTaxonomy
struct FiltersTaxonomy: Codable {
    let count, id: Int?
    let shown: Bool?
    let level: Int?
    let parentIDS: [Int]?
    let rank: Int?
    let relevant: Bool?
    let label: String?

    enum CodingKeys: String, CodingKey {
        case count, id, shown, level
        case parentIDS = "parentIds"
        case rank, relevant, label
    }
}

// MARK: - Page
struct Page: Codable {
    let size, totalElements, totalPages, number: Int?
}

// MARK: - Result
struct Result: Codable {
    let type: TypeEnum?
    let id: Int?
    let products: [ProductElement]?
}

// MARK: - ProductElement
struct ProductElement: Codable {
    let id: Int?
    let control: Control?
    let title, link: String?
    let availableOnline, orderable: Bool?
    let propertyIcons: [PropertyIcon]?
    let images: [Image]?
    let shield: Shield?
    let price: ProductPrice?
    let discount: Discount?
    let itemCatalogID: Int?
    let brand: BrandEnum?
    let category: Category?
    let theme: PriceTheme?
    let hqID: Int?
    let gtins: [Int]?
    let summary, descriptionFull: String?
    let taxonomyID: Int?
    let taxonomies: [ProductTaxonomy]?
    let properties: Properties?
    let contributionMargin: Int?

    enum CodingKeys: String, CodingKey {
        case id, control, title, link, availableOnline, orderable, propertyIcons, images, shield, price, discount
        case itemCatalogID = "itemCatalogId"
        case brand, category, theme
        case hqID = "hqId"
        case gtins, summary, descriptionFull
        case taxonomyID = "taxonomyId"
        case taxonomies, properties, contributionMargin
    }
}

enum Category: String, Codable {
    case diepvriesRoomHandijs = "Diepvries/Room handijs"
}

// MARK: - Control
struct Control: Codable {
    let theme: ControlTheme?
    let type: TypeEnum?
}

enum ControlTheme: String, Codable {
    case bonus = "bonus"
}

enum TypeEnum: String, Codable {
    case typeDefault = "default"
}

// MARK: - Discount
struct Discount: Codable {
    let bonusType, segmentType: BonusTypeEnum?
    let promotionType: PromotionType?
    let theme: ControlTheme?
    let startDate, endDate: String?
    let tieredOffer: [JSONAny]?
}

enum BonusTypeEnum: String, Codable {
    case ah = "AH"
}

enum PromotionType: String, Codable {
    case national = "NATIONAL"
}

// MARK: - Image
struct Image: Codable {
    let height, width: Int?
    let title: String?
    let url: String?
    let ratio: Ratio?
}

enum Ratio: String, Codable {
    case the11 = "1-1"
}

// MARK: - ProductPrice
struct ProductPrice: Codable {
    let theme: PriceTheme?
    let now: Double?
    let unitSize: UnitSize?
}

enum PriceTheme: String, Codable {
    case ah = "ah"
}

enum UnitSize: String, Codable {
    case the10Stuks = "10 stuks"
    case the6Stuks = "6 stuks"
}

// MARK: - Properties
struct Properties: Codable {
    let lifestyle: [String]?
}

// MARK: - PropertyIcon
struct PropertyIcon: Codable {
    let name: Icon?
    let title: Title?
}

enum Title: String, Codable {
    case diepvries = "Diepvries"
    case vega = "Vega"
    case vegan = "Vegan"
}

// MARK: - Shield
struct Shield: Codable {
    let theme: ControlTheme?
    let text: Text?
}

enum Text: String, Codable {
    case the2EHalvePrijs = "2e Halve Prijs"
}

// MARK: - ProductTaxonomy
struct ProductTaxonomy: Codable {
    let id: Int?
    let name: TaxonomyName?
    let imageSiteTarget: ImageSiteTarget?
    let images: [JSONAny]?
    let shown: Bool?
    let level, sortSequence: Int?
    let parentIDS: [Int]?

    enum CodingKeys: String, CodingKey {
        case id, name, imageSiteTarget, images, shown, level, sortSequence
        case parentIDS = "parentIds"
    }
}

enum ImageSiteTarget: String, Codable {
    case appCatDiepvries = "app_cat_diepvries"
    case appCatIjs = "app_cat_ijs"
}

enum TaxonomyName: String, Codable {
    case diepvries = "Diepvries"
    case iJS = "IJs"
    case roomHandijs = "Room handijs"
}

// MARK: - SuperShops
struct SuperShops: Codable {
    let visibleShops: [JSONAny]?
}

// MARK: - AHListModelTaxonomy
struct AHListModelTaxonomy: Codable {
    let state: String?
    let topLevel, brandTaxonomies, taxonomies, invalidTaxonomies: [JSONAny]?
}

// MARK: - UIState
struct UIState: Codable {
    let filters: UIStateFilters?
    let alternatives: UIStateAlternatives?
}

// MARK: - UIStateAlternatives
struct UIStateAlternatives: Codable {
    let isOpen: Bool?
    let type, productID: Int?

    enum CodingKeys: String, CodingKey {
        case isOpen, type
        case productID = "productId"
    }
}

// MARK: - UIStateFilters
struct UIStateFilters: Codable {
    let isOpen: Bool?
    let selectedFilter: JSONNull?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public func hash(into hasher: inout Hasher) {
            // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
            return nil
    }

    required init?(stringValue: String) {
            key = stringValue
    }

    var intValue: Int? {
            return nil
    }

    var stringValue: String {
            return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
            return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
            let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
            return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if container.decodeNil() {
                    return JSONNull()
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if let value = try? container.decodeNil() {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer() {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
            if let value = try? container.decode(Bool.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Int64.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Double.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(String.self, forKey: key) {
                    return value
            }
            if let value = try? container.decodeNil(forKey: key) {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer(forKey: key) {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
            var arr: [Any] = []
            while !container.isAtEnd {
                    let value = try decode(from: &container)
                    arr.append(value)
            }
            return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
            var dict = [String: Any]()
            for key in container.allKeys {
                    let value = try decode(from: &container, forKey: key)
                    dict[key.stringValue] = value
            }
            return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
            for value in array {
                    if let value = value as? Bool {
                            try container.encode(value)
                    } else if let value = value as? Int64 {
                            try container.encode(value)
                    } else if let value = value as? Double {
                            try container.encode(value)
                    } else if let value = value as? String {
                            try container.encode(value)
                    } else if value is JSONNull {
                            try container.encodeNil()
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer()
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
            for (key, value) in dictionary {
                    let key = JSONCodingKey(stringValue: key)!
                    if let value = value as? Bool {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Int64 {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Double {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? String {
                            try container.encode(value, forKey: key)
                    } else if value is JSONNull {
                            try container.encodeNil(forKey: key)
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer(forKey: key)
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
            if let value = value as? Bool {
                    try container.encode(value)
            } else if let value = value as? Int64 {
                    try container.encode(value)
            } else if let value = value as? Double {
                    try container.encode(value)
            } else if let value = value as? String {
                    try container.encode(value)
            } else if value is JSONNull {
                    try container.encodeNil()
            } else {
                    throw encodingError(forValue: value, codingPath: container.codingPath)
            }
    }

    public required init(from decoder: Decoder) throws {
            if var arrayContainer = try? decoder.unkeyedContainer() {
                    self.value = try JSONAny.decodeArray(from: &arrayContainer)
            } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
                    self.value = try JSONAny.decodeDictionary(from: &container)
            } else {
                    let container = try decoder.singleValueContainer()
                    self.value = try JSONAny.decode(from: container)
            }
    }

    public func encode(to encoder: Encoder) throws {
            if let arr = self.value as? [Any] {
                    var container = encoder.unkeyedContainer()
                    try JSONAny.encode(to: &container, array: arr)
            } else if let dict = self.value as? [String: Any] {
                    var container = encoder.container(keyedBy: JSONCodingKey.self)
                    try JSONAny.encode(to: &container, dictionary: dict)
            } else {
                    var container = encoder.singleValueContainer()
                    try JSONAny.encode(to: &container, value: self.value)
            }
    }
}
