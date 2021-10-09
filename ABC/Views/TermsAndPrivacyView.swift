//
//  TermsAndPrivacyView.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.10.21.
//

import UIKit

final class TermsAndPrivacyView: UIView {

    private let termsButton = UIButton().disableAutoresizing()
    private let andLabel = UILabel().disableAutoresizing()
    private let privacyButton = UIButton().disableAutoresizing()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let termsAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.subscriptionPriceText,
                                                              .font: UIFont.systemFont(ofSize: 11, weight: .regular)]
        let terms = NSAttributedString(string: L10n.Subscription.termsOfUse, attributes: termsAttributes)
        termsButton.setAttributedTitle(terms, for: .normal)
        termsButton.addTarget(self, action: #selector(termsTapped), for: .touchUpInside)

        andLabel.font = .systemFont(ofSize: 12, weight: .regular)
        andLabel.textColor = .subscriptionPrivacy
        andLabel.text = L10n.General.and

        let privacy = NSAttributedString(string: L10n.Subscription.privacyPolicy, attributes: termsAttributes)
        privacyButton.setAttributedTitle(privacy, for: .normal)
        privacyButton.addTarget(self, action: #selector(privacyTapped), for: .touchUpInside)
    }

    private func setupLayout() {
        let stack = UIStackView(arrangedSubviews: [termsButton, andLabel, privacyButton])
        stack.axis = .horizontal
        stack.spacing = 4
        embedSubview(stack)
    }

    @objc private func privacyTapped() {
        UIApplication.shared.open(Constants.privacyUrl, options: [:], completionHandler: nil)
    }

    @objc private func termsTapped() {
        UIApplication.shared.open(Constants.termsUrl, options: [:], completionHandler: nil)
    }

}
