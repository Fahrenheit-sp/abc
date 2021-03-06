//
//  WordsSpeaker.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.10.21.
//

import AVFoundation

final class WordsSpeaker {

    private let speaker = AVSpeechSynthesizer()

    func speak(word: String) {
        let utterance = AVSpeechUtterance(string: word)
        utterance.voice = AVSpeechSynthesisVoice(language: "en")

        speaker.speak(utterance)
    }

    func speak(words: [String]) {
        speak(word: words.joined(separator: .space))
    }
}
