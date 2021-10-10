//
//  Optional+Foundation.swift
//  ABC
//
//  Created by Игорь Майсюк on 20.08.21.
//

import Foundation

extension Optional {
    func or(_ defaultValue: Wrapped) -> Wrapped {
        return self ?? defaultValue
    }
}
