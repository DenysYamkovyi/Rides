//
//  CustomUIHostingConfiguration.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-10-01.
//

import Foundation
import SwiftUI

/// This struct is a close imitation of Apple's UIContentConfiguration as a fallback option for any iOS & tvOS version lower than 16.0.
/// Reference article: https://medium.com/justeattakeaway-tech/using-swiftui-inside-an-ancient-uitableview-or-uicollectionview-bb8defb6304
struct CustomUIHostingConfiguration<Content>: UIContentConfiguration where Content: View {
    fileprivate let hostingController: UIHostingController<Content>

    init(@ViewBuilder content: () -> Content) {
        hostingController = UIHostingController(rootView: content())
    }

    func makeContentView() -> any UIView & UIContentView {
        CustomContentView<Content>(self)
    }

    func updated(for state: any UIConfigurationState) -> CustomUIHostingConfiguration<Content> {
        return self
    }
}

private final class CustomContentView<Content>: UIView, UIContentView where Content: View {
    private weak var currentHostingController: UIHostingController<Content>?

    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration)
        }
    }

    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
    }

    // swiftlint:disable:next unavailable_function
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        reset()
    }

    private func reset() {
        currentHostingController?.removeFromParent()
        currentHostingController?.didMove(toParent: nil)
    }

    private func configure(_ configuration: UIContentConfiguration) {
        guard let configuration = configuration as? CustomUIHostingConfiguration<Content>,
            let parent = findViewController() else {
            return
        }

        if currentHostingController != nil {
            reset()
        }

        currentHostingController = configuration.hostingController

        guard let currentHostingController,
            let swiftUICellView = currentHostingController.view else {
            return
        }

        currentHostingController.view.backgroundColor = .clear

        subviews.forEach { $0.removeFromSuperview() }
        addSubview(swiftUICellView)

        parent.addChild(currentHostingController)
        swiftUICellView.translatesAutoresizingMaskIntoConstraints = false
        swiftUICellView.bindFrameToSuperviewBounds()
        currentHostingController.didMove(toParent: parent)
    }
}

