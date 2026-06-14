//
//  MainButton.swift
//  ABC
//
//  Created by Igor Maisiuk on 29.03.2026.
//

import SwiftUI

struct CommonButton: View {
    let title: String
    var icon: String?
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            if let icon {
                Label(title, systemImage: icon)
            } else {
                Text(title)
            }
        }
        .buttonStyle(CommonButtonStyle())
    }
}

struct CommonButtonStyle: ButtonStyle {

    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.button)
            .foregroundStyle(configuration.isPressed
                             ? Color.white.opacity(0.7).shadow(.drop(color: .black.opacity(0.15), radius: 1, x: 0, y: 1))
                             : Color.white.shadow(.drop(color: .black.opacity(0.25), radius: 1, x: 0, y: 1)))
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.orangeSecondary
                            .shadow(.inner(color: .white.opacity(0.25), radius: 1, x: 0, y: 2)))
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.orangePrimary
                            .shadow(.inner(color: .white.opacity(0.25), radius: 1, x: 0, y: 2)))
                        .opacity(configuration.isPressed ? 0.3 : 1)
                        .padding(.vertical, 2)
                }
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(.white.shadow(.drop(color: .black.opacity(0.15), radius: 2, x: 0, y: 2)), lineWidth: 2))
            }
            .opacity(isEnabled ? 1 : 0.5)
    }
}

#Preview {
    ZStack {
        Color.blue
        
        CommonButton(title: "NEXT", icon: "play.fill",  action: {})
            .padding()
    }
}
