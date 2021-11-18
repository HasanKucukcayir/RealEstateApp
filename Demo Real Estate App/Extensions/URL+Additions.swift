//
//  URL+Additions.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 03/10/2021.
//

import Foundation

extension URL {
    func generateUrlWithQuery(with parameters: [String: Any]) -> URL {
        var quearyItems: [URLQueryItem] = []
        for parameter in parameters {
            quearyItems.append(URLQueryItem(name: parameter.key, value: parameter.value as? String))
        }
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = quearyItems
        guard let url = urlComponents.url else { fatalError("Wrong URL Provided") }
        return url
    }
}
