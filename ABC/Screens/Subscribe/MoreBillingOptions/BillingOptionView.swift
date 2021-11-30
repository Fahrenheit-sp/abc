//
//  BillingOptionView.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.10.21.
//

import UIKit

protocol BillingOptionViewDelegate: AnyObject {
    func billingOptionViewDidBecomeSelected(_ billingOptionView: BillingOptionView)
}

final class BillingOptionView: UIView {

    private let contentView = RoundedShadowView().disableAutoresizing()
    private let trialView = RoundedShadowView().disableAutoresizing()
    private let trialLabel = UILabel().disableAutoresizing()
    private let titleLabel = UILabel().disableAutoresizing()
    private let priceLabel = UILabel().disableAutoresizing()
    private let subtitleLabel = UILabel().disableAutoresizing()
    private let checkmarkView = CheckmarkView().disableAutoresizing()

    weak var delegate: BillingOptionViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.configuration = .init(cornerRadius: 16,
                                          shadowColor: .darkGray,
                                          shadowOpacity: 0.3,
                                          shadowOffset: .init(width: 4, height: 4),
                                          shadowRadius: 8)

        trialView.configuration = .init(cornerRadius: 17,
                                        shadowColor: .darkGray,
                                        shadowOpacity: 0.3,
                                        shadowOffset: .init(width: 2, height: 2),
                                        shadowRadius: 8)

        titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = .gray

        trialLabel.font = .systemFont(ofSize: 15, weight: .bold)
        trialLabel.textColor = .subscriptionRed

        priceLabel.font = .systemFont(ofSize: 28, weight: .semibold)
        priceLabel.textColor = .black

        subtitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        subtitleLabel.textColor = .lightGray
    }

    private func setupLayout() {
        addSubview(contentView)
        addSubview(trialView)
        trialView.addSubview(trialLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(checkmarkView)


        let content = contentView.createConstraintsForEmbedding(in: self)
        let trial = [
            trialView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            trialView.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        ]
        let trialLabelConstraints = [
            trialLabel.centerYAnchor.constraint(equalTo: trialView.centerYAnchor),
            trialLabel.centerXAnchor.constraint(equalTo: trialView.centerXAnchor),
            trialLabel.topAnchor.constraint(equalTo: trialView.topAnchor, constant: 8),
            trialLabel.leadingAnchor.constraint(equalTo: trialView.leadingAnchor, constant: 16)
        ]
        let title = [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ]
        let price = [
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: checkmarkView.leadingAnchor, constant: -16)
        ]
        let subtitle = [
            subtitleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ]
        let checkmark = [
            checkmarkView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            checkmarkView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkView.widthAnchor.constraint(equalToConstant: 24),
            checkmarkView.heightAnchor.constraint(equalToConstant: 24)
        ]
        NSLayoutConstraint.activate(content + trial + trialLabelConstraints + title + price + subtitle + checkmark)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        delegate?.billingOptionViewDidBecomeSelected(self)
    }

    func configure(with model: BillingOption) {
        titleLabel.text = model.title
        priceLabel.text = model.price
        subtitleLabel.text = model.subtitle
        checkmarkView.isOn = model.isSelected
        trialView.isHidden = model.trialText == nil
        trialLabel.text = model.trialText
    }
}
