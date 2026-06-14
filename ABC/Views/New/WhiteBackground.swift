//
//  WhiteBackground.swift
//  ABC
//
//  Created by Igor Maisiuk on 30.03.2026.
//

import SwiftUI

extension View {
    func onWhiteBackground() -> some View {
        self
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.grayMedium)
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.grayLight)
                    .padding(.bottom, 3)
            }
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(.white, lineWidth: 2))
        }
    }
}

#Preview {
    ZStack {
        Color.blue

        Text("Hello, World")
            .frame(maxWidth: .infinity)
            .padding()
            .onWhiteBackground()
            .padding()
    }
}
