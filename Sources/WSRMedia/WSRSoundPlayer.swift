//
//  WSRSoundPlayer.swift
//  WSR
//
//  Created by William Rena on 7/27/24.
//  Copyright © 2024 Personal. All rights reserved.
//

import AVFoundation

public class WSRSoundPlayer {
    public struct WSRSound {
        let fileName: String
        let fileExtension: String

        public init(name: String, withExtension fileExtension: String) {
            self.fileName = name
            self.fileExtension = fileExtension
        }

        public var url: URL? {
            return Bundle.main.url(forResource: fileName, withExtension: fileExtension)
        }
    }

    private var sound: WSRSound
    private var audioPlayer: AVAudioPlayer?
    private var enabled: Bool

    public init(sound: WSRSound, enabled: Bool = true, numberOfLoops: Int = 0) {
        self.sound = sound
        self.enabled = enabled

        self.audioPlayer = try! AVAudioPlayer(contentsOf: sound.url!)
        self.audioPlayer?.numberOfLoops = numberOfLoops
    }

    public func play() {
        guard enabled else { return }

        audioPlayer?.currentTime = 0
        audioPlayer?.play()
    }

    public func stop() {
        audioPlayer?.stop()
    }
}
