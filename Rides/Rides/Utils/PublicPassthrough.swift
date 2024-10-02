//
//  PublicPassthough.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-10-01.
//

import Combine
import Foundation

@propertyWrapper
struct PublicPassthrough<Output, Failure: Error> {
    let subject: PassthroughSubject<Output, Failure> = .init()
    
    var wrappedValue: AnyPublisher<Output, Failure> {
        subject.eraseToAnyPublisher()
    }
}
