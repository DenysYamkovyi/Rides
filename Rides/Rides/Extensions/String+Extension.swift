//
//  String+Extension.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-10-01.
//

import Foundation

extension String {
    func toLocalized(_ comment: String? = nil) -> String {
        NSLocalizedString(self, comment: comment ?? "")
    }
}

