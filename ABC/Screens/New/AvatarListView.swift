//
//  AvatarListView.swift
//  ABC
//
//  Created by Igor Maisiuk on 14.06.2026.
//

import SwiftUI

struct AvatarListView: View {

    @EnvironmentObject private var settings: Settings

    let avatars: [Avatar]
    let isPurchaseMode: Bool
    let purchaseAction: () -> Void
    let backAction: () -> Void

    var body: some View {
        VStack {
            if !isPurchaseMode {
                GetAvatarsView()
                    .onTapGesture {
                        purchaseAction()
                    }
            }

            ScrollView {
                LazyVGrid(columns: [.init(), .init(), .init()]) {
                    ForEach(avatars) { avatar in
                        Image(avatar.name)
                            .resizable()
                            .scaledToFit()
                            .background {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.grayMedium)
                                    .strokeBorder(isCurrent(avatar) ? Color.orangePrimary : Color.white, lineWidth: 4)
                            }
                            .onTapGesture {
                                tapAction(for: avatar)
                            }
                    }
                }
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("general.avatars")
                    .font(.header3)
                    .foregroundStyle(.black)
            }
        }
        .background {
            Image(.avatarsBg).asBackground
        }
    }

    private func isCurrent(_ avatar: Avatar) -> Bool {
        settings.avatar == avatar.name
    }

    private func tapAction(for avatar: Avatar) {
        if isPurchaseMode {
            attemptToPurchase(avatar)
        } else {
            withAnimation { settings.avatar = avatar.name }
        }
    }

    private func attemptToPurchase(_ avatar: Avatar) {

    }
}

#Preview {
    NavigationStack {
        AvatarListView(avatars: Avatar.avatars,
                       isPurchaseMode: true,
                       purchaseAction: {},
                       backAction: {})
    }
    .environmentObject(Settings.preview)
}
