//
//  ContentView.swift
//  Metronome
//
//  Created by ken on 2025/8/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MetronomeViewModel()
    @FocusState private var isBPMFieldFocused: Bool
    @State private var bpmTextInput: String = ""
    
    // MARK: - Theme
    private enum Theme {
        static let backgroundColor = Color.metronomeBackground
        static let controlColor = Color.metronomeControl
        static let playButtonColor = Color.metronomePlayButton
        static let primaryFontSize: CGFloat = 130
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // BPM Display and Input
            bpmInputSection
            
            Spacer()
            
            // Control Section
            controlSection
            
            Spacer()
            
            // Play/Pause Button
            playPauseButton
            
            Spacer()
        }
        .background(Theme.backgroundColor)
        .onAppear {
            bpmTextInput = String(viewModel.bpm)
        }
        .onChange(of: viewModel.bpm) { _, newBPM in
            if !isBPMFieldFocused {
                bpmTextInput = String(newBPM)
            }
        }
    }
    
    // MARK: - View Components
    @ViewBuilder
    private var bpmInputSection: some View {
        VStack(spacing: 8) {
            TextField("BPM", text: $bpmTextInput)
                .multilineTextAlignment(.center)
                .fontDesign(.monospaced)
                .font(.system(size: Theme.primaryFontSize, weight: .medium))
                .keyboardType(.numberPad)
                .focused($isBPMFieldFocused)
                .onSubmit {
                    updateBPMFromText()
                }
                .onChange(of: isBPMFieldFocused) { _, isFocused in
                    if !isFocused {
                        updateBPMFromText()
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            isBPMFieldFocused = false
                        }
                        .fontWeight(.semibold)
                    }
                }
            
            Text("BPM")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
    
    @ViewBuilder
    private var controlSection: some View {
        HStack(spacing: 30) {
            // Decrease BPM Button
            MetronomeCircle(
                circleColor: Theme.controlColor,
                radius: 30,
                iconString: "minus"
            )
            .onTapGesture {
                viewModel.decreaseBPM()
                provideFeedback()
            }
            
            // Progress Indicator
            MetronomeProgressView(bpmValue: viewModel.bpm)
            
            // Increase BPM Button
            MetronomeCircle(
                circleColor: Theme.controlColor,
                radius: 30,
                iconString: "plus"
            )
            .onTapGesture {
                viewModel.increaseBPM()
                provideFeedback()
            }
        }
    }
    
    @ViewBuilder
    private var playPauseButton: some View {
        Button(action: {
            viewModel.togglePlayback()
            provideFeedback()
        }) {
            Image(systemName: viewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(viewModel.isAudioReady ? Theme.playButtonColor : .gray)
        }
        .disabled(!viewModel.isAudioReady)
        .scaleEffect(viewModel.isPlaying ? 1.1 : 1.0)
        .animation(.easeInOut(duration: 0.1), value: viewModel.isPlaying)
    }
    
    // MARK: - Helper Methods
    private func updateBPMFromText() {
        if let bpm = Int(bpmTextInput) {
            viewModel.setBPM(bpm)
        } else {
            // Reset to current viewModel value if invalid input
            bpmTextInput = String(viewModel.bpm)
        }
    }
    
    private func provideFeedback() {
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
    }
}

#Preview {
    ContentView()
}
