//
//  CarbonEmissionsTests.swift
//  RidesTests
//
//  Created by macbook pro on 2024-10-02.
//

import XCTest
@testable import Rides

class CarbonEmissionsTests: XCTestCase {

    func testEmissionsForKilometrageBelowThreshold() {
        let emissions = calculateEmissions(for: 3000)
        XCTAssertEqual(emissions, "3000.00", "Emissions should be equal to the kilometrage when below 5000 km.")
    }
    
    func testEmissionsForKilometrageAtThreshold() {
        let emissions = calculateEmissions(for: 5000)
        XCTAssertEqual(emissions, "5000.00", "Emissions should be exactly 5000 g/km for 5000 km.")
    }
    
    func testEmissionsForKilometrageAboveThreshold() {
        let emissions = calculateEmissions(for: 7000)
        XCTAssertEqual(emissions, "8000.00", "Emissions should be calculated with a different rate beyond 5000 km.")
    }

    // Mock calculateEmissions function for testing purposes
    func calculateEmissions(for kilometrage: Double) -> String {
        let firstThreshold: Double = 5000
        let firstRate: Double = 1.0
        let secondRate: Double = 1.5
        
        let firstPartEmissions = min(kilometrage, firstThreshold) * firstRate
        let secondPartEmissions = max(0, kilometrage - firstThreshold) * secondRate
        let totalEmissions = firstPartEmissions + secondPartEmissions
        
        return String(format: "%.2f", totalEmissions)
    }
}
