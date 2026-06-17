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
    @State private var settingsShown = false

    @StateObject private var coordinator = HomeCoordinator()

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    //    avatar

                    GetSubscriptionView()
                        .padding(.top, -16)

                    ForEach(MainMenuItem.gameItems, id: \.hashValue) { item in
                        view(for: item) {
                            withAnimation { selectedGame = item }
                        }
                    }
                }
                .offset(y: 268)
            }
            .background(alignment: .top) { avatar }
            .overlay(alignment: .topTrailing) {
                Button {
                    settingsShown = true
                } label: {
                    Image(.settingsBtn)
                }
                .padding(.top)
            }
            .overlay(alignment: .topLeading) {
                ProfileButton {
                    coordinator.push(.profile)
                }
            }
            .padding(.horizontal)
            .overlay {
                ZStack {
                    if settingsShown {
                        SettingsView(isPresented: $settingsShown)
                    }
                }
            }
            .background {
                Image(.homeBg).asBackground
            }
            .navigationDestination(for: HomeRoute.self) { route in
                switch route {
                    case .profile:
                        ProfileView(coordinator: coordinator) { coordinator.pop() }
                    case .avatars(let avatars, let isPurchaseMode):
                        AvatarListView(avatars: avatars,
                                       isPurchaseMode: isPurchaseMode,
                                       purchaseAction: { coordinator.push(.avatars(settings.lockedAvatars, true)) },
                                       backAction: { coordinator.pop() }
                        )
                }
            }
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

            Image(.avatar0)
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
