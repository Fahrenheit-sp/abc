//
//  BlueBackgroundLabel.swift
//  ABC
//
//  Created by Igor Maisiuk on 14.06.2026.
//

import SwiftUI

struct ColoredBackgroundLabel: View {
    let text: String
    var uppercased = true
    var font: Font = .header3
    var color: Color = .blueSecondary
    var horizontalPadding: CGFloat = 40
    var verticalPadding: CGFloat = 12
    var strokeWidth: CGFloat = 2

    var body: some View {
        Text(LocalizedStringKey(text))
            .if(uppercased) { $0.textCase(.uppercase) }
            .font(font)
            .foregroundStyle(Color.white.shadow(.drop(color: .black.opacity(0.35), radius: 1, x: 0, y: 1)))
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .background {
                ZStack {
                    Capsule()
                        .fill(color.gradient)
                }
                .overlay(Capsule().stroke(.white.shadow(.drop(color: .black.opacity(0.15), radius: 2, x: 0, y: 2)), lineWidth: strokeWidth))
            }
    }
}

#Preview {
    ZStack {
        Color.yellow

        ColoredBackgroundLabel(text: "Settings")
    }
}


