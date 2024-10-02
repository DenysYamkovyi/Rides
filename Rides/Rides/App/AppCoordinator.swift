//
//  AppCoordinator.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-09-30.
//

import Combine
import UIKit

protocol Coordinator {
    associatedtype CompletionType
    typealias CompletionPublisher = AnyPublisher<CompletionType, Never>
    
    func start(animated: Bool) -> CompletionPublisher
}

final class AppCoordinator: Coordinator {
    typealias CompletionType = Void
    
    private let window: UIWindow
    private var childCoordinator: [any Coordinator] = []
    private var cancellables: Set<AnyCancellable> = .init()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    @discardableResult
    func start(animated: Bool) -> CompletionPublisher {
        let rootViewController = UINavigationController()
        rootViewController.setNavigationBarHidden(true, animated: false)

        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
        showCarsListCoordinator()
        
        return .never()
    }
    
    private func showCarsListCoordinator() {
        let rootViewController = UINavigationController()

        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
        let carsListCoordinator = CarsListCoordinator(navigationController: rootViewController)
        childCoordinator.append(carsListCoordinator)
        carsListCoordinator.start(animated: true)
            .sink { [weak self] in
                if let index = self?.childCoordinator.firstIndex(where: { $0 is CarsListCoordinator }) {
                    self?.childCoordinator.remove(at: index)
                }
            }
            .store(in: &cancellables)
    }
}
