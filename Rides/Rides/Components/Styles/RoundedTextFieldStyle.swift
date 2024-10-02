//
//  RoundedTextFieldStyle.swift
//  RidesSwiftUI_Storyboard
//
//  Created by macbook pro on 2024-10-01.
//

import Foundation
import SwiftUI

struct RoundedTextFieldStyle: TextFieldStyle {
    var isErrored: Bool
    var backgroundColor: Color = .clear
    var borderColor: Color = .clear
    var errorColor: Color = .red
    private let cornerRadius: CGFloat = 8
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .font(.openSansRegular(16))
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(isErrored ? .red : borderColor, lineWidth: 2)
                    .background(backgroundColor)
            )
            .cornerRadius(cornerRadius)
    }
}

#if DEBUG
struct RoundedTextFieldStyle_Previews: PreviewProvider {
    static var previews: some View {
        TextField("Username", text: .constant(""))
            .textFieldStyle(RoundedTextFieldStyle(
                isErrored: false,
                backgroundColor: .red,
                borderColor: Color.green)
            )
            .padding(42)
    }
}
#endif

