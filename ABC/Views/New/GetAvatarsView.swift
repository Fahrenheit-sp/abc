//
//  GetAvatarsView.swift
//  ABC
//
//  Created by Igor Maisiuk on 14.06.2026.
//

import SwiftUI

struct GetAvatarsView: View {
    var body: some View {
        HStack {
            Image(.getAvatarsIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 50)

            VStack(alignment: .leading) {
                Text(L10n.Profile.getAvatarsTitle)
                    .font(.header4)
                    .foregroundStyle(.black)

                Text(L10n.Profile.getAvatarsSubtitle)
                    .font(.body)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            Image(systemName: "chevron.right")
                .foregroundStyle(.black)
                .font(.header4)
        }
        .padding()
        .onWhiteBackground()
    }
}

#Preview {
    GetAvatarsView()
        .padding()
}
