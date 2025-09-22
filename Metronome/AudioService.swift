//
//  AudioService.swift
//  Metronome
//
//  Created by ken on 2025/8/26.
//

import Foundation
import AVFoundation

/// Service responsible for managing metronome audio playback
actor AudioService {
    // MARK: - Properties
    private var audioPlayer: AVAudioPlayer?
    private let audioFileName = "woodenFish"
    private let audioFileExtension = "m4a"
    
    // MARK: - Public Interface
    
    /// Initializes the audio service and prepares audio for playback
    /// - Returns: True if audio setup was successful, false otherwise
    func initialize() async -> Bool {
        await configureAudioSession()
        return await setupAudioPlayer()
    }
    
    /// Starts audio playback
    func play() async {
        audioPlayer?.play()
    }
    
    /// Pauses audio playback
    func pause() async {
        audioPlayer?.pause()
    }
    
    /// Stops audio playback
    func stop() async {
        audioPlayer?.stop()
    }
    
    /// Updates the playback rate based on BPM
    /// - Parameter bpm: Beats per minute
    func updatePlaybackRate(bpm: Int) async {
        audioPlayer?.rate = Float(bpm) / 60.0
    }
    
    /// Checks if audio is ready for playback
    /// - Returns: True if audio player is ready, false otherwise
    func isReady() async -> Bool {
        audioPlayer != nil
    }
    
    // MARK: - Private Methods
    
    private func configureAudioSession() async {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default, options: [.allowAirPlay])
            try session.setActive(true)
        } catch {
            print("Failed to configure audio session: \(error)")
        }
    }
    
    private func setupAudioPlayer() async -> Bool {
        guard let soundURL = Bundle.main.url(
            forResource: audioFileName,
            withExtension: audioFileExtension
        ) else {
            print("Audio file not found: \(audioFileName).\(audioFileExtension)")
            return false
        }
        
        do {
            let player = try AVAudioPlayer(contentsOf: soundURL)
            player.prepareToPlay()
            player.numberOfLoops = -1
            player.enableRate = true
            player.rate = 1.0
            
            audioPlayer = player
            return true
        } catch {
            print("Failed to initialize audio player: \(error)")
            return false
        }
    }
}