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

        interactor?.didLoad()
    }

    private func setupLayout() {
        view.addSubview(closeButton)
        view.addSubview(annualView)

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.heightAnchor.constraint(equalToConstant: 44),

            annualView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 16),
            annualView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            annualView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            monthlyView.topAnchor.constraint(equalTo: annualView.bottomAnchor, constant: 16),
            monthlyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            monthlyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    private func setupUI() {
        closeButton.setImage(Asset.Icons.close.image, for: .normal)
        closeButton.imageEdgeInsets = .init(top: 12, left: 12, bottom: 12, right: 12)
        closeButton.tintColor = .background
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
    }

    @objc private func closeTapped() {
        interactor?.didClose()
    }

}

extension MoreBillingOptionsViewController: MoreBillingOptionsUserInterface {
    func configure(with model: MoreBillingOptionsViewModel) {

    }

    func didCancelPurchase() {

    }

    func didFailPurchase(with message: String) {
        
    }

}
