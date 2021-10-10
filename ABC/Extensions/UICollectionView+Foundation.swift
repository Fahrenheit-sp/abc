//
//  UICollectionView+Foundation.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }

    func register<T: UICollectionViewCell>(_: T.Type) where T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: classBundle)
        register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }

    func registerView<T: UICollectionReusableView>(_: T.Type, ofKind kind: String) {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.defaultReuseIdentifier)
    }

    func dequeueReusableView<T: UICollectionReusableView>(ofKind: String, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: ofKind,
                                                          withReuseIdentifier: T.defaultReuseIdentifier,
                                                          for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }

    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }

}
