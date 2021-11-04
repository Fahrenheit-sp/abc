//
//  CatchLetterSelectionViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 4.11.21.
//

import UIKit

final class CatchLetterSelectionViewController: UIViewController {

    private let leftButton = UIButton().disableAutoresizing()
    private let rightButton = UIButton().disableAutoresizing()
    private let letterView = LetterView().disableAutoresizing()
    private let selectButton = UIButton().disableAutoresizing()

    var interactor: CatchLetterSelectionInteractable?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        setupInteractions()

        interactor?.didLoad()
    }

    private func setupUI() {
        view.backgroundColor = .background

        view.addSubview(leftButton)
        view.addSubview(rightButton)
        view.addSubview(letterView)
        view.addSubview(selectButton)

        leftButton.setImage(Asset.Icons.left.image, for: .normal)
        rightButton.setImage(Asset.Icons.right.image, for: .normal)

        selectButton.backgroundColor = .subscriptionGreen
        let title = NSAttributedString(string: L10n.General.start.uppercased(),
                                       attributes: [.font: UIFont.current(size: 32, weight: .semibold),
                                                    .foregroundColor: UIColor.white])
        selectButton.setAttributedTitle(title, for: .normal)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            leftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIDevice.isiPhone ? 20 : 40),
            leftButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            leftButton.widthAnchor.constraint(equalToConstant: UIDevice.isiPhone ? 52 : 80),
            leftButton.heightAnchor.constraint(equalTo: leftButton.widthAnchor),

            letterView.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor, constant: 24),
            letterView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            letterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            letterView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),

            rightButton.widthAnchor.constraint(equalToConstant: UIDevice.isiPhone ? 52 : 80),
            rightButton.heightAnchor.constraint(equalTo: rightButton.widthAnchor),
            rightButton.leadingAnchor.constraint(equalTo: letterView.trailingAnchor, constant: 24),
            rightButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: UIDevice.isiPhone ? -20 : -40),

            selectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            selectButton.heightAnchor.constraint(equalToConstant: UIDevice.isiPhone ? 60 : 80),
            selectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                 constant: UIDevice.isiPhone ? -20 : -40),
        ])

        selectButton.roundCornersToRound()
    }

    private func setupInteractions() {
        leftButton.addTarget(self, action: #selector(leftTapped), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightTapped), for: .touchUpInside)
        selectButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
    }

    @objc private func leftTapped() {
        interactor?.onPreviousLetterTap()
    }

    @objc private func rightTapped() {
        interactor?.onNextLetterTap()
    }

    @objc private func startTapped() {
        interactor?.onLetterSelected()
    }
}

extension CatchLetterSelectionViewController: CatchLetterSelectionUserInterface {

    func configure(with letterModel: LetterViewModel) {
        letterView.configure(with: letterModel)
    }
}
