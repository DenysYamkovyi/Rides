//
//  CarbonEmissionsView.swift
//  Rides
//
//  Created by macbook pro on 2024-10-02.
//

import SwiftUI

protocol CarbonEmissionsViewViewModel {
    var vin: String { get }
    var make: String { get }
    var kilometrage: Int { get }
}

struct CarbonEmissionsView<ViewModel>: View where ViewModel: CarbonEmissionsViewViewModel {
    private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Text("Carbon Emissions")
                .font(.largeTitle)
                .padding()

            Text("Estimated Carbon Emissions for \(viewModel.make) (\(viewModel.vin))")
                .font(.headline)
            
            Text("Emissions: \(calculateEmissions(for: Double(viewModel.kilometrage))) g/km")
                .padding()
        }
    }
}

extension CarbonEmissionsView {
    // Function to calculate emissions based on kilometrage
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
