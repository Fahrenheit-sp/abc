//
//  AlphabetView.swift
//  ABC
//
//  Created by Игорь Майсюк on 3.09.21.
//

import UIKit

final class AlphabetView: UIView {

    struct Configuration {
        let spacing: CGFloat
    }

    private lazy var collectionView = {
        UICollectionView(frame: .zero, collectionViewLayout: layout).disableAutoresizing()
    }()

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = configuration.spacing
        return layout
    }()

    private let configuration: Configuration
    private var viewModel: AlphabetViewViewModel
    private var rowWidthsCache: [Int: CGFloat] = [:]

    weak var dataSource: AlphabetViewDataSource?
    weak var delegate: AlphabetViewDelegate?

    required init(configuration: Configuration, viewModel: AlphabetViewViewModel) {
        self.configuration = configuration
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        embedSubview(collectionView)
        
        collectionView.register(AlphabetCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false

        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func letter(at point: CGPoint) -> Letter? {
        let selfPoint = convert(point, from: superview)
        let indexPath = collectionView.indexPathForItem(at: selfPoint)
        return indexPath.map { viewModel.letter(at: $0) }
    }

    func place(_ letterView: DraggableLetterView, completion: @escaping (Letter) -> Void) {
        guard let letter = letterView.letter else { return }
        let point = convert(letterView.center, from: superview)
        guard let indexPath = collectionView.indexPathForItem(at: point) else { return }
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }

        letterView.translatesAutoresizingMaskIntoConstraints = true

        UIView.animate(withDuration: 0.3, animations: { [self] in
            letterView.frame = collectionView.convert(cell.frame, to: superview)
            letterView.layoutIfNeeded()
        }) { _ in
            letterView.removeFromSuperview()
            completion(letter)
        }
    }

    func reload(animated: Bool = false) {
        guard animated else { return collectionView.reloadData() }

        collectionView.reloadData()
        UIView.transition(with: collectionView, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
    }

    func setModel(to model: AlphabetViewViewModel, animated: Bool = true) {
        self.viewModel = model
        reload(animated: animated)
    }

    func shake(_ letter: Letter) {
        let indexPath = viewModel.indexPath(for: letter)
        collectionView.cellForItem(at: indexPath)?.shake()
    }
    
}

extension AlphabetView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfRows
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfLetters(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AlphabetCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let isPlaced = dataSource?.state(for: viewModel.letter(at: indexPath)) == .placed ? true : false
        cell.configure(with: viewModel.cellModel(at: indexPath, isPlaced: isPlaced))
        return cell
    }

}

extension AlphabetView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.alphabetView(self, didSelect: viewModel.letter(at: indexPath))
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let verticalSpacings = layout.minimumLineSpacing * CGFloat(viewModel.numberOfRows-1)
        let height = (collectionView.bounds.height - verticalSpacings) / CGFloat(viewModel.numberOfRows)
        let horizontalSpacings = layout.minimumInteritemSpacing * CGFloat(viewModel.numberOfLetters(in: indexPath.section))
        let width = UIDevice.isiPhone
            ? widthForItem(at: indexPath)
            : (collectionView.bounds.width - horizontalSpacings - 80) / CGFloat(viewModel.numberOfLetters(in: indexPath.section))
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        guard !viewModel.isAligned else { return .zero }
        guard UIDevice.isiPhone else { return .init(top: 0, left: 40, bottom: 0, right: 40) }
        let rowWidth = calculateWidth(of: section)
        guard collectionView.bounds.width > rowWidth else { return .zero }
        let sideInset = (collectionView.bounds.width - rowWidth) / 2.0
        return .init(top: layout.minimumLineSpacing / 2,
                     left: sideInset - 0.1,
                     bottom: layout.minimumLineSpacing / 2,
                     right: sideInset - 0.1)
    }

    private func widthForItem(at indexPath: IndexPath) -> CGFloat {
        guard !viewModel.isAligned else { return calculateAlignedItemWidth() }
        let collectionWidth = collectionView.bounds.width
        let rowWidth = calculateWidth(of: indexPath.section)

        let image = viewModel.letter(at: indexPath).image
        let imageWidth = image?.size.width

        guard collectionWidth <= rowWidth else { return imageWidth.or(.zero) }

        let difference = rowWidth - collectionWidth
        let reducingAmount = (difference / CGFloat(viewModel.numberOfLetters(in: indexPath.section))) + 0.1
        return imageWidth.or(.zero) - reducingAmount
    }

    private func calculateAlignedItemWidth() -> CGFloat {
        let spacings = CGFloat(viewModel.numberOfLetters(in: 0) - 1) * configuration.spacing
        return (collectionView.bounds.width - spacings - 1) / CGFloat(viewModel.numberOfLetters(in: 0))
    }

    private func calculateWidth(of row: Int) -> CGFloat {
        if let cached = rowWidthsCache[row] { return cached }
        let imagesWidthInARow = viewModel.letters(in: row)
            .compactMap { $0.image }
            .reduce(0) { $0 + $1.size.width }
        let spacings = CGFloat(viewModel.numberOfLetters(in: row)-1) * layout.minimumInteritemSpacing
        let result = imagesWidthInARow + spacings
        rowWidthsCache[row] = result
        return result
    }
}
