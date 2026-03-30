//
//  View.swift
//  ABC
//
//  Created by Igor Maisiuk on 30.03.2026.
//

import SwiftUI

extension View {

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
