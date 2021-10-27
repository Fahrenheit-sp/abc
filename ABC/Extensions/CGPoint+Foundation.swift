//
//  CGPoint+Foundation.swift
//  ABC
//
//  Created by Игорь Майсюк on 22.08.21.
//

import CoreGraphics

extension CGPoint {

    static func +(lhs: Self, rhs: Self) -> Self {
        .init(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    static func -(lhs: Self, rhs: Self) -> Self {
        .init(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    func distance(to: CGPoint) -> CGFloat {
        return (self.x - to.x) * (self.x - to.x) + (self.y - to.y) * (self.y - to.y)
    }
}
