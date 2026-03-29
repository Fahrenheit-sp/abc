//
//  MainTextField.swift
//  ABC
//
//  Created by Igor Maisiuk on 29.03.2026.
//

import SwiftUI

struct MainTextField: View {
    @Binding var text: String
    let placeholder: String

    var body: some View {
        TextField("", text: $text,prompt: prompt)
            .font(.input)
            .foregroundStyle(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.grayMedium
                            .shadow(.inner(color: .white.opacity(0.25), radius: 1, x: 0, y: 2)))
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.grayLight
                            .shadow(.inner(color: .white.opacity(0.25), radius: 1, x: 0, y: 2)))
                        .padding(.vertical, 2)
                }
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(.white.shadow(.drop(color: .black.opacity(0.15), radius: 2, x: 0, y: 2)), lineWidth: 2))
            }
    }

    var prompt: Text {
        Text(placeholder)
            .font(.placeholder)
            .foregroundStyle(Color.input)
    }
}

#Preview {
    ZStack {
        Color.blue

        MainTextField(text: .constant(""), placeholder: "Name")
            .padding()
    }
}
