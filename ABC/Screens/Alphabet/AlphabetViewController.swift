//
//  AlphabetViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import UIKit

final class AlphabetScreenViewModel {

    private let alphabet: Alphabet
    private let placedLetters: [Letter]
    private var rowWidthsCache: [Int: CGFloat] = [:]

    var numberOfRows: Int {
        alphabet.numberOfRows
    }

    init(alphabet: Alphabet, placedLetters: [Letter] = []) {
        self.alphabet = alphabet
        self.placedLetters = placedLetters
    }

    func edgeInsets(for section: Int, in collectionView: UICollectionView) -> UIEdgeInsets {
        let rowWidth = calculateWidth(of: section, in: collectionView)
        guard collectionView.bounds.width > rowWidth else { return .zero }
        let sideInset = (collectionView.bounds.width - rowWidth) / 2.0
        return .init(top: 0, left: sideInset - 0.1, bottom: 0, right: sideInset - 0.1)
    }

    func numberOfLetters(in row: Int) -> Int {
        alphabet.numberOfLetters(in: row)
    }

    func widthForItem(at indexPath: IndexPath, in collectionView: UICollectionView) -> CGFloat {
        let collectionWidth = collectionView.bounds.width
        let rowWidth = calculateWidth(of: indexPath.section, in: collectionView)

        let image = alphabet.letter(at: indexPath).image
        let imageWidth = image?.size.width

        guard collectionWidth <= rowWidth else { return imageWidth.or(.zero) }

        let difference = rowWidth - collectionWidth
        let reducingAmount = (difference / CGFloat(numberOfLetters(in: indexPath.section))) + 0.1
        return imageWidth.or(.zero) - reducingAmount
    }

    func cellModel(at indexPath: IndexPath) -> AlphabetCellViewModel {
        let letter = alphabet.letter(at: indexPath)
        let isPlaced = placedLetters.contains(letter)
        return AlphabetCellViewModel(image: letter.image, tintColor: isPlaced ? nil : .lightGray)
    }

    private func calculateWidth(of row: Int, in collectionView: UICollectionView) -> CGFloat {
        if let cached = rowWidthsCache[row] { return cached }
        let imagesWidthInARow = alphabet.letters(in: row)
            .compactMap { $0.image }
            .reduce(0) { $0 + $1.size.width }
        let spacings = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)
            .map { CGFloat(numberOfLetters(in: row)-1) * $0.minimumInteritemSpacing }
            .or(.zero)
        let result = imagesWidthInARow + spacings
        rowWidthsCache[row] = result
        return result
    }
}

final class AlphabetViewController: UIViewController, AlphabetUserInterface {

    private lazy var collectionView = {
        UICollectionView(frame: .zero, collectionViewLayout: layout).disableAutoresizing()
    }()

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = UIScreen.main.bounds.width > 400 ? 8 : 0
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
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                   constant: -(view.bounds.height * 0.2))
        ])
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

extension AlphabetViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacings = layout.minimumLineSpacing * CGFloat(viewModel.numberOfRows-1)
        let height = (collectionView.bounds.height - spacings) / CGFloat(viewModel.numberOfRows)
        let width = viewModel.widthForItem(at: indexPath, in: collectionView)
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.edgeInsets(for: section, in: collectionView)
    }
}
