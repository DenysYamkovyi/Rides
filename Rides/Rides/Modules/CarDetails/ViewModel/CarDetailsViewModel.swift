//
//  CarDetailsViewModel.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-10-01.
//

import Combine
import Factory
import Foundation

struct CarDetailsViewModel: CarDetailsViewViewModel {
    let vin: String
    let make: String
    let color: String
    let type: String
    
    init(car: Car) {
        self.vin = car.vin
        self.make = car.make
        self.color = car.color
        self.type = car.type
    }
}


