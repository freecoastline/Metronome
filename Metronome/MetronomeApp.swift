//
//  MetronomeApp.swift
//  Metronome
//
//  Created by ken on 2025/8/26.
//

import SwiftUI

@main
struct MetronomeApp: App {
    @StateObject var metronome = MetronomeViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: metronome)
        }
    }
}
