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
        ZStack {
            Color.blue.ignoresSafeArea()

            Button {
                backAction()
            } label: {
                Text("Back")
            }
        }
    }
}

#Preview {
    ProfileView {}
}
