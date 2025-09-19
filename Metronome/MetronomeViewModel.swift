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
        if (model.bpm > 230) {
            return
        }
        model.bpm += 1
        updatePlayRate()
    }
    
    func updatePlayRate() {
        model.audioPlayer?.rate = Float(model.bpm) / 60.0
    }
    
    func minus1Bpm() {
        let oldValue = model.bpm
        model.bpm = max(40, model.bpm - 1)
        updatePlayRate()
        print("BPM changed from \(oldValue) to \(model.bpm)") // 验证值是否变化
    }
    
    func changeBPM(_ bpm:Int) {
        if bpm < 40 {
            model.bpm = 40
        } else if bpm > 230 {
            model.bpm = 230
        } else {
            model.bpm = bpm
        }
    }
    
    func togglePlaying() {
        DispatchQueue.main.async {
            if self.model.playing {
                self.model.audioPlayer?.pause()
            } else {
                self.model.audioPlayer?.play()
            }
            self.model.playing.toggle()
        }
    }
    
}
