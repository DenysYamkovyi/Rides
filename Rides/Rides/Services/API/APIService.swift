//
//  APIService.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-10-01.
//

import Combine
import Foundation

protocol APIService {
    func get(endpoint: APIEndpoint, queryParams: [String: String]?) -> AnyPublisher<Data, Error>
}

final class API: APIService {
    private let urlSession: URLSession
    private let baseUrl: URL
    
    init(urlSession: URLSession, baseUrl: URL) {
        self.urlSession = urlSession
        self.baseUrl = baseUrl
    }
    
    func get(endpoint: APIEndpoint, queryParams: [String: String]? = nil) -> AnyPublisher<Data, Error> {
        guard var components = URLComponents(string: baseUrl.absoluteString) else {
            fatalError("Cannot compose URLComponents")
        }
        components.path = endpoint.value

        if let queryParams {
            components.queryItems = queryParams.map { .init(name: $0.key, value: $0.value) }
        }

        guard let url = components.url else { fatalError("Cannot compose URL") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return urlSession.dataTaskPublisher(for: request)
            .tryMap { element -> Data in
                guard let response = element.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                switch response.statusCode {
                case 401:
                    throw URLError(.userAuthenticationRequired)
                case 200...299:
                    return element.data
                default:
                    throw URLError(.badServerResponse)
                }
            }
            .eraseToAnyPublisher()
    }
}
