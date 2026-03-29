//
//  PageIndicatorView.swift
//  Wisher
//
//  Created by Игорь Майсюк on 18.06.23.
//

import SwiftUI

struct PageIndicatorView: View {
    let totalElements: Int
    let currentIndex: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalElements, id: \.self) { index in
                Circle()
                    .fill(index == currentIndex ? Color.orangePrimary : Color.grayIngame)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.blue

        PageIndicatorView(totalElements: 5, currentIndex: 1)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
