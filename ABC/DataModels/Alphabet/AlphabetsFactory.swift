//
//  AlphabetsFactory.swift
//  ABC
//
//  Created by Игорь Майсюк on 22.08.21.
//

import Foundation

final class AlphabetsFactory {

    enum AlphabetType: String {
        case english
        case numbers
    }

    private static var alphabetsCache: [AlphabetType: Alphabet] = [:]

    private init() {}

    static func getAlphabet(_ type: AlphabetType, shuffled: Bool = false) -> Alphabet {
        if let cached = alphabetsCache[type] {
            return cached
        }
        let alphabet: Alphabet
        switch type {
        case .english: alphabet = English(isShuffled: shuffled)
        case .numbers: alphabet = Numbers(isShuffled: shuffled)
        }

        alphabetsCache[type] = alphabet
        return alphabet
    }
}
