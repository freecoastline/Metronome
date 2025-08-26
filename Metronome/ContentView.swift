//
//  ContentView.swift
//  Metronome
//
//  Created by ken on 2025/8/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        @State var bpm = ""
        
        VStack {
            TextField("BPM", text: $bpm)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
