//
//  ProfileButton.swift
//  ABC
//
//  Created by Igor Maisiuk on 14.06.2026.
//

import SwiftUI

struct ProfileButton: View {

    @EnvironmentObject private var settings: Settings

    let action: () -> Void

    var body: some View {
        Button {
            withAnimation { action() }
        } label: {
            VStack(spacing: -24) {
                Image(settings.avatar)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
                    .padding()
                    .background {
                        Circle()
                            .fill(Color.grayLight)
                            .strokeBorder(Color.white, lineWidth: 2)
                    }
                    .zIndex(0)

                ColoredBackgroundLabel(text: "general.profile",
                                       font: .subtext,
                                       color: .orangePrimary,
                                       horizontalPadding: 12,
                                       verticalPadding: 6,
                                       strokeWidth: 2)
                .zIndex(1)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.blue.ignoresSafeArea()

        ProfileButton { }
    }
        .environmentObject(Settings.preview)
}
