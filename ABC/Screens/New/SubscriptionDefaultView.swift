//
//  SubscriptionDefaultView.swift
//  ABC
//
//  Created by Igor Maisiuk on 17.06.2026.
//

import SwiftUI

struct SubscriptionDefaultView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL

    @State private var selectedPlan: SubscriptionPlan = .yearly
    @State private var freeTrialEnabled = true

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Image("subscription_bg")
                    .asBackground

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        header

                        Spacer(minLength: 168)

                        titleSection

                        Spacer(minLength: 28)

                        plansSection

                        Spacer(minLength: 18)

                        footerSection
                    }
                    .frame(minHeight: proxy.size.height)
                }
            }
        }
    }

    private var header: some View {
        HStack {
            backButton

            Spacer()

            footerLink(L10n.Subscription.DefaultScreen.restorePurchase) {
                // TODO: Wire up restore purchases.
                print("Restore tapped")
            }
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
    }

    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            ZStack {
                Circle()
                    .fill(Color.grayMedium)
                    .overlay {
                        Circle()
                            .strokeBorder(.white, lineWidth: 2.5)
                    }
                    .shadow(color: .black.opacity(0.15), radius: 0, x: 0, y: 2)

                Circle()
                    .fill(Color.grayLight)
                    .padding(3.5)

                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .black, design: .rounded))
                    .foregroundStyle(.black)
                    .offset(x: -1)
            }
            .frame(width: 51, height: 51)
            .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(L10n.Subscription.DefaultScreen.back)
    }

    private var titleSection: some View {
        VStack(spacing: 12) {
            Text(L10n.Subscription.DefaultScreen.title)
                .font(.header1)
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
                .frame(maxWidth: 304)

            Text(L10n.Subscription.DefaultScreen.subtitle)
                .font(.main)
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .minimumScaleFactor(0.85)
        }
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .combine)
    }

    private var plansSection: some View {
        VStack(spacing: 16) {
            Button {
                withAnimation { freeTrialEnabled.toggle() }
            } label: {
                planCardBackground(borderColor: .white) {
                    HStack(spacing: 16) {
                        Text(freeTrialEnabled ? L10n.Subscription.DefaultScreen.freeTrialEnabled : L10n.Subscription.DefaultScreen.freeTrialDisabled)
                            .font(.main)
                            .foregroundStyle(.black)
                            .lineLimit(1)
                            .minimumScaleFactor(0.85)

                        Spacer(minLength: 12)

                        trialSwitch(isOn: freeTrialEnabled)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
            }
            .buttonStyle(.plain)
            .accessibilityLabel(freeTrialEnabled ? L10n.Subscription.DefaultScreen.freeTrialEnabled : L10n.Subscription.DefaultScreen.freeTrialDisabled)
            .accessibilityHint(L10n.Subscription.DefaultScreen.freeTrialAccessibilityHint)

            Button {
                withAnimation { selectedPlan = .yearly }
            } label: {
                planCardBackground(borderColor: selectedPlan == .yearly ? .orangePrimary : .white, badge: L10n.Subscription.DefaultScreen.bestValue) {
                    HStack(spacing: 8) {
                        planCircle(isSelected: selectedPlan == .yearly)

                        Text(L10n.Subscription.DefaultScreen.yearly)
                            .font(.main)
                            .foregroundStyle(.black)
                            .lineLimit(1)
                            .minimumScaleFactor(0.85)

                        Spacer()

                        priceText(amount: L10n.Subscription.DefaultScreen.yearlyPrice, period: L10n.Subscription.DefaultScreen.perYear)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
            }
            .buttonStyle(.plain)
            .accessibilityLabel(L10n.Subscription.DefaultScreen.yearlyAccessibilityLabel)
            .accessibilityValue(selectedPlan == .yearly ? L10n.Subscription.DefaultScreen.selected : L10n.Subscription.DefaultScreen.notSelected)
            .accessibilityHint(L10n.Subscription.DefaultScreen.selectYearlyAccessibilityHint)

            Button {
                withAnimation { selectedPlan = .monthly }
            } label: {
                planCardBackground(borderColor: selectedPlan == .monthly ? .orangePrimary : .white) {
                    HStack(spacing: 8) {
                        planCircle(isSelected: selectedPlan == .monthly)

                        Text(L10n.Subscription.DefaultScreen.monthly)
                            .font(.main)
                            .foregroundStyle(.black)
                            .lineLimit(1)
                            .minimumScaleFactor(0.85)

                        Spacer()

                        priceText(amount: L10n.Subscription.DefaultScreen.monthlyPrice, period: L10n.Subscription.DefaultScreen.perMonth)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
            }
            .buttonStyle(.plain)
            .accessibilityLabel(L10n.Subscription.DefaultScreen.monthlyAccessibilityLabel)
            .accessibilityValue(selectedPlan == .monthly ? L10n.Subscription.DefaultScreen.selected : L10n.Subscription.DefaultScreen.notSelected)
            .accessibilityHint(L10n.Subscription.DefaultScreen.selectMonthlyAccessibilityHint)
        }
        .frame(maxWidth: 354)
    }

    private func planCardBackground<Content: View>(
        borderColor: Color,
        badge: String? = nil,
        @ViewBuilder content: () -> Content
    ) -> some View {
        content()
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.grayMedium)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color.grayLight)
                            .padding(.vertical, 3)
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .strokeBorder(borderColor, lineWidth: 3)
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .strokeBorder(.white.opacity(0.25), lineWidth: 1)
                    }
                    .shadow(color: .black.opacity(0.15), radius: 0, x: 0, y: 2)
            }
            .overlay(alignment: .topTrailing) {
                if let badge {
                    Text(badge.uppercased())
                        .font(.subtext)
                        .foregroundStyle(.white)
                        .tracking(1)
                        .padding(.horizontal, 12)
                        .frame(height: 20)
                        .background {
                            Capsule(style: .continuous)
                                .fill(Color.orangePrimary)
                        }
                        .offset(x: -16, y: -12)
                }
            }
    }

    private func planCircle(isSelected: Bool) -> some View {
        ZStack {
            Circle()
                .fill(isSelected ? Color.orangePrimary : Color.white)
                .overlay {
                    Circle()
                        .strokeBorder(isSelected ? .white.opacity(0.6) : Color.grayShadow, lineWidth: 1)
                }

            if isSelected {
                Image(systemName: "checkmark")
                    .font(.system(size: 9, weight: .black, design: .rounded))
                    .foregroundStyle(.white)
                    .offset(y: -0.5)
            }
        }
        .frame(width: 27, height: 27)
        .shadow(color: .black.opacity(0.10), radius: 0, x: 0, y: 1)
    }

    private func trialSwitch(isOn: Bool) -> some View {
        ZStack(alignment: isOn ? .trailing : .leading) {
            Capsule(style: .continuous)
                .fill(
                    LinearGradient(
                        colors: isOn ? [Color(red: 0.62, green: 0.92, blue: 0.28), Color(red: 0.34, green: 0.85, blue: 0.22)] : [Color.grayShadow, Color.grayMedium],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    Capsule(style: .continuous)
                        .strokeBorder(.white.opacity(0.6), lineWidth: 0.6)
                }

            Circle()
                .fill(Color.white)
                .padding(2.6)
                .shadow(color: .black.opacity(0.12), radius: 0, x: 0, y: 1)
                .overlay {
                    if isOn {
                        Image(systemName: "checkmark")
                            .font(.system(size: 8, weight: .black, design: .rounded))
                            .foregroundStyle(Color(red: 0.24, green: 0.74, blue: 0.22))
                    }
                }
                .padding(.vertical, 2.2)
                .padding(.horizontal, 2.5)
        }
        .frame(width: 70, height: 31)
    }

    private func priceText(amount: String, period: String) -> some View {
        HStack(spacing: 0) {
            Text(amount)
                .font(.bodyBold)
                .foregroundStyle(.black)

            Text(period)
                .font(.main)
                .foregroundStyle(Color(.subscriptionPriceText))
        }
        .lineLimit(1)
        .minimumScaleFactor(0.85)
    }

    private var footerSection: some View {
        VStack(spacing: 12) {
            Text(
                freeTrialEnabled
                ? L10n.Subscription.DefaultScreen.noChargesYet
                : L10n.Subscription.DefaultScreen.cancelAnytime
            )
                .font(.body)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .minimumScaleFactor(0.8)

            MainButton(title: L10n.Subscription.DefaultScreen.subscribeCta) {
                // TODO: Wire up the subscription purchase flow.
                print("Subscribe tapped for \(selectedPlan.rawValue), free trial: \(freeTrialEnabled)")
            }

            footerLinks
        }
        .padding(.horizontal, 18)
        .padding(.bottom, 16)
    }

    private var footerLinks: some View {
        HStack(spacing: 12) {
            footerLink(L10n.Subscription.privacyPolicy) {
                openURL(Constants.privacyUrl)
            }

            footerLink(L10n.Subscription.termsOfUse) {
                openURL(Constants.termsUrl)
            }
        }
        .frame(maxWidth: .infinity)
    }

    private func footerLink(_ title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 12, weight: .regular, design: .rounded))
                .foregroundStyle(.white)
                .tracking(1)
                .lineLimit(1)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
    }
}

private enum SubscriptionPlan: String {
    case yearly
    case monthly
}

#Preview {
    SubscriptionDefaultView()
}
