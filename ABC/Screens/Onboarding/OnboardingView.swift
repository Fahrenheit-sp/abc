//
//  OnboardingView.swift
//  ABC
//
//  Created by Igor Maisiuk on 29.03.2026.
//

import SwiftUI

struct OnboardingView: View {
    enum Step {
        case first
        case second
        case third
        case name
    }

    @State private var step: Step = .first

    var body: some View {
        ZStack {
            Image(step == .name ? .onboardingNameInputDefault : .onboardingBg)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    OnboardingView()
}
