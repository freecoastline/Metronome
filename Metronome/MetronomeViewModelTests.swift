//
//  MetronomeViewModelTests.swift
//  MetronomeTests
//
//  Created by ken on 2025/8/26.
//

import Testing
@testable import Metronome

@Suite("Metronome ViewModel Tests")
struct MetronomeViewModelTests {
    
    @MainActor
    @Test("BPM clamping validation")
    func bpmClampingValidation() async throws {
        let viewModel = MetronomeViewModel()
        
        // Test minimum boundary
        viewModel.setBPM(30)
        #expect(viewModel.bpm == 40, "BPM should be clamped to minimum of 40")
        
        // Test maximum boundary
        viewModel.setBPM(300)
        #expect(viewModel.bpm == 230, "BPM should be clamped to maximum of 230")
        
        // Test valid range
        viewModel.setBPM(120)
        #expect(viewModel.bpm == 120, "Valid BPM should be set correctly")
    }
    
    @MainActor
    @Test("BPM increment and decrement")
    func bpmIncrementDecrement() async throws {
        let viewModel = MetronomeViewModel()
        let initialBPM = 60
        
        // Set initial value
        viewModel.setBPM(initialBPM)
        #expect(viewModel.bpm == initialBPM)
        
        // Test increment
        viewModel.increaseBPM()
        #expect(viewModel.bpm == initialBPM + 1, "BPM should increase by 1")
        
        // Test decrement
        viewModel.decreaseBPM()
        #expect(viewModel.bpm == initialBPM, "BPM should decrease by 1")
    }
    
    @MainActor
    @Test("BPM boundary increment and decrement")
    func bpmBoundaryIncrementDecrement() async throws {
        let viewModel = MetronomeViewModel()
        
        // Test increment at maximum boundary
        viewModel.setBPM(230)
        viewModel.increaseBPM()
        #expect(viewModel.bpm == 230, "BPM should not exceed maximum")
        
        // Test decrement at minimum boundary
        viewModel.setBPM(40)
        viewModel.decreaseBPM()
        #expect(viewModel.bpm == 40, "BPM should not go below minimum")
    }
    
    @MainActor
    @Test("Initial state")
    func initialState() async throws {
        let viewModel = MetronomeViewModel()
        
        #expect(viewModel.bpm == 60, "Initial BPM should be 60")
        #expect(viewModel.isPlaying == false, "Initially should not be playing")
        #expect(viewModel.isAudioReady == false, "Audio should not be ready initially")
    }
}
