//
//  NSObject+Foundation.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import Foundation

extension NSObject {
    var classBundle: Bundle {
        return Bundle(for: type(of: self))
    }
}
