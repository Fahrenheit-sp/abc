//
//  ProfileView.swift
//  ABC
//
//  Created by Igor Maisiuk on 14.06.2026.
//

import SwiftUI

struct ProfileView: View {

    @EnvironmentObject private var settings: Settings

    let backAction: () -> Void

    var body: some View {
        VStack {
            avatarView
                .offset(y: -16)

            coinsView
                .padding(UIScreen.isLarge ? 16 : 6)
                .padding(.horizontal, UIScreen.isLarge ? 16 : 8 )
                .onWhiteBackground()

            avatarsButton

            achievementsButton

            GetAvatarsView()
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
        .padding(.bottom)
        .background {
            Image(.profileBg).asBackground
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                editButton
            }

            ToolbarItem(placement: .principal) {
                navigationTitle
            }
        }
    }

    private var navigationTitle: some View {
        Text("general.profile")
            .font(.header3)
            .foregroundStyle(.black)
    }

    private var editButton: some View {
        Button {
            #warning("Edit profile name")
            print("Edit")
        } label: {
            if #available(iOS 26, *) {
                Image(systemName: "pencil")
                    .resizable()
                    .scaledToFit()
            } else {
                Image(.editBtn)
            }
        }
    }

    private var avatarView: some View {
        VStack(spacing: UIScreen.isLarge ? -60 : -32) {
            Image(settings.avatar)
                .resizable()
                .scaledToFit()
                .padding(UIScreen.isLarge ? 32 : 0)
                .background {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.1))

                        Circle()
                            .fill(Color.white.opacity(0.4))
                            .padding(12)

                        Circle()
                            .fill(Color.white)
                            .padding(24)
                    }
                    .padding(UIScreen.isLarge ? -32 : -50)
                }
                .zIndex(0)

            ColoredBackgroundLabel(text: settings.name,
                                   font: UIScreen.isLarge ? .header3 : .bodyBold,
                                   color: .orangePrimary,
                                   horizontalPadding: 24,
                                   verticalPadding: 12,
                                   strokeWidth: 6)
            .zIndex(1)
        }
    }

    private var coinsView: some View {
        HStack {
            Text(settings.coins.description)
                .font(.header3)
                .foregroundStyle(.black)

            Image(.coinIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 32)
        }
    }

    private var avatarsButton: some View {
        Image(.profileButtonBg)
            .resizable()
            .scaledToFit()
            .overlay {
                HStack {
                    VStack(alignment: .leading) {
                        Text("profile.avatars")
                            .textCase(.uppercase)
                            .font(.header3)
                            .shadow(color: .black, radius: 1)
                            .shadow(color: .black, radius: 1)
                            .foregroundStyle(.white)

                        CommonButton(title: L10n.Profile.seeAll.uppercased()) {
                            print("Open see all")
                        }
                    }

                    Spacer()

                    Image(.avatarsIcon)
                        .resizable()
                        .scaledToFit()
                }
                .padding()
            }
            .onTapGesture {
                print("Open see all")
            }
    }

    private var achievementsButton: some View {
        Image(.profileButtonBg)
            .resizable()
            .scaledToFit()
            .overlay {
                HStack {
                    VStack(alignment: .leading) {
                        Text("profile.achievements")
                            .textCase(.uppercase)
                            .font(.header3)
                            .shadow(color: .black, radius: 1)
                            .shadow(color: .black, radius: 1)
                            .foregroundStyle(.white)

                        CommonButton(title: L10n.Profile.seeAll.uppercased()) {
                            print("Open see all")
                        }
                    }

                    Spacer()

                    Image(.achievementsIcon)
                        .resizable()
                        .scaledToFit()
                }
                .padding()
            }
            .onTapGesture {
                print("Open see all")
            }
    }

}

#Preview {
    NavigationStack {
        ProfileView {}
    }
    .environmentObject(Settings.preview)
}
