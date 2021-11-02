//
//  NetworkService.swift
//  Demo Real Estate App
//
//  Created by MacBookAir on 03/10/2021.
//

import Foundation
import Combine
import UIKit

class NetworkService <T: NetworkTarget> {
}

var observer: AnyCancellable?

// MARK: - Public
extension NetworkService {
  /// Makes a request for a Decodable Response
  /// - Parameters:
  ///   - target: TargetType to be targeted
  ///   - completion: Result with Success(Expected Decodable Object Type)
  func request(target: T, completion: @escaping (Result<[Product], NetworkError>) -> Void) {
    let request = self.prepareRequest(from: target)

    observer = fetchProductsViaCombine(request: request)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { _ in }, receiveValue: { model in
        completion(.success(model))
      })
  }

  func fetchProductsViaCombine(request: URLRequest) -> AnyPublisher<[Product], Error> {
    var dataTask: URLSessionDataTask?

    let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
    let onCancel: () -> Void = { dataTask?.cancel() }

    return Future<[Product], Error> { promise in
      let urlRequest = request
      dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
        guard let data = data else {
          if error != nil {
            promise(.failure(NetworkError.unknown))
          }
          return
        }
        do {
          let model = try JSONDecoder().decode([Product].self, from: data)
          promise(.success(model))
        } catch {
          promise(.failure(NetworkError.decodingError(error)))
        }
      }
    }
    .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
    .eraseToAnyPublisher()
  }
}

// MARK: - Private
private extension NetworkService {
  /// Prepares request  from TargetType
  /// - Parameter target: TargetType to be prepared
  /// - Returns: Prepared Request
  func prepareRequest(from target: T) -> URLRequest {
    var request: URLRequest!
    let pathAppended = target.baseURL.appendingPathComponent(target.path)
    switch target.workType {
    case .requestPlain:
      request = URLRequest(url: pathAppended)
    case let .requestWithUrlParameters(parameters):
      let queryGeneratedURL = pathAppended.generateUrlWithQuery(with: parameters)
      request = URLRequest(url: queryGeneratedURL)
    case let .requestWithBodyParameters(parameters):
      let data = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
      request = URLRequest(url: pathAppended)
      request.httpBody = data
    }
    request.httpMethod = target.methodType.rawValue
    request.addValue(target.methodType.rawValue, forHTTPHeaderField: "Content-Type")
    request.addValue(target.accessKey, forHTTPHeaderField: "Access-Key")
    return request
  }
}
