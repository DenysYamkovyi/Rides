//
//  Font+OpenSans.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-10-01.
//

import SwiftUI

extension Font {
    static func openSansBold(_ size: CGFloat) -> Font {
        .custom("OpenSans-Bold", size: size)
    }

    static func openSansSemiBold(_ size: CGFloat) -> Font {
        .custom("OpenSans-SemiBold", size: size)
    }

    static func openSansRegular(_ size: CGFloat) -> Font {
        .custom("OpenSans-Regular", size: size)
    }
}
