//
//  AnyPublisher+Never.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-10-01.
//

import Combine

extension AnyPublisher {
    static func never() -> Self {
        Empty(completeImmediately: false).eraseToAnyPublisher()
    }
}

