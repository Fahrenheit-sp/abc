//
//  CGSize+Foundation.swift
//  ABC
//
//  Created by Игорь Майсюк on 25.08.21.
//

import CoreGraphics

extension CGSize {

    static func *(lhs: Self, rhs: Self) -> Self {
        CGSize(width: lhs.width * rhs.width, height: lhs.height * rhs.height)
    }

    static func *<T: BinaryFloatingPoint>(lhs: Self, rhs: T) -> Self {
        CGSize(width: lhs.width * CGFloat(rhs), height: lhs.height * CGFloat(rhs))
    }

    static func /<T: BinaryFloatingPoint>(lhs: Self, rhs: T) -> Self {
        CGSize(width: lhs.width / CGFloat(rhs), height: lhs.height / CGFloat(rhs))
    }
}
