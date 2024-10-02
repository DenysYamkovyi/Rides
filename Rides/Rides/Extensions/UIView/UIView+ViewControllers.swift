//
//  UIView+ViewControllers.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-10-01.
//

import UIKit

extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = next as? UIViewController {
            return nextResponder
        }

        if let nextResponder = next as? UIView {
            return nextResponder.findViewController()
        }

        return nil
    }
}

