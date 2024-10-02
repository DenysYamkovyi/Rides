//
//  TitleText.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-10-01.
//

import SwiftUI

enum TitleTextStyle {
    case extra2Small
    case extraSmall
    case small
    case medium
    case large
    case extraLarge
    case customRegular(size: CGFloat)
    case smallSemiBold
    case mediumSemiBold
    case largeSemiBold
    case smallBold
    case mediumBold
    case largeBold
    
    var font: Font {
        return switch self {
        case .extra2Small:
                .openSansRegular(8)
        case .extraSmall:
                .openSansRegular(10)
        case .small:
                .openSansRegular(12)
        case .medium:
                .openSansRegular(14)
        case .large:
                .openSansRegular(16)
        case .extraLarge:
                .openSansRegular(18)
        case .customRegular(let size):
                .openSansRegular(size)
        case .smallSemiBold:
                .openSansSemiBold(12)
        case .mediumSemiBold:
                .openSansSemiBold(14)
        case .largeSemiBold:
                .openSansSemiBold(16)
        case .smallBold:
                .openSansBold(12)
        case .mediumBold:
                .openSansBold(14)
        case .largeBold:
                .openSansBold(16)
        }
    }
}

struct TitleText: View {
    private let style: TitleTextStyle
    private let text: String
    private let textColor: Color
    
    init(style: TitleTextStyle, text: String, color: Color = .black) {
        self.style = style
        self.text = text
        self.textColor = color
    }
    
    var body: some View {
        Text(text)
            .font(style.font)
            .foregroundColor(textColor)
    }
}

