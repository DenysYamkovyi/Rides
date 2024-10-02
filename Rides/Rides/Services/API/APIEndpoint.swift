//
//  APIEndpoint.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-10-01.
//

import Foundation

enum BrowseContentType: String, Encodable {
    case vehicle
}

enum APIEndpoint {
    case vehicle

    var value: String {
        return switch self {
        case .vehicle:
            "/api/vehicle/random_vehicle"
        }
    }
}
