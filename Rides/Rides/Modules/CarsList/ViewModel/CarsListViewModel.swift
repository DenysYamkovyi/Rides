//
//  CarsListViewModel.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-10-01.
//

import Combine
import Factory
import Foundation

final class CarsListViewModel: CarsListViewViewModel, ObservableObject {
    @Published private(set) var isLoading: Bool = false
    @Published var listSize: String = ""
    @Published private(set) var list: [CarRowViewModel] = []
    @Published var sortBy: SortOption = .vin {
        didSet {
            // Re-sort the list whenever the sort option changes
            applySorting()
        }
    }
    @Published var error: String = ""
    
    @PublicPassthrough var showDetails: AnyPublisher<Car, Never>
    
    @Injected(\.carsListUseCase) private var carsListUseCase
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        // Observe changes to sortBy to apply sorting immediately when it changes
        $sortBy
            .sink { [weak self] _ in
                self?.applySorting()
            }
            .store(in: &cancellables)
    }
    
    func didTapFetchCarsList() {
        guard !isLoading,
              isParameterValid() else { return }
        
        isLoading = true
        error = ""
        
        carsListUseCase
            .fetchCarsList(size: listSize)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                self?.isLoading = false
                switch result {
                case let .failure(error):
                    self?.error = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] cars in
                self?.error = ""
                self?.handleNewListData(data: cars)
            }
            .store(in: &cancellables)
    }
    
    private func handleNewListData(data: [Car]) {
        let carRowViewModels = data.map { car in
            CarRowViewModel(
                title: car.make,
                subtitle: car.vin
            ) { [_showDetails] in
                _showDetails.subject.send(car)
            }
        }
        // Update the list and apply sorting
        self.list = carRowViewModels
        applySorting()
    }
    
    private func applySorting() {
        switch sortBy {
        case .vin:
            list.sort { $0.subtitle < $1.subtitle }
        case .carType:
            list.sort { $0.title < $1.title }
        }
    }
    
    private func isParameterValid() -> Bool {
        guard let size = Int(listSize), size > 0 && size <= 100 else {
            error = "Please enter a value between 1 and 100".toLocalized()
            return false
        }
        
        return true
    }
}
