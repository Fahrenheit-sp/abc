//
//  WordsStorage.swift
//  ABC
//
//  Created by Игорь Майсюк on 26.08.21.
//

import Foundation

protocol WordsStorable {
    func getWords() -> [Word]
}

final class WordsStorage: WordsStorable {

    private let filename = "words"
    private let fileExtension = ".txt"

    private var words: [Word] = []

    static let shared = WordsStorage()

    func getWords() -> [Word] {
        guard words.isEmpty else { return words }
        guard let path = Bundle.main.url(forResource: filename, withExtension: fileExtension) else { return words }
        do {
            let string = try String(contentsOf: path).replacingOccurrences(of: "\r", with: String.empty)
            words = string.components(separatedBy: String.newline).map { Word(string: $0) }
            return words
        } catch {
            print("Failed to decode words: \(error.localizedDescription)")
            return words
        }
    }
}
