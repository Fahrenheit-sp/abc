//
//  AlphabetViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import UIKit

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
    private var rowWidthsCache: [Int: CGFloat] = [:]
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
        configureLetterView()
        collectionView.reloadData()
    }

    private func configureLetterView() {
        let image = viewModel.nextLetter()?.image
        let letterView = DraggableLetterView(image: image).disableAutoresizing()
        letterView.delegate = self
        view.addSubview(letterView)

        NSLayoutConstraint.activate([
            letterView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            letterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            letterView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            letterView.widthAnchor.constraint(equalTo: letterView.heightAnchor, multiplier: image?.aspectRatio ?? .zero)
        ])
    }
}

extension AlphabetViewController: DraggableLetterViewDelegate {

    func draggableViewDidEndDragging(_ view: DraggableLetterView) {
        view.reset()
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
        let width = widthForItem(at: indexPath)
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let rowWidth = calculateWidth(of: section)
        guard collectionView.bounds.width > rowWidth else { return .zero }
        let sideInset = (collectionView.bounds.width - rowWidth) / 2.0
        return .init(top: 0, left: sideInset - 0.1, bottom: 0, right: sideInset - 0.1)
    }

    private func widthForItem(at indexPath: IndexPath) -> CGFloat {
        let collectionWidth = collectionView.bounds.width
        let rowWidth = calculateWidth(of: indexPath.section)

        let image = viewModel.letter(at: indexPath).image
        let imageWidth = image?.size.width

        guard collectionWidth <= rowWidth else { return imageWidth.or(.zero) }

        let difference = rowWidth - collectionWidth
        let reducingAmount = (difference / CGFloat(viewModel.numberOfLetters(in: indexPath.section))) + 0.1
        return imageWidth.or(.zero) - reducingAmount
    }

    private func calculateWidth(of row: Int) -> CGFloat {
        if let cached = rowWidthsCache[row] { return cached }
        let imagesWidthInARow = viewModel.letters(in: row)
            .compactMap { $0.image }
            .reduce(0) { $0 + $1.size.width }
        let spacings = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)
            .map { CGFloat(viewModel.numberOfLetters(in: row)-1) * $0.minimumInteritemSpacing }
            .or(.zero)
        let result = imagesWidthInARow + spacings
        rowWidthsCache[row] = result
        return result
    }
}
