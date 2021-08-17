//
//  AlphabetViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import UIKit

struct AlphabetScreenViewModel {

    private let alphabet: Alphabet
    private let placedLetters: [Letter]

    var numberOfRows: Int {
        alphabet.numberOfRows
    }

    init(alphabet: Alphabet, placedLetters: [Letter] = []) {
        self.alphabet = alphabet
        self.placedLetters = placedLetters
    }

    func numberOfLetters(in row: Int) -> Int {
        alphabet.numberOfLetters(in: row)
    }

    func cellModel(at indexPath: IndexPath) -> AlphabetCellViewModel {
        let letter = alphabet.letter(at: indexPath)
        let isPlaced = placedLetters.contains(letter)
        return AlphabetCellViewModel(image: letter.image, tintColor: isPlaced ? nil : .lightGray)
    }

}

final class AlphabetViewController: UIViewController, AlphabetUserInterface {

    private lazy var collectionView = {
        UICollectionView(frame: .zero, collectionViewLayout: layout).disableAutoresizing()
    }()

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        return layout
    }()

    private var viewModel: AlphabetScreenViewModel
    var interactor: AlphabetInteractable?

    required init(viewModel: AlphabetScreenViewModel) {
        self.viewModel = viewModel
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

        collectionView.register(AlphabetCollectionViewCell.self)
        collectionView.backgroundColor = .clear

        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func setupLayout() {
        view.embedSubview(collectionView)
    }

    func configure(with model: AlphabetScreenViewModel) {
        self.viewModel = model
        collectionView.reloadData()
    }
}

extension AlphabetViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfRows
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfLetters(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AlphabetCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(with: viewModel.cellModel(at: indexPath))
        return cell
    }


}

extension AlphabetViewController: UICollectionViewDelegate {

}
