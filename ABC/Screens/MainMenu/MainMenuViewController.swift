//
//  MainMenuViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import UIKit

struct MainMenuScreenViewModel {
    private let items: [MainMenuItem]

    init(items: [MainMenuItem]) {
        self.items = items
    }

    var cellModels: [MainMenuCellViewModel] {
        #warning("Image")
        return items.map { MainMenuCellViewModel(title: $0.title, image: UIImage()) }
    }
}

final class MainMenuViewController: UIViewController, MainMenuUserInterface {

    private let backgroundImageView = UIImageView().disableAutoresizing()
    private let titleImageView = UIImageView().disableAutoresizing()

    private lazy var collectionView = {
        UICollectionView(frame: .zero, collectionViewLayout: layout).disableAutoresizing()
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16.0
        layout.minimumInteritemSpacing = 8.0
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        return layout
    }()

    private var cellModels: [MainMenuCellViewModel] = []
    var interactor: MainMenuInteractable?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()

        interactor?.didLoad()
    }

    private func setupUI() {
        view.backgroundColor = .white

        collectionView.register(MainMenuCollectionViewCell.self)
        collectionView.backgroundColor = .clear

        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func setupLayout() {
        view.addSubview(backgroundImageView)
        view.addSubview(titleImageView)
        view.addSubview(collectionView)

        let backgoundConstraints = backgroundImageView.createConstraintsForEmbedding(in: view)
        let titleConstraints = [
            titleImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15)
        ]

        let collectionConstraints = [
            collectionView.topAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 8)
        ]

        NSLayoutConstraint.activate(backgoundConstraints + titleConstraints + collectionConstraints)
    }

    func configure(with model: MainMenuScreenViewModel) {
        cellModels = model.cellModels
        collectionView.reloadData()
    }
}

extension MainMenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MainMenuCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(with: cellModels[indexPath.row])
        return cell
    }
}

extension MainMenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.didSelectItem(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let halfWidth = collectionView.bounds.width / 2
        let itemWIdth = halfWidth - layout.minimumInteritemSpacing - layout.sectionInset.left
        return CGSize(width: itemWIdth, height: itemWIdth)
    }
}
