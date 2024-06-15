// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let aHListModel = try? JSONDecoder().decode(AHListModel.self, from: jsonData)

import Foundation

// MARK: - AHListModel
struct AHListModel: Codable {
    let taxonomy: AHListModelTaxonomy?
    let fakedoor: Fakedoor?
    let productRecommendations: ProductRecommendations?
    let recipe: Recipe?
    let router: AHListModelRouter?
    let search: Search?
    let uiState: UIState?
    let content: Content?
    let common: Common?
    let alternatives: AHListModelAlternatives?
    let analytics: Analytics?
    let crossSells: CrossSells?
    let superShops: SuperShops?
    let product: AHListModelProduct?
    let locale: String?
    let autocompleteProducts: AutocompleteProducts?
}

// MARK: - AHListModelAlternatives
struct AHListModelAlternatives: Codable {
    let alternatives: [JSONAny]?
    let state: String?
    let dataLakeModel: DataLakeModel?
    let productID: Int?
    let data: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case alternatives, state, dataLakeModel
        case productID = "productId"
        case data
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
    let state: String?
    let timestamp: Int?
    let suggestions: [JSONAny]?
}

// MARK: - Common
struct Common: Codable {
    let basket: Basket?
    let member: Member?
    let globalSearch: GlobalSearch?
    let customHeaders: CustomHeaders?
    let ui: UI?
    let server: Server?
    let productCard: ProductCard?
    let router: CommonRouter?
    let alternatives: AHListModelAlternatives?
    let notifications: Notifications?
}

// MARK: - Basket
struct Basket: Codable {
    let summary: Summary?
    let state: String?
    let list, products: [JSONAny]?
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
    let state: String?
    let suggestions: [JSONAny]?
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
    let viewport: Viewport?
    let alternativesPanel: AlternativesPanel?
    let navigation: Navigation?
}

// MARK: - AlternativesPanel
struct AlternativesPanel: Codable {
    let isLoading, isOpen: Bool?
}

// MARK: - Navigation
struct Navigation: Codable {
    let searchIsOpen, mainMenuOpen, personalMenuOpen: Bool?
}

// MARK: - Viewport
struct Viewport: Codable {
    let tablet, phone, desktop, mobileWebView: Bool?
}

// MARK: - Content
struct Content: Codable {
    let partials: Partials?
    let pages: Pages?
    let state: String?
    let contentJSON: JSON?
    let preview: Bool?
    let documents: CustomHeaders?

    enum CodingKeys: String, CodingKey {
        case partials, pages, state
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
    let components, data: CustomHeaders?
    let current: JSONNull?
    let state: String?
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
    let fetchProducts: Bool?
    let productID: JSONNull?

    enum CodingKeys: String, CodingKey {
        case count, fetchProducts
        case productID = "productId"
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
    let freeProduct, card: JSONNull?
    let popupOpen: Bool?

    enum CodingKeys: String, CodingKey {
        case freeProduct, card
        case popupOpen = "open"
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
    let productService: ProductService?
    let dataLake: DataLake?
    let similarProducts: ProductService?
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
    let query: Query?
    let search, hash: String?
    let state: JSONNull?
    let key, pathname: String?
}

// MARK: - Query
struct Query: Codable {
    let query: String?
}

// MARK: - Search
struct Search: Codable {
    let suggestions: JSONNull?
    let filters: SearchFilters?
    let currentQuery: String?
    let results: [SearchResult]?
    let taxonomies, querySuggestions: [JSONAny]?
    let timestamp: Int?
    let state: String?
    let page: Page?
}

// MARK: - SearchFilters
struct SearchFilters: Codable {
    let properties, brands: [Brand]?
    let taxonomies: [FiltersTaxonomy]?
    let prices: [PriceElement]?
}

// MARK: - Brand
struct Brand: Codable {
    let id, label: String?
    let count: Int?
    let name: String?
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
    let min: Double?
    let label: String?
    let count: Int?
    let max: Double?
}

// MARK: - FiltersTaxonomy
struct FiltersTaxonomy: Codable {
    let parentIDS: [Int]?
    let shown: Bool?
    let id: Int?
    let relevant: Bool?
    let count, level, rank: Int?
    let label: String?

    enum CodingKeys: String, CodingKey {
        case parentIDS = "parentIds"
        case shown, id, relevant, count, level, rank, label
    }
}

// MARK: - Page
struct Page: Codable {
    let size, totalPages, number, totalElements: Int?
}

// MARK: - SearchResult
struct SearchResult: Codable {
    let type: TypeEnum?
    let id: Int?
    let products: [ProductElement]?
}

// MARK: - ProductElement
struct ProductElement: Codable {
    let title, link: String?
    let gtins: [Int]?
    let summary: String?
    let brand: String?
    let availableOnline: Bool?
    let images: [Image]?
    let propertyIcons: [PropertyIcon]?
    let discount: Discount?
    let category: Category?
    let hqID: Int?
    let descriptionFull: String?
    let taxonomyID: Int?
    let taxonomies: [ProductTaxonomy]?
    let id: Int?
    let control: Control?
    let properties: Properties?
    let shield: Shield?
    let itemCatalogID: Int?
    let theme: PriceTheme?
    let price: ProductPrice?
    let orderable: Bool?
    let contributionMargin: Int?

    enum CodingKeys: String, CodingKey {
        case title, link, gtins, summary, brand, availableOnline, images, propertyIcons, discount, category
        case hqID = "hqId"
        case descriptionFull
        case taxonomyID = "taxonomyId"
        case taxonomies, id, control, properties, shield
        case itemCatalogID = "itemCatalogId"
        case theme, price, orderable, contributionMargin
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
    let bonusType: BonusTypeEnum?
    let endDate, startDate: String?
    let theme: ControlTheme?
    let segmentType: BonusTypeEnum?
    let promotionType: PromotionType?
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
    let ratio: Ratio?
    let title: String?
    let height, width: Int?
    let url: String?
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
    let images: [JSONAny]?
    let parentIDS: [Int]?
    let shown: Bool?
    let id, sortSequence, level: Int?
    let imageSiteTarget: ImageSiteTarget?
    let name: TaxonomyName?

    enum CodingKeys: String, CodingKey {
        case images
        case parentIDS = "parentIds"
        case shown, id, sortSequence, level, imageSiteTarget, name
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
    let topLevel, brandTaxonomies: [JSONAny]?
    let state: String?
    let taxonomies, invalidTaxonomies: [JSONAny]?
}

// MARK: - UIState
struct UIState: Codable {
    let filters: UIStateFilters?
    let alternatives: UIStateAlternatives?
}

// MARK: - UIStateAlternatives
struct UIStateAlternatives: Codable {
    let type, productID: Int?
    let isOpen: Bool?

    enum CodingKeys: String, CodingKey {
        case type
        case productID = "productId"
        case isOpen
    }
}

// MARK: - UIStateFilters
struct UIStateFilters: Codable {
    let selectedFilter: JSONNull?
    let isOpen: Bool?
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
