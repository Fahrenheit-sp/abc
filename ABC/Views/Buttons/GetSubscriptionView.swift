//
//  GetSubscriptionView.swift
//  ABC
//
//  Created by Igor Maisiuk on 30.03.2026.
//

import SwiftUI

struct GetSubscriptionView: View {
    var body: some View {
        HStack {
            Image(.subscriptionImg)
                .resizable()
                .scaledToFit()
                .frame(width: 50)

            VStack(alignment: .leading) {
                Text(L10n.Subscription.title)
                    .font(.header4)
                    .foregroundStyle(.black)

                Text(L10n.Subscription.subtitle)
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
    ZStack {
        Color.blue
        
        GetSubscriptionView()
            .padding()
    }
}
