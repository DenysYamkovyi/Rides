//
//  CarsListUseCase.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-10-01.
//

import Combine
import Factory
import Foundation

protocol CarsListUseCaseProtocol {
    func fetchCarsList(size: String) -> AnyPublisher<[Car], Error>
}

final class CarsListUseCase: CarsListUseCaseProtocol {
    @Injected(\.apiService) private var apiService
    
    func fetchCarsList(size: String) -> AnyPublisher<[Car], Error> {
        let parameters = CarsListRequest(size: size).toDictionary()
        
        return apiService.get(endpoint: .vehicle, queryParams: parameters)
            .decode(type: [Car].self , decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

private extension CarsListRequest {
    func toDictionary() -> [String: String] {
        var dict = [String: String]()
        
        // Use Mirror to iterate over properties
        let mirror = Mirror(reflecting: self)
        
        for (label, value) in mirror.children {
            if let label = label {
                // Convert the value to String if possible
                if let stringValue = value as? CustomStringConvertible {
                    dict[label] = stringValue.description
                }
            }
        }
        
        return dict
    }
}
