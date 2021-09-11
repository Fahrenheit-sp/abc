//
//  SubscribeViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 8.09.21.
//

import UIKit

struct SubscribeScreenViewModel {
    let priceString: String
}

final class SubscribeViewController: UIViewController {

    private let imageView = UIImageView().disableAutoresizing()
    private let restoreButton = UIButton().disableAutoresizing()
    private let closeButton = UIButton().disableAutoresizing()
    private let gradient = GradientBackgroundView().disableAutoresizing()
    private let titleLabel = UILabel().disableAutoresizing()
    private let featuresStack = UIStackView().disableAutoresizing()
    private let priceLabel = UILabel().disableAutoresizing()

    private let termsButton = UIButton().disableAutoresizing()
    private let andLabel = UILabel().disableAutoresizing()
    private let privacyButton = UIButton().disableAutoresizing()

    private let spinner = UIActivityIndicatorView(style: .whiteLarge).disableAutoresizing()

    private lazy var termsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [termsButton, andLabel, privacyButton]).disableAutoresizing()
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()

    private let subscribeButton = UIButton().disableAutoresizing()
    private let moreOptionsButton = UIButton().disableAutoresizing()

    var interactor: SubscribeInteractable?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupUI()

        interactor?.didLoad()
    }

    private func setupLayout() {
        view.addSubview(imageView)
        view.addSubview(restoreButton)
        view.addSubview(closeButton)
        view.addSubview(gradient)
        view.addSubview(titleLabel)
        view.addSubview(featuresStack)
        view.addSubview(priceLabel)
        view.addSubview(termsStack)
        view.addSubview(subscribeButton)
        view.addSubview(moreOptionsButton)
        view.addSubview(spinner)

        let offset: CGFloat = UIDevice.isiPhone ? 16 : 32

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),

            restoreButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            restoreButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.heightAnchor.constraint(equalToConstant: 44),

            gradient.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            gradient.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradient.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradient.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: offset),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset),

            featuresStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: offset),
            featuresStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            featuresStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset),

            priceLabel.topAnchor.constraint(equalTo: featuresStack.bottomAnchor, constant: offset),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset),

            termsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            termsStack.topAnchor.constraint(equalTo: subscribeButton.bottomAnchor, constant: 12),

            subscribeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subscribeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            subscribeButton.heightAnchor.constraint(equalToConstant: 60),
            subscribeButton.bottomAnchor.constraint(equalTo: moreOptionsButton.topAnchor, constant: -offset),

            moreOptionsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            moreOptionsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),

            spinner.topAnchor.constraint(equalTo: view.topAnchor),
            spinner.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            spinner.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            spinner.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func setupUI() {
        imageView.image = Asset.Subscription.subscriptionBackground.image

        let restore = NSAttributedString(string: L10n.Subscription.restore,
                                             attributes: [.foregroundColor: UIColor.background,
                                                          .font: UIFont.systemFont(ofSize: UIDevice.isiPhone ? 15 : 17, weight: .medium)])
        restoreButton.setAttributedTitle(restore, for: .normal)
        restoreButton.addTarget(self, action: #selector(restoreTapped), for: .touchUpInside)

        closeButton.setImage(Asset.Icons.close.image, for: .normal)
        closeButton.imageEdgeInsets = .init(top: 12, left: 12, bottom: 12, right: 12)
        closeButton.tintColor = .background
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)

        gradient.configureGradient(using: .init(colors: [.subscribeGradientStart, .white],
                                                startPoint: .init(x: 0.5, y: 0),
                                                endPoint: .init(x: 0.5, y: 1)))

        titleLabel.font = .systemFont(ofSize: UIScreen.isIphoneEightOrLess ? 27 : 33, weight: .semibold)
        titleLabel.textColor = .background
        titleLabel.text = L10n.Subscription.title
        titleLabel.adjustsFontSizeToFitWidth = true

        featuresStack.axis = .vertical
        featuresStack.alignment = .leading
        featuresStack.spacing = UIDevice.isiPhone ? 8 : 16

        [L10n.Subscription.freeUpdates, L10n.Subscription.noAds, L10n.Subscription.fullAccess].map {
            let view = SubscriptionFeatureView().disableAutoresizing()
            view.setText(to: $0)
            return view
        }.forEach { featuresStack.addArrangedSubview($0) }

        priceLabel.font = .systemFont(ofSize: UIScreen.isIphoneEightOrLess ? 15 : 17)
        priceLabel.textColor = .subscriptionPriceText

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

        subscribeButton.roundCornersToRound()
        subscribeButton.backgroundColor = .subscriptionGreen

        let tryFree = NSAttributedString(string: L10n.Subscription.tryFreeAndSubscribe,
                                         attributes: [.foregroundColor: UIColor.white,
                                                      .font: UIFont.systemFont(ofSize: UIDevice.isiPhone ? 15 : 17, weight: .semibold)])
        subscribeButton.setAttributedTitle(tryFree, for: .normal)
        subscribeButton.addTarget(self, action: #selector(subscribeTapped), for: .touchUpInside)

        let moreOptions = NSAttributedString(string: L10n.Subscription.moreBillingOptions,
                                             attributes: [.foregroundColor: UIColor.subscriptionRed,
                                                          .font: UIFont.systemFont(ofSize: 13, weight: .semibold)])
        moreOptionsButton.setAttributedTitle(moreOptions, for: .normal)
        moreOptionsButton.addTarget(self, action: #selector(moreOptionsTapped), for: .touchUpInside)
        #warning("Enable in next updates")
        moreOptionsButton.isHidden = true

        spinner.backgroundColor = .subscribeBlue.withAlphaComponent(0.5)
    }

    @objc private func closeTapped() {
        interactor?.didClose()
    }

    @objc private func restoreTapped() {
        startSpinner()
        interactor?.didRestore()
    }

    @objc private func termsTapped() {
        interactor?.didTapTerms()
    }

    @objc private func privacyTapped() {
        interactor?.didTapPrivacy()
    }

    @objc private func subscribeTapped() {
        startSpinner()
        interactor?.didTapBuyMain()
    }

    @objc private func moreOptionsTapped() {
        #warning("Add more options")
        print("More options tapped")
    }

    private func startSpinner() {
        spinner.startAnimating()
    }

    private func endSpinner() {
        spinner.stopAnimating()
    }
}

extension SubscribeViewController: SubscribeUserInterface {
    func configure(with model: SubscribeScreenViewModel) {
        priceLabel.text = model.priceString
    }

    func didCancelPurchase() {
        endSpinner()
    }

    func didFailPurchase(with message: String) {
        endSpinner()
        presentAlert(using: .init(message: message))
    }
}
