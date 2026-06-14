//
//  View.swift
//  ABC
//
//  Created by Igor Maisiuk on 30.03.2026.
//

import SwiftUI

extension View {

    @ViewBuilder
    func `if`<Result: View>(_ condition: Bool, modifier: (Self) -> Result) -> some View {
        if condition {
            modifier(self)
        } else {
            self
        }
    }
}

extension Image {
    var asBackground: some View {
        self
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
