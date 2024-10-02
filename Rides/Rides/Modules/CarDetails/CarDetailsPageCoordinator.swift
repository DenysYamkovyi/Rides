//
//  CarDetailsPageCoordinator.swift
//  Rides
//
//  Created by macbook pro on 2024-10-02.
//

import UIKit
import Combine
import SwiftUI

final class CarDetailsPageCoordinator: NSObject {
    private let car: Car
    private weak var navigationController: UINavigationController?
    
    init(car: Car, navigationController: UINavigationController?) {
        self.car = car
        self.navigationController = navigationController
        super.init()
    }
    
    func start(animated: Bool) {
        let carDetailsView = CarDetailsView(viewModel: CarDetailsViewModel(car: car))
        let emissionsView = CarbonEmissionsView(viewModel: CarbonEmissionsViewModel(car: car))

        let carDetailsVC = HostViewController(contentView: carDetailsView)
        let emissionsVC = HostViewController(contentView: emissionsView)
        
        let pageVC = HostPageViewController(viewControllers: [emissionsVC, carDetailsVC])
        
        navigationController?.pushViewController(pageVC, animated: animated)
    }
}
