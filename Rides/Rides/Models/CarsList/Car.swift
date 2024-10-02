//
//  Car.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-10-01.
//

import Foundation

struct Car: Decodable, Identifiable, Hashable {
    let id: Int
    let vin: String
    let make: String
    let color: String
    let kilometrage: Int
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id, vin, color, kilometrage
        case make = "make_and_model"
        case type = "car_type"
    }
}
