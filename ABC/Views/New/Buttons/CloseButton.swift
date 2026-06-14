//
//  CloseButton.swift
//  ABC
//
//  Created by Igor Maisiuk on 14.06.2026.
//

import SwiftUI

struct CloseButton: View {

    let action: () -> Void
    var animated: Bool = true

    var body: some View {
        Button {
            if animated {
                withAnimation { action() }
            } else {
                action()
            }
        } label: {
            Image(.closeBtn)
        }
    }
}

#Preview {
    CloseButton { }
}
