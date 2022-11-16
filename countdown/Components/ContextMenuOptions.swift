//
//  ContextMenuOptions.swift
//  countdown
//
//  Created by Venâncio Ávila on 27/10/22.
//

import SwiftUI

// MARK: Reusable context menu options
@ViewBuilder
func ContextMenuOptions(maxValue: Int, hint: String, onClick: @escaping (Int) -> ()) -> some View {
    ForEach(0...maxValue, id: \.self) {value in
        Button("\(value) \(hint)") {
            onClick(value)
        }
    }
}
