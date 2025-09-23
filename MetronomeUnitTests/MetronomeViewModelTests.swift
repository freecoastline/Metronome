//
//  MetronomeViewModelTests.swift
//  MetronomeUITests
//
//  Created by ken on 2025/8/26.
//

import XCTest
@testable import Metronome

final class MetronomeViewModelTests: XCTestCase {

    @MainActor
    func testBPMClampingValidation() throws {
        let viewModel = MetronomeViewModel()

        // Test minimum boundary
        viewModel.setBPM(30)
        XCTAssertEqual(viewModel.bpm, 40, "BPM should be clamped to minimum of 40")

        // Test maximum boundary
        viewModel.setBPM(300)
        XCTAssertEqual(viewModel.bpm, 230, "BPM should be clamped to maximum of 230")

        // Test valid range
        viewModel.setBPM(120)
        XCTAssertEqual(viewModel.bpm, 120, "Valid BPM should be set correctly")
    }

    @MainActor
    func testBPMIncrementDecrement() throws {
        let viewModel = MetronomeViewModel()
        let initialBPM = 60

        // Set initial value
        viewModel.setBPM(initialBPM)
        XCTAssertEqual(viewModel.bpm, initialBPM)

        // Test increment
        viewModel.increaseBPM()
        XCTAssertEqual(viewModel.bpm, initialBPM + 1, "BPM should increase by 1")

        // Test decrement
        viewModel.decreaseBPM()
        XCTAssertEqual(viewModel.bpm, initialBPM, "BPM should decrease by 1")
    }

    @MainActor
    func testBPMBoundaryIncrementDecrement() throws {
        let viewModel = MetronomeViewModel()

        // Test increment at maximum boundary
        viewModel.setBPM(230)
        viewModel.increaseBPM()
        XCTAssertEqual(viewModel.bpm, 230, "BPM should not exceed maximum")

        // Test decrement at minimum boundary
        viewModel.setBPM(40)
        viewModel.decreaseBPM()
        XCTAssertEqual(viewModel.bpm, 40, "BPM should not go below minimum")
    }

    @MainActor
    func testInitialState() throws {
        let viewModel = MetronomeViewModel()

        XCTAssertEqual(viewModel.bpm, 60, "Initial BPM should be 60")
        XCTAssertEqual(viewModel.isPlaying, false, "Initially should not be playing")
        XCTAssertEqual(viewModel.isAudioReady, false, "Audio should not be ready initially")
    }
}
