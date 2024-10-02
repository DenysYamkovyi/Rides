//
//  HostViewController.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-10-01.
//

import SwiftUI
import UIKit

class HostViewController<Content>: UIViewController where Content: View {
    private let contentView: Content
    private var hostingController: UIHostingController<Content>

    init(contentView: Content) {
        self.contentView = contentView
        self.hostingController = .init(rootView: contentView)
        super.init(nibName: nil, bundle: nil)
    }
    
    // swiftlint:disable:next unavailable_function
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        hostingController.removeFromParent()
        hostingController.didMove(toParent: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        #if os(iOS)
        view.backgroundColor = .systemBackground
        #endif

        configureHostingController()
    }

    private func configureHostingController() {
        addChild(hostingController)
        hostingController.view.frame = view.frame
        view.addSubview(hostingController.view)
        hostingController.view.bindFrameToSuperviewBounds()
        hostingController.didMove(toParent: self)
    }
}

