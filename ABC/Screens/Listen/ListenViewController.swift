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

    private let playButton = UIButton().disableAutoresizing()
    private let alphabetView: AlphabetView
    private let configuration: Configuration
    private var isGameStarted = false {
        didSet { alphabetView.reload(animated: true) }
    }

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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playButton.roundCornersToRound()
    }


    private func setupUI() {
        view.backgroundColor = .white

        alphabetView.delegate = self
        alphabetView.dataSource = self

        playButton.addTarget(self, action: #selector(didPressPlay), for: .touchUpInside)
        playButton.setImage(Asset.Listen.playButton.image, for: .normal)
        playButton.layer.borderWidth = 1.0
        playButton.layer.borderColor = UIColor.black.cgColor
    }

    private func setupLayout() {
        alphabetView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alphabetView)
        view.addSubview(playButton)

        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            playButton.widthAnchor.constraint(equalTo: playButton.heightAnchor),

            alphabetView.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 24),
            alphabetView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            alphabetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            alphabetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    @objc private func didPressPlay() {
        if !isGameStarted {
            isGameStarted = true
        }
        interactor?.didPressPlay()
    }
}

extension ListenViewController: ListenUserInterface {
    func configure(with model: ListenViewModel) {
        alphabetView.reload()
    }

    func handleWrongSelection(of letter: Letter) {
        print("Wrong: \(letter)")
    }

    func handleRightSelection(of letter: Letter) {
        print("Right: \(letter)")
    }
}

extension ListenViewController: AlphabetViewDataSource {
    func state(for letter: Letter) -> LetterView.State {
        isGameStarted ? .placed : .gray
    }
}

extension ListenViewController: AlphabetViewDelegate {
    func alphabetView(_ alphabetView: AlphabetView, didSelect letter: Letter) {
        interactor?.didSelect(letter: letter)
    }
}
