//
//  SoundPlayer.swift
//  ABC
//
//  Created by Игорь Майсюк on 3.09.21.
//

import AVFoundation

final class LetterSoundPlayer {

    private var player: AVAudioPlayer?
    private let queue = DispatchQueue(label: UUID().uuidString, qos: .userInteractive)

    init() {
        try? AVAudioSession.sharedInstance().setCategory(.playback)
    }

    deinit {
        try? AVAudioSession.sharedInstance().setCategory(.soloAmbient)
    }

    func playLetterSound(named name: String) {
        queue.async { self.play(name) }
    }

    private func play(_ name: String) {
        do {
            guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else { return }
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Unable to play sound: \(name). \(error.localizedDescription)")
        }
    }
}
