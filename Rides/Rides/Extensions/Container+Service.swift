//
//  Container+Service.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-10-01.
//

import Factory

extension Container {
    // MARK: Services
    var apiService: Factory<APIService> {
        self { fatalError("APIService is not initialized") }.cached
    }
    
    // MARK: UseCases
    var carsListUseCase: Factory<CarsListUseCaseProtocol> {
        self { fatalError("ProfileUseCase is not initialized") }.cached
    }
}

