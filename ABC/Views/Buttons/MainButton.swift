//
//  MainButton.swift
//  ABC
//
//  Created by Igor Maisiuk on 29.03.2026.
//

import SwiftUI

struct MainButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
        }
        .buttonStyle(MainButtonStyle())
    }
}

struct MainButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.button)
            .foregroundStyle(configuration.isPressed
                             ? Color.white.opacity(0.7).shadow(.drop(color: .black.opacity(0.15), radius: 1, x: 0, y: 1))
                             : Color.white.shadow(.drop(color: .black.opacity(0.25), radius: 1, x: 0, y: 1)))
            .padding()
            .frame(maxWidth: .infinity)
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
    }
}

#Preview {
    ZStack {
        Color.blue
        
        MainButton(title: "NEXT", action: {})
            .padding()
    }
}
