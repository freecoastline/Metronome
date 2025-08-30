//
//  ContentView.swift
//  Metronome
//
//  Created by ken on 2025/8/26.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel:MetronomeViewModel

    var body: some View {
        VStack {
            Spacer()
            HStack {
                TextField("number", value: $viewModel.model.bpm, format: .number)
                    .multilineTextAlignment(.center)
                    .fontDesign(.monospaced)
                    .font(.system(size: 130))
            }
            HStack {
                Spacer()
                Text("BPM").multilineTextAlignment(.center).font(.footnote)
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                MetronomeCircle(circleColor: Color.init(uiColor: .init(red: 116, green: 155, blue: 194, alpha: 1.0)), radius: 30, iconString: "minus").onTapGesture {
                        viewModel.minus1Bpm()
                    }
                MetronomeProgressView(bpmValue: viewModel.model.bpm)
                MetronomeCircle(circleColor: Color.init(uiColor: .init(red: 116, green: 155, blue: 194, alpha: 1.0)), radius: 30, iconString: "plus").onTapGesture {
                        viewModel.add1Bpm()
                }
                Spacer()
            }
            Spacer()
            ZStack(alignment: .center) {
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color.init(uiColor: .init(red: 145, green: 200, blue: 228, alpha: 1.0)))
                    .onTapGesture {
                        viewModel.togglePlaying()
                    }
                    .opacity(viewModel.model.playing ? 0 : 1)
                Image(systemName: "pause.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color.init(uiColor: .init(red: 145, green: 200, blue: 228, alpha: 1.0)))
                    .onTapGesture {
                        viewModel.togglePlaying()
                    }
                    .opacity(viewModel.model.playing ? 1 : 0)
            }

            Spacer()
        }
        .background(Color.init(uiColor: .init(red: 255, green: 251, blue: 222, alpha: 1.0)))
    }
}

#Preview {
    ContentView(viewModel: MetronomeViewModel())
}
