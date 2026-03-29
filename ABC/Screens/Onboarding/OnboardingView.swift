//
//  OnboardingView.swift
//  ABC
//
//  Created by Igor Maisiuk on 29.03.2026.
//

import SwiftUI

struct OnboardingView: View {
    enum Step: Int {
        case first = 1
        case second
        case third
        case name
    }

    let finishAction: () -> Void

    @State private var step: Step = .first
    @AppStorage("name") private var name: String = ""

    var body: some View {
        ZStack {
            if step != .name {
                VStack {
                    Spacer()

                    initialStepsContent
                }
                .ignoresSafeArea(edges: .bottom)
                .frame(maxHeight: .infinity, alignment: .bottom)
            } else {
                VStack {
                    Spacer()

                    Text(L10n.Onboarding.Name.title)
                        .font(.header3)
                        .foregroundStyle(.black)

                    MainTextField(text: $name, placeholder: L10n.General.name)

                    Spacer()

                    MainButton(title: L10n.General.start.uppercased()) {
                        withAnimation {
                            finishAction()
                        }
                    }
                    .disabled(name.isEmpty)
                }
                .padding()
            }
        }
        .background {
            Image(step == .name ? .onboardingNameInputDefault : .onboardingBg)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private var initialStepsContent: some View {
        ZStack {
            VStack(spacing: 0) {
                Image("onboarding_cat_\(step.rawValue)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                    .offset(y: catOffsetY)
                    .zIndex(2)

                Image(.onboardingTile)
                    .resizable()
                    .scaledToFit()
                    .zIndex(1)
                    .overlay {
                        VStack(spacing: 16) {
                            Text(title)
                                .font(.header1)
                                .foregroundStyle(.black)
                                .multilineTextAlignment(.center)
                                .id(step)
                                .transition(.asymmetric(insertion: .move(edge: .trailing).combined(with: .opacity), removal: .move(edge: .leading).combined(with: .opacity)))

                            Text(subtitle)
                                .font(.main)
                                .foregroundStyle(.black)
                                .multilineTextAlignment(.center)
                                .id(step)
                                .transition(.asymmetric(insertion: .move(edge: .trailing).combined(with: .opacity), removal: .move(edge: .leading).combined(with: .opacity)))

                            PageIndicatorView(totalElements: 3, currentIndex: step.rawValue-1)
                                .frame(height: 10)
                                .padding(.vertical)

                            MainButton(title: L10n.General.next.uppercased()) {
                                withAnimation {
                                    guard step != .name else {
                                        return finishAction()
                                    }
                                    step = .init(rawValue: step.rawValue + 1)!
                                }
                            }
                        }
                        .padding()
                    }
            }
        }
    }

    private var title: String {
        switch step {
            case .first: L10n.Onboarding.First.title
            case .second: L10n.Onboarding.Second.title
            case .third: L10n.Onboarding.Third.title
            case .name: ""
        }
    }

    private var subtitle: String {
        switch step {
            case .first: L10n.Onboarding.First.subtitle
            case .second: L10n.Onboarding.Second.subtitle
            case .third: L10n.Onboarding.Third.subtitle
            case .name: ""
        }
    }

    private var catOffsetY: CGFloat {
        switch step {
            case .first: 28
            case .second: 30
            case .third: 20
            case .name: 0
        }
    }
}

#Preview {
    OnboardingView { }
}
