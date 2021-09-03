//
//  ListenViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 3.09.21.
//

import UIKit

final class ListenViewController: UIViewController {

    struct Configuration {
        let spacing: CGFloat
    }

    private let alphabetView: AlphabetView
    private let configuration: Configuration

    var interactor: ListenInteractable?

    init(model: ListenViewModel, configuration: Configuration) {
        self.configuration = configuration
        self.alphabetView = AlphabetView(configuration: .init(spacing: configuration.spacing),
                                         viewModel: .init(alphabet: model.alphabet))
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()

        interactor?.didLoad()
    }

    private func setupUI() {
        view.backgroundColor = .white

        alphabetView.delegate = self
        alphabetView.dataSource = self
    }

    private func setupLayout() {
        alphabetView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alphabetView)

        NSLayoutConstraint.activate([
            alphabetView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            alphabetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            alphabetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            alphabetView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }

}

extension ListenViewController: ListenUserInterface {
    func configure(with model: ListenViewModel) {
        alphabetView.reload()
    }
}

extension ListenViewController: AlphabetViewDataSource {
    func state(for letter: Letter) -> LetterView.State {
        .placed
    }
}

extension ListenViewController: AlphabetViewDelegate {
    func alphabetView(_ alphabetView: AlphabetView, didSelect letter: Letter) {
        print("Selected: \(letter)")
    }
}
