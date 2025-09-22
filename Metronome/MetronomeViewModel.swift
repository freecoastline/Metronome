//
//  MetronomeViewModel.swift
//  Metronome
//
//  Created by ken on 2025/8/26.
//

import Foundation
import SwiftUI
import AVFoundation

@MainActor
class MetronomeViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published private(set) var bpm: Int = 60 {
        didSet {
            updatePlayRate()
        }
    }
    @Published private(set) var isPlaying: Bool = false
    @Published private(set) var isAudioReady: Bool = false
    
    // MARK: - Constants
    private enum Constants {
        static let minBPM = 40
        static let maxBPM = 230
        static let defaultBPM = 60
        static let audioFileName = "woodenFish"
        static let audioFileExtension = "m4a"
    }
    
    // MARK: - Private Properties
    private var audioPlayer: AVAudioPlayer?
    private let audioQueue = DispatchQueue(label: "com.metronome.audio", qos: .userInteractive)
    
    // MARK: - Initialization
    init() {
        setupAudio()
    }
    
    deinit {
        cleanup()
    }
    
    // MARK: - Public Methods
    func increaseBPM() {
        setBPM(bpm + 1)
    }
    
    func decreaseBPM() {
        setBPM(bpm - 1)
    }
    
    func setBPM(_ newBPM: Int) {
        let clampedBPM = max(Constants.minBPM, min(Constants.maxBPM, newBPM))
        if clampedBPM != bpm {
            bpm = clampedBPM
        }
    }
    
    func togglePlayback() {
        guard isAudioReady else { return }
        
        audioQueue.async { [weak self] in
            guard let self = self else { return }
            
            if self.isPlaying {
                self.audioPlayer?.pause()
            } else {
                self.audioPlayer?.play()
            }
            
            DispatchQueue.main.async {
                self.isPlaying.toggle()
            }
        }
    }
    
    // MARK: - Private Methods
    private func setupAudio() {
        audioQueue.async { [weak self] in
            self?.configureAudioSession()
            self?.initializeAudioPlayer()
        }
    }
    
    private func configureAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default, options: [.allowAirPlay])
            try session.setActive(true)
        } catch {
            print("Failed to configure audio session: \(error)")
        }
    }
    
    private func initializeAudioPlayer() {
        guard let soundURL = Bundle.main.url(forResource: Constants.audioFileName, 
                                           withExtension: Constants.audioFileExtension) else {
            print("Audio file not found: \(Constants.audioFileName).\(Constants.audioFileExtension)")
            return
        }
        
        do {
            let player = try AVAudioPlayer(contentsOf: soundURL)
            player.prepareToPlay()
            player.numberOfLoops = -1
            player.enableRate = true
            player.rate = Float(bpm) / 60.0
            
            audioPlayer = player
            
            DispatchQueue.main.async {
                self.isAudioReady = true
            }
        } catch {
            print("Failed to initialize audio player: \(error)")
        }
    }
    
    private func updatePlayRate() {
        audioQueue.async { [weak self] in
            guard let self = self else { return }
            self.audioPlayer?.rate = Float(self.bpm) / 60.0
        }
    }
    
    private func cleanup() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
}
