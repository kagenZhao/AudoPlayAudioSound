//
//  SoundManager.swift
//  AudoPlayAudioSound
//
//  Created by Kagen Zhao on 2020/10/2.
//

import Foundation
import AVFoundation
import LaunchAtLogin

class SoundManager {
    public static let shared = SoundManager()
    public private(set) var isOpen: Bool = UserDefaults.standard.bool(forKey: "com.kagenz.AudoPlayAudioSound.isOpen")
    
    private var player: AVPlayer?
    
    private init() {
        if isOpen {
            begin()
        }
    }
    
    private var timer: Timer?
    
    public func begin() {
        end()
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: timerAction)
        _setIsOpen(true)
    }
    
    public func end() {
        timer?.invalidate()
        timer = nil
        player?.cancelPendingPrerolls()
        player?.replaceCurrentItem(with: nil)
        player = nil
        _setIsOpen(false)
    }
    
    private func timerAction(_ timer: Timer) {
        player?.cancelPendingPrerolls()
        player?.replaceCurrentItem(with: nil)
        player = nil
        if let path = Bundle.main.path(forResource: "noSound", ofType: "wav") {
            let url = URL.init(fileURLWithPath: path)
            player = AVPlayer.init(url: url)
            player?.volume = 0.1
            player?.play()
            print("播放一次")
        }
    }
    
    private func _setIsOpen(_ value: Bool) {
        guard value != isOpen else { return }
        isOpen = value
        UserDefaults.standard.setValue(value, forKey: "com.kagenz.AudoPlayAudioSound.isOpen")
    }
}
