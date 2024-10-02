//
//  BorderedButtonStyle.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-10-01.
//

import SwiftUI

struct BorderedButtonStyle: ButtonStyle {
    private let mode: Mode
    private let cornerRadius: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(5)
            .foregroundColor(mode.textColor(for: configuration))
            .background(overlay(for: configuration))
    }
    
    private func overlay(for configuration: Configuration) -> AnyView {
        let borderedOverlay = AnyView(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(mode.strokeColor(for: configuration), lineWidth: 2))
        
        switch mode {
        case .normal:
            return borderedOverlay
        case .colorChanging:
            if configuration.isPressed {
                return AnyView(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .foregroundColor(mode.foregroundColor(for: configuration)))
            }
            
            return borderedOverlay
        }
    }
}

extension BorderedButtonStyle {
    static var secondaryButtonStyle: BorderedButtonStyle {
        BorderedButtonStyle(
            mode: .normal(
                ColorTemplate(
                    textColor: .gray,
                    foregroundColor: .clear,
                    strokeColor: .highlighted)
                ),
            cornerRadius: 8
        )
    }
    
    static var primaryButtonStyle: BorderedButtonStyle {
        BorderedButtonStyle(
            mode: .colorChanging(
                normal: ColorTemplate(
                    textColor: .gray,
                    foregroundColor: .black,
                    strokeColor: .gray),
                pressed: ColorTemplate(
                    textColor: .white,
                    foregroundColor: .highlighted,
                    strokeColor: .clear)),
            cornerRadius: 8)
    }
}

private extension BorderedButtonStyle {
    struct ColorTemplate {
        let textColor: Color
        let foregroundColor: Color
        let strokeColor: Color
    }
    
    enum Mode {
        case normal(ColorTemplate)
        case colorChanging(normal: ColorTemplate, pressed: ColorTemplate)
        
        func textColor(for configuration: Configuration) -> Color {
            switch self {
            case .normal(let template):
                return template.textColor
            case let .colorChanging(normal, pressed):
                return configuration.isPressed ? pressed.textColor : normal.textColor
            }
        }
        
        func foregroundColor(for configuration: Configuration) -> Color {
            switch self {
            case .normal(let template):
                return template.foregroundColor
            case let .colorChanging(normal, pressed):
                return configuration.isPressed ? pressed.foregroundColor : normal.foregroundColor
            }
        }
        
        func strokeColor(for configuration: Configuration) -> Color {
            switch self {
            case .normal(let template):
                return template.strokeColor
            case let .colorChanging(normal, pressed):
                return configuration.isPressed ? pressed.strokeColor : normal.strokeColor
            }
        }
    }
}

