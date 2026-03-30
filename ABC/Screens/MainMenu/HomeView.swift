//
//  HomeView.swift
//  ABC
//
//  Created by Igor Maisiuk on 30.03.2026.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var settings: Settings
    @State private var selectedGame: MainMenuItem?

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                avatar

                if !settings.isPremium {
                    GetSubscriptionView()
                        .padding(.top, -16)
                }

                ForEach(MainMenuItem.gameItems, id: \.hashValue) { item in
                    view(for: item) {
                        withAnimation { selectedGame = item }
                    }
                }
            }
        }
        .padding(.horizontal)
        .overlay(alignment: .topTrailing) {
            Button {
                print("Show settings")
            } label: {
                Image(.settingsBtn)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 42)
            }
            .padding()
        }
        .background {
            Image(.homeBg).asBackground
        }
    }

    private var avatar: some View {
        VStack {
            Text(welcomeText)
                .padding(.horizontal, 8)
                .background {
                    Image(.helloCloud)
                        .resizable()
                        .scaledToFill()
                        .offset(y: 6)
                }

            Image(settings.avatar)
                .resizable()
                .scaledToFit()
                .frame(width: 150)
        }
    }

    private var welcomeText: AttributedString {
        var string = AttributedString(L10n.Home.welcome(settings.name))
        string.foregroundColor = .black
        string.font = .body
        if let range = string.range(of: settings.name + "!") {
            string[range].font = .bodyBold
        }
        return string
    }

    private func view(for item: MainMenuItem, action: @escaping () -> Void) -> some View {
        Image(item.image)
            .resizable()
            .scaledToFit()
            .overlay(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text(item.title.uppercased())
                        .font(.header3)
                        .shadow(color: .black, radius: 1)
                        .shadow(color: .black, radius: 1)
                        .foregroundStyle(.white)

                    CommonButton(title: L10n.General.play.uppercased(), icon: "play.fill", action: action)
                }
                .padding()
            }
            .onTapGesture {
                action()
            }
    }
}

#Preview {
    HomeView()
        .environmentObject(Settings.preview)
}
