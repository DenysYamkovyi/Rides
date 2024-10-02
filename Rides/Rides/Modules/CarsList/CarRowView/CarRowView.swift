//
//  CarRowView.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-10-01.
//

import SwiftUI

protocol ContentRowViewViewModel {
    var title: String { get }
    var subtitle: String { get }
    
    var onTap: () -> Void { get }
}

struct ContentRowView: View {
    private let viewModel: ContentRowViewViewModel
    
    init(viewModel: ContentRowViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            TitleText(
                style: .medium,
                text: viewModel.title
            )
            .padding(.horizontal, 8)
            
            TitleText(
                style: .small,
                text: viewModel.subtitle
            )
            .padding(.horizontal, 8)
        }
        .background(.clear)
        .onTapGesture {
            viewModel.onTap()
        }
    }
}
