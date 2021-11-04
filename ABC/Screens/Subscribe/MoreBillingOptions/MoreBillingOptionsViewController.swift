//
//  MoreBillingOptionsViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.10.21.
//

import UIKit

final class MoreBillingOptionsViewController: UIViewController {

    var interactor: MoreBillingOptionsInteractable?

    private let closeButton = UIButton().disableAutoresizing()
    private let annualView = BillingOptionView().disableAutoresizing()
    private let monthlyView = BillingOptionView().disableAutoresizing()

    private let descriptionLabel = UILabel().disableAutoresizing()
    private let subscribeButton = UIButton().disableAutoresizing()
    private let termsView = TermsAndPrivacyView().disableAutoresizing()

    private let spinner = UIActivityIndicatorView(style: .whiteLarge).disableAutoresizing()

    override func loadView() {
        let gradient = GradientBackgroundView()
        gradient.configureGradient(using: .init(colors: [.subscribeGradientStart, .white],
                                                startPoint: .init(x: 0.5, y: 0),
                                                endPoint: .init(x: 0.5, y: 1)))
        view = gradient
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupUI()
        setupInteraction()

        interactor?.didLoad()
    }

    private func setupLayout() {
        view.addSubview(closeButton)
        view.addSubview(annualView)
        view.addSubview(monthlyView)
        view.addSubview(descriptionLabel)
        view.addSubview(subscribeButton)
        view.addSubview(termsView)
        view.addSubview(spinner)

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.heightAnchor.constraint(equalToConstant: 44),

            annualView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 24),
            annualView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            annualView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            monthlyView.topAnchor.constraint(equalTo: annualView.bottomAnchor, constant: 16),
            monthlyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            monthlyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            subscribeButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            subscribeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            subscribeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subscribeButton.heightAnchor.constraint(equalToConstant: 60),

            termsView.topAnchor.constraint(equalTo: subscribeButton.bottomAnchor, constant: 16),
            termsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            termsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),

            spinner.topAnchor.constraint(equalTo: view.topAnchor),
            spinner.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            spinner.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            spinner.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupUI() {
        closeButton.setImage(Asset.Icons.close.image, for: .normal)
        closeButton.imageEdgeInsets = .init(top: 12, left: 12, bottom: 12, right: 12)
        closeButton.tintColor = .darkGray

        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.textColor = .lightGray
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0

        subscribeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        subscribeButton.roundCornersToRound()
        subscribeButton.backgroundColor = .subscriptionGreen
        let subscribe = NSAttributedString(string: L10n.Menu.Item.subscribe,
                                         attributes: [.foregroundColor: UIColor.white,
                                                      .font: UIFont.systemFont(ofSize: 17, weight: .semibold)])
        subscribeButton.setAttributedTitle(subscribe, for: .normal)

        spinner.backgroundColor = .subscribeBlue.withAlphaComponent(0.5)
    }

    private func setupInteraction() {
        annualView.delegate = self
        monthlyView.delegate = self

        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        subscribeButton.addTarget(self, action: #selector(subscribeTapped), for: .touchUpInside)
    }

    @objc private func closeTapped() {
        interactor?.didClose()
    }

    @objc private func subscribeTapped() {
        startSpinner()
        interactor?.didPressSubscribe()
    }

    private func startSpinner() {
        spinner.startAnimating()
    }

    private func endSpinner() {
        spinner.stopAnimating()
    }
}

extension MoreBillingOptionsViewController: MoreBillingOptionsUserInterface {
    func configure(with model: MoreBillingOptionsViewModel) {
        model.mainBillingOption.map { annualView.configure(with: $0) }
        model.secondaryBillingOption.map { monthlyView.configure(with: $0) }
        descriptionLabel.text = model.description
    }

    func didCancelPurchase() {
        endSpinner()
    }

    func didFailPurchase(with message: String) {
        endSpinner()
        presentAlert(using: .init(message: message))
    }

}

extension MoreBillingOptionsViewController: BillingOptionViewDelegate {
    func billingOptionViewDidBecomeSelected(_ billingOptionView: BillingOptionView) {
        let isMain = billingOptionView == annualView
        isMain ? interactor?.didSelectMain() : interactor?.didSelectSecondary()
    }
}
