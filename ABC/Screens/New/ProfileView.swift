//
//  ProfileView.swift
//  ABC
//
//  Created by Igor Maisiuk on 14.06.2026.
//

import SwiftUI

struct ProfileView: View {

    let backAction: () -> Void

    var body: some View {
        VStack {
            Spacer()
                .frame(maxWidth: .infinity)
        }
        .padding()
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
}

#Preview {
    NavigationStack {
        ProfileView {}
    }
}
