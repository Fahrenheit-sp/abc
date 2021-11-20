//
//  SoundPlayer.swift
//  ABC
//
//  Created by Игорь Майсюк on 7.09.21.
//

import AVFoundation

final class SoundPlayer {

    private var player: AVAudioPlayer?
    private let queue = DispatchQueue(label: UUID().uuidString, qos: .userInteractive)

    private static let musicUrl = Bundle.main.url(forResource: "music", withExtension: "mp3")
    private static let winUrl = Bundle.main.url(forResource: "win", withExtension: "wav")
    private static let letterUrl = Bundle.main.url(forResource: "letter_placed", withExtension: "mp3")
    private static let cardUrl = Bundle.main.url(forResource: "card", withExtension: "mp3")
    private static let swooshUrl = Bundle.main.url(forResource: "swoosh", withExtension: "wav")
    private static let errorUrl = Bundle.main.url(forResource: "error", withExtension: "mp3")
    private static let ufoUrl = Bundle.main.url(forResource: "ufo", withExtension: "mp3")
    private static let rocketUrl = Bundle.main.url(forResource: "rocket", withExtension: "wav")

    init() {
        try? AVAudioSession.sharedInstance().setCategory(.playback)
    }

    func pause() {
        player?.pause()
    }

    func resume() {
        player?.play()
    }

    func playMainMenuSound() {
        queue.async {
            self.playSound(at: Self.musicUrl, volume: 0.01)
            self.player?.numberOfLoops = -1
        }
    }

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

    func playUfoSound() {
        queue.async { self.playSound(at: Self.ufoUrl) }
    }

    func playRocketSound() {
        queue.async { self.playSound(at: Self.rocketUrl) }
    }

    private func playSound(at url: URL?, volume: Float = 1.0) {
        do {
            guard let url = url else { return }
            player = try AVAudioPlayer(contentsOf: url)
            player?.volume = volume
            player?.play()
        } catch {
            print("Unable to play sound at: \(String(describing: url)). \(error.localizedDescription)")
        }
    }
}
