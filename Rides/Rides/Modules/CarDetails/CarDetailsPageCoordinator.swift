//
//  CarDetailsPageCoordinator.swift
//  Rides
//
//  Created by macbook pro on 2024-10-02.
//

import UIKit
import Combine
import SwiftUI

final class CarDetailsPageCoordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    private let car: Car
    private weak var navigationController: UINavigationController?
    private let viewControllers: [UIViewController]
    
    init(car: Car, navigationController: UINavigationController?) {
        self.car = car
        self.navigationController = navigationController

        let carDetailsView = CarDetailsView(viewModel: CarDetailsViewModel(car: car))
        let emissionsView = CarbonEmissionsView(viewModel: CarbonEmissionsViewModel(car: car))

        let carDetailsVC = HostViewController(contentView: carDetailsView)
        let emissionsVC = HostViewController(contentView: emissionsView)

        //self.viewControllers = [carDetailsVC, emissionsVC]
        self.viewControllers = [emissionsVC, carDetailsVC]
        
        super.init()
    }
    
    func start(animated: Bool) {
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageVC.dataSource = self
        pageVC.delegate = self
        
        pageVC.setViewControllers([viewControllers.first!], direction: .forward, animated: animated, completion: nil)
        
        navigationController?.pushViewController(pageVC, animated: animated)
    }
    
    // MARK: - UIPageViewController DataSource
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0 // start at the first page
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController) else { return nil }
        return index > 0 ? viewControllers[index - 1] : nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController) else { return nil }
        return index < viewControllers.count - 1 ? viewControllers[index + 1] : nil
    }
}
