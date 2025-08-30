//
//  MetronomeViewModel.swift
//  Metronome
//
//  Created by ken on 2025/8/26.
//

import Foundation
import SwiftUI

class MetronomeViewModel:ObservableObject {
    @Published var model = MetronomeModel(bpm: 60)
    
    var currenBpm:Int {
        model.bpm
    }
    
    func currentModel() -> MetronomeModel {
        model
    }
    
    func add1Bpm() {
        model.bpm += 1
    }
    
    func minus1Bpm() {
        let oldValue = model.bpm
        model.bpm = max(40, model.bpm - 1)
        print("BPM changed from \(oldValue) to \(model.bpm)") // 验证值是否变化
    }
    
    func changeBPM(_ bpm:Int) {
        model.bpm = bpm
    }
    
    func togglePlaying() {
        if model.playing {
            model.audioPlayer?.pause()
        } else {
            model.audioPlayer?.play()
        }
        model.playing.toggle()
    }
    
}
