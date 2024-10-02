//
//  CarsListCoordinator.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-10-01.
//

import Combine
import UIKit

final class CarsListCoordinator: Coordinator {
    typealias CompletionType = Void
    
    private weak var navigationController: UINavigationController?
    
    private let done: PassthroughSubject<CompletionType, Never> = .init()
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    @discardableResult
    func start(animated: Bool) -> CompletionPublisher {
        let viewModel = CarsListViewModel()
        let view = CarsListView(viewModel: viewModel)
        let viewController = HostViewController(contentView: view)
        
        viewModel
            .showDetails
            .sink { [weak self] car in
                self?.showDetails(car: car, animated: animated)
            }
            .store(in: &cancellables)
        
        navigationController?.pushViewController(viewController, animated: animated)
        
        return done.eraseToAnyPublisher()
    }
    
    @objc
    func close() {
        navigationController?.dismiss(animated: true)
    }
    
    private func showDetails(car: Car, animated: Bool) {
        let viewModel = CarDetailsViewModel(car: car)
        let view = CarDetailsView(viewModel: viewModel)
        let viewController = HostViewController(contentView: view)
        
        navigationController?.pushViewController(viewController, animated: animated)
    }
}
