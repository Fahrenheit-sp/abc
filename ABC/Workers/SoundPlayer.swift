//
//  SoundPlayer.swift
//  ABC
//
//  Created by Игорь Майсюк on 7.09.21.
//

import AVFoundation

final class SoundPlayer {

    private var player: AVAudioPlayer?
    private let queue = DispatchQueue(label: "com.fahrenheit.player")

    private static let winUrl = Bundle.main.url(forResource: "win", withExtension: "wav")
    private static let letterUrl = Bundle.main.url(forResource: "letter_placed", withExtension: "mp3")
    private static let cardUrl = Bundle.main.url(forResource: "card", withExtension: "mp3")
    private static let swooshUrl = Bundle.main.url(forResource: "swoosh", withExtension: "wav")
    private static let errorUrl = Bundle.main.url(forResource: "error", withExtension: "mp3")

    func playWinSound() {
        queue.async { self.playSound(at: Self.winUrl) }
    }

    func playLetterPlacedSound() {
        queue.async { self.playSound(at: Self.letterUrl) }
    }

    func playCardSound() {
        queue.async { self.playSound(at: Self.cardUrl) }
    }

    func playSwooshSound() {
        queue.async { self.playSound(at: Self.swooshUrl) }
    }

    func playErrorSound() {
        queue.async { self.playSound(at: Self.errorUrl) }
    }

    private func playSound(at url: URL?) {
        do {
            guard let url = url else { return }
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Unable to play sound at: \(String(describing: url)). \(error.localizedDescription)")
        }
    }
}
