//
//  CarsListViewModel+CarRowViewModel.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-10-01.
//

import Foundation

extension CarsListViewModel {
    struct CarRowViewModel: ContentRowViewViewModel, Hashable {
        let title: String
        let subtitle: String
        
        let onTap: () -> Void
        
        // Custom hash function
        func hash(into hasher: inout Hasher) {
            hasher.combine(title)
            hasher.combine(subtitle)
        }
        
        // Custom equality operator (part of `Hashable` conformance)
        static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.title == rhs.title && lhs.subtitle == rhs.subtitle
        }
    }
}

