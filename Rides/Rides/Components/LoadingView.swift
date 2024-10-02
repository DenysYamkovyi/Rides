//
//  LoadingView.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-10-01.
//

import SwiftUI

struct LoadingView: View {
    private static let speedConstant: TimeInterval = 2.0

    @State private var isAnimating = false
    private let spinnerSize: CGFloat
    private let backgroundColor: Color
    private let backgroundOpacity: CGFloat
    private let spinnerSpeed: TimeInterval
    
    init(spinnerSize: CGFloat = 100,
         backgroundColor: Color = .black,
         backgroundOpacity: CGFloat = 0.5,
         spinnerSpeed: TimeInterval = 1.0
    ) {
        self.spinnerSize = spinnerSize
        self.backgroundColor = backgroundColor
        self.backgroundOpacity = backgroundOpacity
        self.spinnerSpeed = spinnerSpeed
    }
    
    private var foreverAnimation: Animation {
        Animation.linear(duration: LoadingView.speedConstant / spinnerSpeed)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(backgroundColor)
                .opacity(backgroundOpacity)
            Image(.spinner)
                .resizable()
                .frame(width: spinnerSize, height: spinnerSize)
                .aspectRatio(contentMode: .fit)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0.0))
                .animation( isAnimating ? foreverAnimation : .default)
                .onAppear { isAnimating = true }
                .onDisappear { isAnimating = false }
                .accessibility(label: Text("spinner"))
        }
    }
}

#if DEBUG

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(spinnerSize: 100)
    }
}

#endif
