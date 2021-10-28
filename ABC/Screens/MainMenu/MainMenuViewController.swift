//
//  MainMenuViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import UIKit

struct MainMenuScreenViewModel {
    private let items: [MainMenuItem]
    let isSubscribeAvailable: Bool

    init(items: [MainMenuItem], isSubscribeAvailable: Bool) {
        self.items = items
        self.isSubscribeAvailable = isSubscribeAvailable
    }

    var cellModels: [MainMenuCellViewModel] {
        items.map { MainMenuCellViewModel(title: $0.title, image: $0.image.image) }
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
        let spacing: CGFloat = UIDevice.isiPhone ? 16.0 : 40.0
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing / 2.0
        layout.sectionInset = .init(top: 0, left: spacing, bottom: 0, right: spacing)
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

        collectionView.registerView(SubscribeHeaderReusableView.self, ofKind: UICollectionView.elementKindSectionHeader)
        collectionView.register(MainMenuCollectionViewCell.self)
        collectionView.backgroundColor = .clear

        collectionView.dataSource = self
        collectionView.delegate = self

        backgroundImageView.image = Asset.Menu.background.image
        backgroundImageView.contentMode = .scaleAspectFill
        
        titleImageView.image = Asset.Menu.abc.image
        titleImageView.contentMode = .scaleAspectFit
    }

    private func setupLayout() {
        view.addSubview(backgroundImageView)
        view.addSubview(titleImageView)
        view.addSubview(collectionView)

        let backgoundConstraints = backgroundImageView.createConstraintsForEmbedding(in: view)
        let titleConstraints = [
            titleImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.11)
        ]

        let collectionConstraints = [
            collectionView.topAnchor.constraint(equalTo: titleImageView.bottomAnchor,
                                                constant: UIDevice.isiPhone ? 8 : 40),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ]

        NSLayoutConstraint.activate(backgoundConstraints + titleConstraints + collectionConstraints)
    }

    func configure(with model: MainMenuScreenViewModel) {
        cellModels = model.cellModels
        let headerHeight: CGFloat = UIDevice.isiPhone ? 70 : 120
        layout.headerReferenceSize = model.isSubscribeAvailable ? CGSize(width: collectionView.bounds.width, height: headerHeight) : .zero
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

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let header: SubscribeHeaderReusableView = collectionView.dequeueReusableView(ofKind: UICollectionView.elementKindSectionHeader, forIndexPath: indexPath)
        header.delegate = self
        return header
    }
}

extension MainMenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.didSelectItem(at: indexPath)
    }
    

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let divider: CGFloat = UIDevice.isiPhone ? 2 : 3
        let halfWidth = collectionView.bounds.width / divider
        let itemWIdth = halfWidth - layout.minimumInteritemSpacing - layout.sectionInset.left
        return CGSize(width: itemWIdth, height: itemWIdth)
    }
}

extension MainMenuViewController: SubscribeHeaderViewDelegate {
    func subscribeHeaderViewDidTap() {
        interactor?.didPressSubscribe()
    }
}
