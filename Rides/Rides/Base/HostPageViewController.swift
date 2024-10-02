//
//  HostPageViewController.swift
//  Rides
//
//  Created by vyamkovyy on 2024-10-02.
//

import SwiftUI
import UIKit

class HostPageViewController: UIPageViewController {
    private let controllers: [UIViewController]
    
    init(viewControllers: [UIViewController]) {
        self.controllers = viewControllers
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        self.setViewControllers([viewControllers.first!], direction: .forward, animated: false)
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HostPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    // MARK: - UIPageViewController DataSource
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return controllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0 // start at the first page
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else { return nil }
        return index > 0 ? controllers[index - 1] : nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else { return nil }
        return index < controllers.count - 1 ? controllers[index + 1] : nil
    }
}
