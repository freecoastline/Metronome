//
//  MetronomeProgressView.swift
//  Metronome
//
//  Created by ken on 2025/8/30.
//

import SwiftUI

struct MetronomeProgressView: View {
    let bpmValue: Int
    
    // MARK: - Constants
    private enum Constants {
        static let minBPM: Double = 40
        static let maxBPM: Double = 230
        static let totalRange: Double = maxBPM - minBPM
        static let trackWidth: CGFloat = 320
        static let indicatorSize: CGFloat = 16
        static let trackColor = Color.metronomeProgress
        static let backgroundColor = Color.gray.opacity(0.3)
    }
    
    private var progressRatio: Double {
        let clampedBPM = max(Constants.minBPM, min(Constants.maxBPM, Double(bpmValue)))
        return (clampedBPM - Constants.minBPM) / Constants.totalRange
    }
    
    private var indicatorOffset: CGFloat {
        let halfTrack = Constants.trackWidth / 2
        return CGFloat(progressRatio * Double(Constants.trackWidth)) - halfTrack
    }
    
    var body: some View {
        ZStack {
            // Background track
            Capsule()
                .fill(Constants.backgroundColor)
                .frame(width: Constants.trackWidth, height: 4)
            
            // Progress indicator
            Circle()
                .fill(Constants.trackColor)
                .frame(width: Constants.indicatorSize, height: Constants.indicatorSize)
                .offset(x: indicatorOffset)
                .animation(.easeOut(duration: 0.2), value: indicatorOffset)
        }
    }
}


#Preview {
    MetronomeProgressView(bpmValue: 150)
}

