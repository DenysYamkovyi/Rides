//
//  CarbonEmissionsViewModel.swift
//  Rides
//
//  Created by macbook pro on 2024-10-02.
//

import Combine
import Factory
import Foundation

struct CarbonEmissionsViewModel: CarbonEmissionsViewViewModel {
    let vin: String
    let make: String
    let kilometrage: Int
    
    init(car: Car) {
        self.vin = car.vin
        self.make = car.make
        self.kilometrage = car.kilometrage
    }
}
