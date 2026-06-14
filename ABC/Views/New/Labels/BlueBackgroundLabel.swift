//
//  BlueBackgroundLabel.swift
//  ABC
//
//  Created by Igor Maisiuk on 14.06.2026.
//

import SwiftUI

struct BlueBackgroundLabel: View {
    let text: LocalizedStringKey
    var uppercased = true

    var body: some View {
        Text(text)
            .if(uppercased) { $0.textCase(.uppercase) }
            .font(.header3)
            .foregroundStyle(Color.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 40)
            .background {
                ZStack {
                    Capsule()
                        .fill(Color.blueSecondary.gradient)
                }
                .overlay(Capsule().stroke(.white.shadow(.drop(color: .black.opacity(0.15), radius: 2, x: 0, y: 2)), lineWidth: 2))
            }
    }
}

#Preview {
    ZStack {
        Color.yellow

        BlueBackgroundLabel(text: "Settings")
    }
}


