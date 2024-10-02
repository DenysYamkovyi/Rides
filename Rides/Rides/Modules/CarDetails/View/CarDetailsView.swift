//
//  CarDetailsView.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-10-01.
//

import Combine
import SwiftUI

protocol CarDetailsViewViewModel {
    var vin: String { get }
    var make: String { get }
    var color: String { get }
    var type: String { get }
}

struct CarDetailsView<ViewModel>: View where ViewModel: CarDetailsViewViewModel {
    private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            TitleText(
                style: .large,
                text: "Vin".toLocalized() + ": " + viewModel.vin
            )
            .padding(.horizontal, 8)
            
            TitleText(
                style: .large,
                text: "Make".toLocalized() + ": " + viewModel.make
            )
            .padding(.horizontal, 8)
            
            TitleText(
                style: .large,
                text: "Color".toLocalized() + ": " + viewModel.color
            )
            .padding(.horizontal, 8)
            
            TitleText(
                style: .large,
                text: "Type".toLocalized() + ": " + viewModel.type
            )
            .padding(.horizontal, 8)
        }
        .background(.clear)
    }
}

#if DEBUG
#Preview {
    CarsListView<CarsListViewModel>(viewModel: .init())
}
#endif


