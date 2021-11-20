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

protocol PicturesStorable {
    func getPictures() -> [Picture]
}

final class WordsStorage {

    private let wordsFilename = "words"
    private let picturesFilename = "pictures"
    private let fileExtension = ".txt"

    private var words: [Word] = []
    private var pictures: [Picture] = []

    static let shared = WordsStorage()

}

extension WordsStorage: WordsStorable {
    func getWords() -> [Word] {
        guard words.isEmpty else { return words }
        guard let path = Bundle.main.url(forResource: wordsFilename, withExtension: fileExtension) else { return words }
        do {
            let string = try String(contentsOf: path).replacingOccurrences(of: "\r", with: String.empty)
            words = string.components(separatedBy: String.newline).filter {!$0.isEmpty}.map { Word(string: $0) }
            return words
        } catch {
            print("Failed to decode words: \(error.localizedDescription)")
            return words
        }
    }
}

extension WordsStorage: PicturesStorable {
    func getPictures() -> [Picture] {
        guard pictures.isEmpty else { return pictures }
        guard let path = Bundle.main.url(forResource: picturesFilename, withExtension: .empty) else { return pictures }
        do {
            let string = try String(contentsOf: path)
            pictures = string.components(separatedBy: String.newline).filter {!$0.isEmpty}.map { Picture(title: $0) }
            return pictures
        } catch {
            print("Failed to decode pictures: \(error.localizedDescription)")
            return pictures
        }
    }
}
