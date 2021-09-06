//
//  AlphabetViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import UIKit

final class AlphabetViewController: UIViewController, AlphabetUserInterface {

    struct Configuration {
        let insets: UIEdgeInsets
        let spacing: CGFloat
    }

    private let alphabetView: AlphabetView
    private var viewModel: AlphabetScreenViewModel
    private let configuration: Configuration
    
    var interactor: AlphabetInteractable?

    required init(viewModel: AlphabetScreenViewModel, configuration: Configuration) {
        self.configuration = configuration
        self.viewModel = viewModel
        self.alphabetView = AlphabetView(configuration: .init(spacing: configuration.spacing),
                                         viewModel: .init(alphabet: viewModel.alphabet))
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
        view.backgroundColor = .background

        alphabetView.dataSource = self
    }

    private func setupLayout() {
        alphabetView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alphabetView)
        NSLayoutConstraint.activate([
            alphabetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: configuration.insets.top),
            alphabetView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: configuration.insets.left),
            alphabetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -configuration.insets.right),
            alphabetView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                   constant: -(view.bounds.height * 0.2))
        ])
    }

    func configure(with model: AlphabetScreenViewModel) {
        viewModel = model
        alphabetView.reload()
        configureLetterView()
    }

    private func configureLetterView() {
        let letter = interactor?.getNextLetter()
        let letterView = DraggableLetterView(letter: letter).disableAutoresizing()
        letterView.delegate = self
        view.addSubview(letterView)

        NSLayoutConstraint.activate([
            letterView.topAnchor.constraint(equalTo: alphabetView.bottomAnchor, constant: 8),
            letterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            letterView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            letterView.widthAnchor.constraint(equalTo: letterView.heightAnchor, multiplier: letter?.image?.aspectRatio ?? 1.0)
        ])
    }
}

extension AlphabetViewController: DraggableLetterViewDelegate {

    func draggableViewDidEndDragging(_ letterView: DraggableLetterView) {
        let targetLetter = alphabetView.letter(at: letterView.center)
        targetLetter == letterView.letter ? place(letterView) : letterView.reset()
    }

    private func place(_ letterView: DraggableLetterView) {
        alphabetView.place(letterView) { [weak self] in self?.interactor?.didPlaceLetter($0) }
    }
}

extension AlphabetViewController: AlphabetViewDataSource {
    func state(for letter: Letter) -> LetterView.State {
        viewModel.state(for: letter)
    }
}
