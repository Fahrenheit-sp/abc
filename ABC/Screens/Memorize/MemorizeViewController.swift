//
//  MemorizeViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 25.08.21.
//

import UIKit

final class MemorizeViewController: UIViewController {

    var interactor: MemorizeInteractable?

    private let backgroundImageView = UIImageView().disableAutoresizing()

    private lazy var collectionView = {
        UICollectionView(frame: .zero, collectionViewLayout: layout).disableAutoresizing()
    }()

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        return layout
    }()

    private var model = MemorizeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        interactor?.didLoad()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(backgroundImageView)
        view.addSubview(collectionView)

        backgroundImageView.image = Asset.Menu.background.image
        backgroundImageView.contentMode = .scaleAspectFill

        collectionView.register(MemorizeCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self

        let backgroundConstraints = backgroundImageView.createConstraintsForEmbedding(in: view)
        let collectionConstraints = [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ]

        NSLayoutConstraint.activate(backgroundConstraints + collectionConstraints)
    }

}

extension MemorizeViewController: MemorizeUserInterface {
    func didOpenSameLetters(at indexPaths: [IndexPath]) {
        indexPaths
            .map { collectionView.cellForItem(at: $0) }
            .compactMap { $0 as? MemorizeCollectionViewCell }
            .forEach { $0.hide() }
    }

    func didOpenWrongLetters(at indexPaths: [IndexPath]) {
        indexPaths
            .map { collectionView.cellForItem(at: $0) }
            .compactMap { $0 as? MemorizeCollectionViewCell }
            .forEach { $0.flipBack() }
    }

    func configure(with model: MemorizeViewModel) {
        self.model = model
        collectionView.reloadData()
    }

    func didFinish() {
        let confettiView = ConfettiView()
        view.addSubview(confettiView)

        confettiView.emit(with: [
          .text("🤩"),
          .text("📱"),
          .shape(.circle, .purple),
          .shape(.triangle, .orange),
        ]) { [weak self] _ in self?.interactor?.finish() }
    }
}

extension MemorizeViewController: MemorizeCellDelegate {
    func cell(_ memorizeCell: MemorizeCollectionViewCell, didFinishAnimatingTo isOpened: Bool) {
        guard let indexPath = collectionView.indexPath(for: memorizeCell) else { return }
        interactor?.didOpenLetter(at: indexPath)
    }
}

extension MemorizeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.numberOfColumns * model.numberOfRows
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MemorizeCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(with: model.cellModel(at: indexPath))
        cell.delegate = self
        return cell
    }

}

extension MemorizeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacingsWidth = layout.minimumInteritemSpacing * CGFloat(model.numberOfColumns-1)
        let width = (collectionView.bounds.width - spacingsWidth) / CGFloat(model.numberOfColumns)

        let spacingsHeight = layout.minimumLineSpacing * CGFloat(model.numberOfRows-1)
        let height = (collectionView.bounds.height - spacingsHeight) / CGFloat(model.numberOfRows)

        return CGSize(width: width-1, height: height-1)
    }
}
