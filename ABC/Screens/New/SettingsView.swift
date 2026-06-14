//
//  SettingsView.swift
//  ABC
//
//  Created by Igor Maisiuk on 14.06.2026.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var settings: Settings
    @Environment(\.openURL) private var openURL

    @Binding var isPresented: Bool

    @State private var offsetY: CGFloat = 1000
    @State private var bgOpacity: CGFloat = 0

    var body: some View {
        ZStack {
            Color.black
                .opacity(bgOpacity)
                .animation(.linear, value: bgOpacity)
                .ignoresSafeArea()

            ZStack(alignment: .center) {
                Image(.settingsBg)
                    .resizable()
                    .scaledToFit()

                VStack {
                    GetSubscriptionView()

                    soundsControl

                    privacyAndTerms
                }
                .padding(.horizontal)
            }
            .padding()
            .overlay(alignment: .top) {
                header
            }
            .overlay(alignment: .topTrailing) {
                closeButton
            }
            .offset(y: offsetY)
            .animation(.bouncy(duration: 0.7), value: offsetY)
            .task {
                offsetY = 0
                bgOpacity = 0.5
            }
        }
    }

    private var header: some View {
        BlueBackgroundLabel(text: "Settings")
    }

    private var closeButton: some View {
        CloseButton {
            isPresented = false
        }
    }

    private var soundsControl: some View {
        VStack {
            HStack {
                Image(.musicIcon)

                Text("Music")
                    .font(.bodyBold)

                Spacer()

                Toggle("", isOn: $settings.musicEnabled)
            }

            HStack {
                Image(.soundIcon)

                Text("Sound")
                    .font(.bodyBold)

                Spacer()

                Toggle("", isOn: $settings.soundsEnabled)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: .grayShadow, radius: 0, x: 0, y: 4)
        }
    }

    private var privacyAndTerms: some View {
        VStack {
            Button {
                openURL(Constants.privacyUrl)
            } label: {
                HStack {
                    Text("Privacy Policy")

                    Spacer()

                    Image(systemName: "chevron.right")
                }
                .padding(.bottom, 12)
                .font(.bodyBold)
                .foregroundStyle(.black)
            }

            Divider()

            Button {
                openURL(Constants.termsUrl)
            } label: {
                HStack {
                    Text("Terms of Use")

                    Spacer()

                    Image(systemName: "chevron.right")
                }
                .padding(.top, 12)
                .font(.bodyBold)
                .foregroundStyle(.black)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: .grayShadow, radius: 0, x: 0, y: 4)
        }
    }
}

#Preview {
    ZStack {
        Color.orange.ignoresSafeArea()

        SettingsView(isPresented: .constant(true))
    }
    .environmentObject(Settings())
}
