//
//  UICollection+Reusable.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import UIKit

protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: ReusableView {}
extension UITableViewHeaderFooterView: ReusableView {}
extension UICollectionReusableView: ReusableView {}


protocol NibLoadableView: AnyObject {
    static var nibName: String { get }
    static var nib: UINib { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: nibName, bundle: Bundle(for: self))
    }

    static var instantiate: Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("Could not load:\(nib), of type \(self)")
        }
        return view
    }
}
