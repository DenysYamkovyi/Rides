//
//  SceneDelegate+Dependencies.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-09-30.
//

import Factory
import Foundation

extension SceneDelegate {
    func setupDependencies() {
        let container = Container.shared
        
        // We need to register here dependency services in Factory
        
        // MARK: Services Init
        let apiService = API(
            urlSession: URLSession.shared,
            baseUrl: Config.hostUrl)
        container.apiService.register { apiService }

        // MARK: Usecases Init
        container.carsListUseCase.register { CarsListUseCase() }
    }
}
